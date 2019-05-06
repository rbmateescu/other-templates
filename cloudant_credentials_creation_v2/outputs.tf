#####################################################################
##
##      Created 4/9/19 by Ago for IBM Cloudant_credentials_creation
##
#####################################################################

output "remote_script_stdout" {
  value = "${data.external.com_output.result}"
}

output "apikey" {
  value = "${data.external.com_output.result["apikey"]}"
}

