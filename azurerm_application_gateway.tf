resource "azurerm_application_gateway" "network" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = var.frontend_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = var.frontend_port
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = var.public_ip
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = var.backend_port
    protocol              = "Https"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Https"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20220101S"
  }
  waf_configuration {
    enabled          = true
    rule_set_version = "3.2"
    firewall_mode    = "Prevention"
  }
  tags = var.common_tags
}


variable "frontend_port" {
  type    = number
  default = 443
}

variable "backend_port" {
  type    = number
  default = 80
}
