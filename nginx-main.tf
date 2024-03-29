
/*
 | --
 | -- If you are using an IAM role as the AWS access mechanism then
 | -- pass it as in_role_arn commonly through an environment variable
 | -- named TF_VAR_in_role_arn in addition to the usual AWS access
 | -- key, secret key and default region parameters.
 | --
*/
provider aws {
    dynamic assume_role {
        for_each = length( var.in_role_arn ) > 0 ? [ var.in_role_arn ] : [] 
        content {
            role_arn = assume_role.value
	}
    }
}


### ---> ###################### <--- ### || < ####### > || ###
### ---> ---------------------- <--- ### || < ------- > || ###
### ---> Instance Layer Modules <--- ### || < Layer I > || ###
### ---> ---------------------- <--- ### || < ------- > || ###
### ---> ###################### <--- ### || < ####### > || ###

module ec2-instance {
    source                  = "github.com/devops4me/terraform-aws-ec2-instances"

    in_node_count           = 1
    in_user_data            = data.template_file.cloud_config.rendered
    in_iam_instance_profile = module.ec2-instance-profile.out_instance_profile_id
    in_ssh_public_key       = var.in_ssh_public_key

    in_ami_id               = data.aws_ami.ubuntu-1804.id
    in_subnet_ids           = [ element ( module.vpc-network.out_public_subnet_ids, 0 ) ]
    in_security_group_ids   = [ module.security-group.out_security_group_id ]

    in_ecosystem   = local.ecosystem_name
    in_timestamp   = var.in_timestamp
}


module ec2-instance-profile {

    source = "github.com/devops4me/terraform-aws-ec2-role-profile"

    in_ec2_policy_stmts = data.template_file.iam_policy_stmts.rendered
    in_ecosystem_name   = local.ecosystem_name
    in_tag_timestamp    = var.in_timestamp
}


### ---> ##################### <--- ### || < ####### > || ###
### ---> --------------------- <--- ### || < ------- > || ###
### ---> Network Layer Modules <--- ### || < Layer N > || ###
### ---> --------------------- <--- ### || < ------- > || ###
### ---> ##################### <--- ### || < ####### > || ###

module vpc-network {

    source  = "devops4me/vpc-network/aws"
    version = "~> 1.0.2"

    in_vpc_cidr            = "10.82.0.0/16"
    in_num_public_subnets  = 1
    in_num_private_subnets = 0

    in_ecosystem   = local.ecosystem_name
    in_timestamp   = var.in_timestamp

}


module security-group {

    source     = "github.com/devops4me/terraform-aws-security-group"
    in_ingress = [ "http", "https", "ssh" ]
    in_vpc_id  = module.vpc-network.out_vpc_id

    in_ecosystem   = local.ecosystem_name
    in_timestamp   = var.in_timestamp

}

################################################################################################
################################################################################################


locals {

    ecosystem_name = "nginx-webserver"
    timestamp = formatdate( "YYMMDDhhmmss", timestamp() )
    date_time = formatdate( "EEEE DD-MMM-YY hh:mm:ss ZZZ", timestamp() )
    description = "was created by Apollo Akora on ${ local.date_time }."
}
