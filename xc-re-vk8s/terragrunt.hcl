include "root" {
  path = find_in_parent_folders()
}

include "appstack-lab" {
  path = find_in_parent_folders("appstack-lab.hcl")
}

include "virtual-k8s" {
  path = find_in_parent_folders("virtual-k8s.hcl")
}

inputs = {

}
