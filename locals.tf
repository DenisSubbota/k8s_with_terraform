# Also you may use local variable to combine 2 variable inside one 
locals {
    denis_full_name_variable = "${var.denis_name_variable}-${var.denis_lastname_variable}"
   #denis_project = 
} 
# and to address to this variable inside the file you may use local.denis_full_name_variable and local.denis_project 