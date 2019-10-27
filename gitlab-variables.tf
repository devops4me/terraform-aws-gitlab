
######## ################## ########
######## Optional Variables ########
######## ################## ########

/*
 | --
 | -- If you are using an IAM role as the AWS access mechanism then
 | -- pass it as in_role_arn commonly through an environment variable
 | -- named TF_VAR_in_role_arn in addition to the usual AWS access
 | -- key, secret key and default region parameters.
 | --
*/
variable in_role_arn {
    description = "The optional role arn to use if your AWS access mechanism is via IAM roles."
    default     = ""
    type        = string
}


######## ################### ########
######## Mandatory Variables ########
######## ################### ########

/*
variable in_vpc_id             { description = "The ID of the existing VPC in which to create the subnet network."  }
variable in_vpc_cidr           { description = "The CIDr block defines the range of VPC allocable IP addresses."    }
variable in_subnets_max        { description = "Two to the power of subnets_max is the carvable subnets quantity."  }
variable in_subnet_offset      { description = "The number of subnets to skip over in the existing VPC."            }
variable in_gateway_id         { description = "The internet gateway ID of the existing VPC for routing traffic."   }
variable in_ssh_public_key     { description = "The public SSH key for accessing the secure shell of the instance." }
variable in_safe_local_db_id   { description = "The id of the local safe database."                                 }
variable in_safe_remote_db_id  { description = "The id of the remote safe database."                                }
variable in_safe_book_name     { description = "The name of the safe database book."                                }
variable in_safe_book_password { description = "The password of the safe database book."                            }
variable in_dot_username       { description = "The username to the dot (devops task platform."                     }
variable in_dot_password       { description = "The password to the dot (devops task platform."                     }
variable in_dot_repo_path      { description = "The dot repository url, group name and repository name."            }
variable in_dot_fullname       { description = "The full name of she who talks to the dot platform."                }
variable in_dot_email_address  { description = "The email address of she who talks to the platform."                }
variable in_ecosystem_name     { description = "Creational name stamp denoting the class of this eco-system."       }
*/
