variable "common_tags" {
  description = "This is to help you add tags to your cloud objects"
  type        = map(any)
}

variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}


variable "frontend_id" {
  type = string
}

variable "backend_id" {
  type = string
}

variable "public_ip" {
  type = string
}
