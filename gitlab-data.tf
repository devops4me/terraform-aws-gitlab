
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

    vars = {
        gitlab_volume_bucket_name = "gitlab.volume.bucket"
    }
}


data template_file iam_policy_stmts {
    template = file( "${path.module}/gitlab-policies.json" )
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
