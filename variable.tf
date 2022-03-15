variable "ports" {
  type = list(number)
}
variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}

# RDS variables 
variable "allocated_storage" {
  type = number
}
variable "engine" {
  type = string
}
variable "engine_version" {
  type = string
}
variable "instance_class" {
  type = string
}
variable "db_name" {
  type = string
}
variable "username" {
  type = string
}
variable "password" {
  type = string
}
variable "multi_az" {
  type = bool
}
variable "port" {
  type = number
}
variable "publicly_accessible" {
  type = bool
}
variable "storage_type" {
  type = string
}
