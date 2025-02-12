variable "vpc_id" {
  description = "The ID of the VPC where the ALB and target groups will be deployed"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs where the ALB will be deployed"
  type        = list(string)
}

variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
  default  = "my-app-alb"
}

variable "domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
}

variable "alb_security_group_name" {
  description = "Name of the security group for ALB"
  type        = string
  default     = "app-alb-sg"
}
