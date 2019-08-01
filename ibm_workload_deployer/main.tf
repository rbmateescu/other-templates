

resource "ibmworkloaddeployer_instance" "sample" {
	deployment_name = "${var.ibm_stack_name}"
	deployment_status = "RUNNING"
	environment_profile = "${var.Deployment_Parameters_-_environment_profile}"
	cloud_group = "${var.Deployment_Parameters_-_cloud_group}"
	ip_group = "${var.Deployment_Parameters_-_ip_group}"
	ssh_keys = "${var.Deployment_Parameters_-_ssh_keys}"
	pattern_id = "a-077854f2-8c15-45c7-8c00-5905f0c1e92c"
	pattern_name = "sample"
	pattern_attributes = ""
	stage2_data = ""
	nic_data = ""
	pattern_model = "{\"model\":{\"nodes\":[{\"id\":\"OS Node\",\"attributes\":{\"ConfigPWD_USER.password\":\"<xor>KTYtKyosOi1u\",\"HWAttributes.memsize\":${var.OS_Node_-_HWAttributes__memsize},\"HWAttributes.numvcpus\":${var.OS_Node_-_HWAttributes__numvcpus},\"ConfigPWD_ROOT.password\":\"<xor>LTAwK25tbGs=\"},\"locked\":[\"ConfigPWD_ROOT.password\",\"ConfigPWD_USER.password\"],\"type\":\"image:OS Node:IBM OS Image for Red Hat Linux Systems:3.0.6.0:99\",\"parent_type\":\"image:OS Node:2.1\"}],\"description\":\"\",\"name\":\"sample\",\"app_type\":\"application\",\"patterntype\":\"vsys\",\"links\":[],\"locked\":false,\"readonly\":false,\"patternversion\":\"1.0\",\"version\":\"1.0\"}}"
}

output "deployment_id" {
	value = "${ibmworkloaddeployer_instance.sample.id}"
}

output "deployment_name" {
	value = "${var.ibm_stack_name}"
}

output "deployment_status" {
	value = "${ibmworkloaddeployer_instance.sample.deployment_status}"
}

output "deployment_url" {
	value = "dashboard/runtime/virtualsystems/#${ibmworkloaddeployer_instance.sample.id}"
}
