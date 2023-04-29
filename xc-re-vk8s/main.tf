resource "volterra_virtual_k8s" "vk8s" {
  name = format("%s-vk8s", var.projectPrefix)
  namespace = var.namespace
  vsite_refs {
    name      = var.virtual_site_name
    namespace = "shared"
  }
}

resource "volterra_k8s_cluster_role_binding" "bind" {
  name      = format("%s-vk8s-cluster-rolebinding", var.projectPrefix)
  namespace = "system"

  k8s_cluster_role {
    name      = "ves-io-admin-cluster-role"
    namespace = "shared"
    tenant    = "ves-io"
  }

  subjects {
    // One of the arguments from this list "user service_account group" must be set
    user = var.useremail
  }
}

resource "volterra_k8s_cluster_role" "role" {
  name      = format("%s-vk8s-cluster-role", var.projectPrefix)
  namespace = "system"

  // One of the arguments from this list "policy_rule_list k8s_cluster_role_selector yaml" must be set
  policy_rule_list {
    policy_rule {
      // One of the arguments from this list "resource_list non_resource_url_list" must be set
      // TBD: determine the minimum required access for this to work
      resource_list {
        verbs              = ["*"]
        api_groups         = ["*"]
        resource_types     = ["*"]
        resource_instances = ["*"]
      }
    }
  }
}

resource "volterra_k8s_cluster" "cluster" {
  name      = format("%s-k8s-cluster", var.projectPrefix)
  namespace = "system"

  no_cluster_wide_apps              = true
  use_default_cluster_role_bindings = false
  use_default_cluster_roles         = false
  use_custom_cluster_role_list {
    cluster_roles {
      namespace = "system"
      name      = "admin"
    }
    cluster_roles {
      namespace = "system"
      name      = "ves-io-psp-permissive"
    }
    cluster_roles {
      namespace = "system"
      name      = "ves-io-admin-cluster-role"
    }
    cluster_roles {
      namespace = "system"
      name      = volterra_k8s_cluster_role.role.name
    }
  }
  use_custom_cluster_role_bindings {
    cluster_role_bindings {
      namespace = "system"
      name      = "admin"
    }
    cluster_role_bindings {
      namespace = "system"
      name      = "ves-io-admin-cluster-role-binding"
    }
    cluster_role_bindings {
      namespace = "shared"
      name      = "ves-io-psp-permissive"
    }
    cluster_role_bindings {
      namespace = "system"
      name      = volterra_k8s_cluster_role_binding.bind.name
    }
  }


  // One of the arguments from this list "cluster_scoped_access_permit cluster_scoped_access_deny" must be set
  cluster_scoped_access_permit = true
  global_access_enable         = true
  no_insecure_registries       = true

  local_access_config {
    local_domain = format("%s.local", var.projectPrefix)
    default_port = true
  }
  use_default_psp = true
}