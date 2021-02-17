 # The port the postgres database is listening on
output "database_port" {
     value = digitalocean_database_cluster.db.port
}
#
 # The URI for connecting to the database
output "database_private_uri" {
     value = digitalocean_database_cluster.db.private_uri
}
# The private_host for connecting to the database
output "database_private_host" {
    value = digitalocean_database_cluster.db.private_host
}
#
# # The name of the default database
output "database_name" {
     value = digitalocean_database_cluster.db.database
}
#
# # The name of the default user
output "database_user" {
     value = digitalocean_database_cluster.db.user
}
#
# # The default user password
output "database_password" {
   value = digitalocean_database_cluster.db.password
}

# # The cluster id
output "database_id" {
   value = digitalocean_database_cluster.db.id
}
