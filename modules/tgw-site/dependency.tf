output xcmesh {
  value = data.aws_instances.xcmesh
}

output public_ips {
  value = data.aws_instances.xcmesh.public_ips
}

output private_ips {
  value = data.aws_instances.xcmesh.private_ips
}

