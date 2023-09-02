resource "aws_elasticache_subnet_group" "myec" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_parameter_group" "myec" {
  name   = var.parameter_group_name
  family = "redis6.x"
}

resource "aws_elasticache_cluster" "myec" {
  cluster_id      = var.cluster_id
  engine          = "redis"
  engine_version  = "6.x"
  node_type       = var.node_type
  num_cache_nodes = var.num_cache_nodes
  port            = 6379

  subnet_group_name    = aws_elasticache_subnet_group.myec.name
  parameter_group_name = aws_elasticache_parameter_group.myec.name
}
