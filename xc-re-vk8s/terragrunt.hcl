include "root" {
  path = find_in_parent_folders()
}

include "appstack-lab" {
  path = find_in_parent_folders("appstack-lab.hcl")
}

inputs = {

}
