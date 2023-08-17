# variable.tf is default file to store the vairables
# to refer value you just need to specify var.denis_name_variable
# to combine 2 variables you may use "${var.denis_name_variable}-${var.denis_lastname_variable}

variable "instance-type" {
    default = "t2.large"
}

variable "ami-centos" {
  default = "ami-002070d43b0a4f171"
}

variable "ami-ubuntu" {
  default = "ami-0261755bbcb8c4a84"
}