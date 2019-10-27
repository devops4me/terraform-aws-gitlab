
######## ########################### ######
######## The terraform data objects. ######
######## ########################### ######

/*
 | --
 | -- This cloud config yaml is responsible for the configuration management
 | -- (through user data) of the ec2 instance (or instances).
 | --
 | -- The documentation for cloud-config directives and their parameters can
 | -- be found through this link.
 | --
 | --
 | --     https://cloudinit.readthedocs.io/en/latest/index.html
 | --
*/
data template_file cloud_config {

    template = file( "${path.module}/cloud-config.yaml" )

    vars {
        safe_local_db_id   = "${ var.in_safe_local_db_id }"
        safe_remote_db_id  = "${ var.in_safe_remote_db_id }"
        safe_book_name     = "${ var.in_safe_book_name }"
        safe_book_password = "${ var.in_safe_book_password }"

        dot_username       = "${ var.in_dot_username }"
        dot_password       = "${ var.in_dot_password }"
        dot_repo_path      = "${ var.in_dot_repo_path }"
        dot_fullname       = "${ var.in_dot_fullname }"
        dot_email_address  = "${ var.in_dot_email_address }"
    }
}


data template_file iam_policy_stmts {
    template = file( "${path.module}/chatterbox-policies.json" )
}


data aws_ami ubuntu-1804 {

    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = [ "hvm" ]
    }

    owners = ["099720109477"]
}
