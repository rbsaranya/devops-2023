output "cache_cluster_endpoint" {
  description = "Endpoint for the created ElastiCache cluster"
  value       = aws_elasticache_cluster.myec.cache_nodes[0].address
}
