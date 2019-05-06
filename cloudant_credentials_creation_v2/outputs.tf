#####################################################################
##
##      Created 4/9/19 by Ago for IBM Cloudant_credentials_creation
##
#####################################################################


output "apikey" {
  #value = "${data.external.com_output.result["apikey"]}"
  value = "${camc_scriptpackage.apikey.result.stdout}"
}

output "host" {
  #value = "${data.external.com_output.result["apikey"]}"
  value = "${camc_scriptpackage.host.result.stdout}"
}

output "iam_apikey_description" {
  #value = "${data.external.com_output.result["apikey"]}"
  value = "${camc_scriptpackage.iam_apikey_description.result.stdout}"
}

output "iam_apikey_name" {
  #value = "${data.external.com_output.result["apikey"]}"
  value = "${camc_scriptpackage.iam_apikey_name.result.stdout}"
}

output "password" {
  #value = "${data.external.com_output.result["apikey"]}"
  value = "${camc_scriptpackage.password.result.stdout}"
}

output "port" {
  #value = "${data.external.com_output.result["apikey"]}"
  value = "${camc_scriptpackage.port.result.stdout}"
}

output "url" {
  #value = "${data.external.com_output.result["apikey"]}"
  value = "${camc_scriptpackage.url.result.stdout}"
}

output "username" {
  #value = "${data.external.com_output.result["apikey"]}"
  value = "${camc_scriptpackage.username.result.stdout}"
}
