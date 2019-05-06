####################################################################
##
##      Created 4/9/19 by Ago for IBM Cloudant_credentials_creation
##
#####################################################################

provider "null" {
  version = "~> 0.1"
}


resource "random_string" "random-dir" {
  length  = 8
  special = false
}

resource "null_resource" "create-temp-random-dir" {
  provisioner "local-exec" {
    command = "${format("mkdir -p  /tmp/%s" , "${random_string.random-dir.result}")}"
  }
}

resource "null_resource" "ibmcli_vm" {
  connection {
    host = "${var.vm_address}"
    type = "ssh"
    user = "${var.ssh_user}"
    password = "${var.ssh_user_password}"
    }

provisioner "file" {
    content = <<EOF
#!/bin/bash
#
export BLUEMIX_API_KEY=${var.bluemix_key}
ibmcloud config --check-version=false > /tmp/create_cloudant_credentials.log 2>&1
ibmcloud login -a https://cloud.ibm.com -r us-south >> /tmp/create_cloudant_credentials.log 2>&1
ibmcloud target --cf-api https://api.us-south.cf.cloud.ibm.com -o agostino.colussi -s Test >> /tmp/create_cloudant_credentials.log 2>&1
ibmcloud service key-create ${var.service_name} ${var.service_credentials_name} >> /tmp/create_cloudant_credentials.log 2>&1
com_response=$(ibmcloud service key-show ${var.service_name} ${var.service_credentials_name})
echo $com_response | awk 'match($0,"{"){print substr($0,RSTART)}' >> /tmp/com_output
EOF
    destination = "/tmp/${random_string.random-dir.result}/create_credentials.sh"
  }
  
provisioner "file" {
    content = <<EOF
#!/bin/bash
#
export BLUEMIX_API_KEY=${var.bluemix_key}
ibmcloud config --check-version=false >> /tmp/create_cloudant_credentials.log 2>&1
ibmcloud login -a https://cloud.ibm.com -r us-south >> /tmp/create_cloudant_credentials.log 2>&1
ibmcloud target --cf-api https://api.us-south.cf.cloud.ibm.com -o agostino.colussi -s Test >> /tmp/create_cloudant_credentials.log 2>&1
ibmcloud service key-delete ${var.service_name} ${var.service_credentials_name} -f >> /tmp/create_cloudant_credentials.log 2>&1
EOF
    destination = "/tmp/${random_string.random-dir.result}/delete_credentials.sh"
  }
 
 }
 
resource "camc_scriptpackage" "CreateScript" {
  program = ["/bin/bash", "/tmp/${random_string.random-dir.result}/create_credentials.sh"]
  depends_on = ["null_resource.ibmcli_vm"]
  remote_host = "${var.vm_address}"
  remote_user = "${var.ssh_user}"
  remote_password = "${var.ssh_user_password}"
  on_create = true
}

resource "camc_scriptpackage" "DestroyScript" {
  program = ["/bin/bash", "/tmp/${random_string.random-dir.result}/delete_credentials.sh && rm -fr /tmp/${random_string.random-dir.result}"]
  depends_on = ["null_resource.ibmcli_vm"]
  remote_host = "${var.vm_address}"
  remote_user = "${var.ssh_user}"
  remote_password = "${var.ssh_user_password}"
  on_delete = true
} 


data "external" "com_output" {
  depends_on = ["camc_scriptpackage.CreateScript"]
  program = ["/bin/bash", "${path.module}/scripts/get_output.sh"]
  query = {
    output_location  = "/tmp/${random_string.random-dir.result}/com_output"
  }
}


