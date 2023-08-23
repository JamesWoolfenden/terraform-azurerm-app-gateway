module "app-gateway" {
  source      = "../../"
  common_tags = var.common_tags
  name        = "pike"
  rg_name     = azurerm_resource_group.example.name
  location    = azurerm_resource_group.example.location
  frontend_id = azurerm_subnet.frontend.id
  backend_id  = azurerm_subnet.backend.id
  public_ip   = azurerm_public_ip.example.ip_address
}
