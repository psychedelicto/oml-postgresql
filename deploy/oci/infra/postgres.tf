# POSTGRESQL Instance -- POSTGRESQL Instance  -- POSTGRESQL Instance  -- POSTGRESQL Instance
# POSTGRESQL Instance -- POSTGRESQL Instance  -- POSTGRESQL Instance  -- POSTGRESQL Instance
data "template_file" "pgsql" {
  template = file(var.postgresql_user_data)

  vars = {
    private_subnet              = module.networking.private_subnet_cidr
    public_subnet               = module.networking.public_subnet_cidr
    postgres_password           = var.pg_password
    }
}

module "postgresql_instance" {
    source                      = "../../oci-terraform-modules/instance"

    compartment_id              = oci_identity_compartment.tf-compartment.compartment_id
    availability_domain         = var.postgresql_instance_availability_domain
    shape                       = var.postgresql_instance_shape
    display_name                = var.postgresql_instance_display_name
    fqdn                        = var.postgresql_instance_display_name
    nsg_ids                     = [module.security_group.pgsql_sg_id,module.security_group.ssh_sg_id]
    subnet_id                   = module.networking.public_subnet_id
    assign_public_ip            = false
    ssh_private_key             = var.ssh_private_key
    user_data                   = base64encode(data.template_file.pgsql.rendered)
    os_ocid                     = var.centos_ocid
}
