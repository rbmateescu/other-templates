variable "ibm_stack_name" {
	type="string"
	default=""
	description="Name of the Instance"
}

variable "Deployment_Parameters_-_environment_profile" {
	type="string"
	default=""
	description="Environment Profile"
}

variable "Deployment_Parameters_-_cloud_group" {
	type="string"
	default=""
	description="Cloud Group"
}

variable "Deployment_Parameters_-_ip_group" {
	type="string"
	default=""
	description="IP Group"
}

variable "Deployment_Parameters_-_ssh_keys" {
	type="string"
	default=""
	description="SSH key"
}

variable "OS_Node_-_HWAttributes__memsize" {
	type="string"
	default="2048"
	description="Memory size required in megabytes"
}

variable "OS_Node_-_HWAttributes__numvcpus" {
	type="string"
	default="1"
	description="Number of virtual CPUs required"
}