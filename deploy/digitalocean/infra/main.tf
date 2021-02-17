# tags tags tags tags tags tags tags tags
# tags tags tags tags tags tags tags tags
resource "digitalocean_tag" "tenant" {
  name = var.tenant
}
resource "digitalocean_tag" "environment" {
  name = var.environment
}


resource "digitalocean_database_cluster" "db" {
  name                  = var.name
  engine                = var.engine
  version               = var.db_version
  size                  = var.size
  region                = var.region
  private_network_uuid  = var.vpc_id
  node_count = 1

  tags               = [
    digitalocean_tag.tenant.id,
    digitalocean_tag.environment.id
  ]

}
