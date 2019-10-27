
######## ######################################### ######
######## This Terraform Module's Output Variables. ######
######## ######################################### ######

output public_ip_addresses {
    value  = "${ module.ec2-instance.out_public_ip_addresses }"
}
