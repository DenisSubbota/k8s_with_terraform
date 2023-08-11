# variable.tf is default file to store the vairables
# to refer value you just need to specify var.denis_name_variable
# to combine 2 variables you may use "${var.denis_name_variable}-${var.denis_lastname_variable}

variable "denis_name_variable" {
    default = "Denis"
}

variable "denis_lastname_variable" {
  default = "Subbota"
}

