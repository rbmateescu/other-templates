module "svn-incidents" {
  source = "./modules/svn-incidents"

  svn_user = "${var.svn_user}"
  svn_pass = "${var.svn_pass}"
  svn_base_url = "${var.svn_base_url}"
  svn_msg = "${var.svn_msg}"

}