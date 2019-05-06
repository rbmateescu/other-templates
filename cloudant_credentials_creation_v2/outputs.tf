#####################################################################
##
##      Created 4/9/19 by Ago for IBM Cloudant_credentials_creation
##
#####################################################################

output "remote_script_stdout" {
  value = "${camc_scriptpackage.CreateScript.result}"
}

output "apikey" {
  value = "${lookup(camc_scriptpackage.CreateScript.result, "apikey")}"
}

