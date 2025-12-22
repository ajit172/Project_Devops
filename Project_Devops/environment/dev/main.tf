module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}

module "network" {
  source   = "../../modules/azurerm_networking"
  networks = var.networks
}

module "public_ip" {
  source     = "../../modules/azurerm_public_ip"
  public_ips = var.public_ips
}

module "key_vault" {
  source     = "../../modules/azurerm_key_vault"
  key_vaults = var.key_vaults
}

module "sql_server" {
  depends_on      = [module.resource_group]
  source          = "../../modules/azurerm_sql_server"
  sql_server_name = var.sql_server_name
  rg_name         = "rg-pilu-dev-todoapp-01"
  location        = "centralindia"
  admin_username  = "devopsadmin"
  admin_password  = "P@ssw01rd@123"
  tags            = { env = "dev" }
}

module "sql_db" {
  depends_on  = [module.sql_server]
  source      = "../../modules/azurerm_sql_database"
  sql_db_name = "todoappdb"
  server_id   = module.sql_server.sql_server_id
  max_size_gb = 2
  tags        = { env = "dev" }
}

module "vm" {
  source         = "../../modules/azurerm_compute"

  vm_name        = var.vm_name
  rg_name        = "rg-pilu-dev-todoapp-01"
  location       = "centralindia"
  vm_size        = var.vm_size
  admin_username = var.admin_username
  admin_password = var.admin_password

  subnet_id      = module.network.subnet_ids["frontend-subnet"]
  public_ip_id   = module.public_ip.public_ip_ids["pip-pilu-dev-todoapp-01"]

  tags           = { env = "dev" }
}