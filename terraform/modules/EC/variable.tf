ivariable "subnet_group_name" {
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
}

variable "parameter_group_name" {
  type        = string
}

variable "cluster_id" {
  type        = string
}

variable "node_type" {
  type        = string
  default     = "cache.t2.micro"
}

variable "num_cache_nodes" {
  type        = number
  default     = 1
}
