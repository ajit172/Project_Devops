rgs = {
  rg1 = {
    name       = "rg-pilu-dev-todoapp-01"
    location   = "centralindia"
    managed_by = "terraform"
    tags       = { env = "dev" }
  }
}

networks = {
  vnet1 = {
    name                = "vnet-pilu-dev-todoapp-01"
    location            = "centralindia"
    resource_group_name = "rg-pilu-dev-todoapp-01"
    address_space       = ["10.0.0.0/16"]
    tags                = { env = "dev" }
    subnets = [
      {
        name             = "frontend-subnet"
        address_prefixes = ["10.0.1.0/24"]
      },
      {
        name             = "backend-subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
    ]
  }
}

public_ips = {
  app1 = {
    name                = "pip-pilu-dev-todoapp-01"
    resource_group_name = "rg-pilu-dev-todoapp-01"
    location            = "centralindia"
    allocation_method   = "Static"
    zones               = ["1"]
    domain_name_label   = "todoapp-dev"
    sku                 = "Standard"
    ip_version          = "IPv4"
    tags                = { app = "frontend", env = "dev" }
  }

  app2 = {
    name                = "pip-pilu-dev-todoapp-02"
    resource_group_name = "rg-pilu-dev-todoapp-01"
    location            = "centralindia"
    allocation_method   = "Static"
    zones               = ["1"]
    domain_name_label   = "todoapp-dev2"
    sku                 = "Standard"
    ip_version          = "IPv4"
    tags                = { app = "frontend", env = "dev" }
  }
}

key_vaults = {
  kv1 = {
    kv_name  = "kv-todoapp-786"
    location = "centralindia"
    rg_name  = "rg-pilu-dev-todoapp-01"
  }
}

sql_server_name = "sql-pilu-dev-01"

vm_name        = "vm-pilu-dev-01"
vm_size        = "Standard_B1s"
admin_username = "azureuser"
admin_password = "P@ssw0rd123!"