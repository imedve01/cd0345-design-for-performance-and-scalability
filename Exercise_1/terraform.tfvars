variable "existing_vpc_id" {
  description = "The ID of the existing VPC"
  type        = string
}

variable "existing_public_subnet_id" {
  description = "The ID of the existing public subnet"
  type        = string
}

existing_vpc_id           = "vpc-0ebcee1b5c1877d50"
existing_public_subnet_id = "subnet-043b771cb4a0fb577"

