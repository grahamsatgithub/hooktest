resource "azurerm_virtual_network" "vnet" {
  name                = "${var.virtual_network_name}"
  location            = "${var.location}"
  address_space       = ["${var.address_space}"]
  resource_group_name = "${var.resource_group}"
}

resource "azurerm_subnet" "database" {
  name  = "database"
  address_prefix = "${var.subnet_database}"
  resource_group_name = "${var.resource_group}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  network_security_group_id = "${azurerm_network_security_group.database.id}"
}

resource "azurerm_subnet" "application" {
  name  = "application"
  address_prefix = "${var.subnet_application}"
  resource_group_name = "${var.resource_group}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  network_security_group_id = "${azurerm_network_security_group.application.id}"
}

resource "azurerm_application_security_group" "database" {
  name                = "database-asg"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
}

resource "azurerm_application_security_group" "application" {
  name                = "application-asg"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
}

resource "azurerm_network_security_group" "database" {
  name                = "database-nsg"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  security_rule {
    name                                  = "sql-default-port"
    priority                              = 100
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "1433"
    source_application_security_group_ids = ["${azurerm_application_security_group.database.id}"]
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "sql-admin-port"
    priority                              = 101
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "1434"
    source_application_security_group_ids = ["${azurerm_application_security_group.database.id}"]
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "sql-service-broker"
    priority                              = 102
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "4022"
    source_application_security_group_ids = ["${azurerm_application_security_group.database.id}"]
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "sql-transact-depurator"
    priority                              = 103
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "135"
    source_application_security_group_ids = ["${azurerm_application_security_group.database.id}"]
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "sql-named-instances"
    priority                              = 104
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Udp"
    source_port_range                     = "*"
    destination_port_range                = "1434"
    source_application_security_group_ids = ["${azurerm_application_security_group.database.id}"]
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "database-rdp-default-port"
    priority                              = 105
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "3389"
    source_address_prefix                 = "Internet"
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "RabbitmqCluster"
    priority                              = 150
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "4369"
    source_application_security_group_ids = ["${azurerm_application_security_group.database.id}"]
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "RabbitmqCluster2"
    priority                              = 151
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "5672"
    source_application_security_group_ids = ["${azurerm_application_security_group.database.id}"]
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "RabbitmqCluster3"
    priority                              = 152
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "5671"
    source_application_security_group_ids = ["${azurerm_application_security_group.database.id}"]
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "RabbitmqCluster4"
    priority                              = 153
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "25672"
    source_application_security_group_ids = ["${azurerm_application_security_group.database.id}"]
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "RabbitmqCluster2Console"
    priority                              = 154
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "15672"
    source_application_security_group_ids = ["${azurerm_application_security_group.database.id}"]
    destination_address_prefix            = "*"
  }  

  security_rule {
    name                                  = "ISL-ES-Cluster"
    priority                              = 162
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "9200"
    source_application_security_group_ids = ["${azurerm_application_security_group.database.id}"]
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "ISL-ES-Cluster2"
    priority                              = 163
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "9300"
    source_application_security_group_ids = ["${azurerm_application_security_group.database.id}"]
    destination_address_prefix            = "*"
  }    

}

resource "azurerm_network_security_group" "application" {
  name                = "application-nsg"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  security_rule {
    name                                  = "application-rdp-default-port"
    priority                              = 105
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "3389"
    source_address_prefix                  = "Internet"
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "ISL-HTTP"
    priority                              = 100
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "80"
    source_address_prefix                 = "88.211.73.160/27"
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "ISL-RDP"
    priority                              = 110
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "3389"
    source_address_prefix                  = "88.211.73.160/27"
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "ISL-KIB"
    priority                              = 120
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "5601"
    source_address_prefix                 = "88.211.73.160/27"
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "ISL-ELA"
    priority                              = 130
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "9200"
    source_address_prefix                 = "88.211.73.160/27"
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "ISL-ES"
    priority                              = 140
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "9300"
    source_address_prefix                 = "88.211.73.160/27"
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "RabbitmqCluster"
    priority                              = 150
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "4369"
    source_address_prefix                 = "${var.subnet_database}"
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "RabbitmqCluster2"
    priority                              = 151
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "5672"
    source_address_prefix                 = "${var.subnet_database}"
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "RabbitmqCluster3"
    priority                              = 152
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "5671"
    source_address_prefix                 = "${var.subnet_database}"
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "RabbitmqCluster4"
    priority                              = 153
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "25672"
    source_address_prefix                 = "${var.subnet_database}"
    destination_address_prefix            = "*"
  }

  security_rule {
    name                                  = "RabbitmqCluster2Console"
    priority                              = 154
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "15672"
    source_address_prefix                 = "${var.subnet_database}"
    destination_address_prefix            = "*"
  }    


  security_rule {
    name                                  = "ElasticCluster"
    priority                              = 111
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "9200"
    source_address_prefix                 = "${var.subnet_database}"
    destination_address_prefix            = "*"
  }     

  security_rule {
    name                                  = "ElasticCluster2"
    priority                              = 112
    direction                             = "Inbound"
    access                                = "Allow"
    protocol                              = "Tcp"
    source_port_range                     = "*"
    destination_port_range                = "9300"
    source_address_prefix                 = "${var.subnet_database}"
    destination_address_prefix            = "*"
  }    
}

resource "azurerm_subnet_network_security_group_association" "application" {
  subnet_id                 = "${azurerm_subnet.application.id}"
  network_security_group_id = "${azurerm_network_security_group.application.id}"
}

resource "azurerm_subnet_network_security_group_association" "database" {
  subnet_id                 = "${azurerm_subnet.database.id}"
  network_security_group_id = "${azurerm_network_security_group.database.id}"
}