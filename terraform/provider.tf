terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" # Best practice: use the latest stable v4
    }
  }

  backend "azurerm" {
    # These values must match the storage account you created for your state
    resource_group_name  = "tfstate-rg"
    storage_account_name = "saffrontfstate"
    container_name       = "tfstate"
    key                  = "restaurant.terraform.tfstate"
    
    # Required for OIDC authentication in the backend
    use_oidc = true
  }
}

provider "azurerm" {
  # This block is REQUIRED
  features {
    # You can add specific rules here, e.g., to delete disks automatically
    virtual_machine {
      delete_os_disk_on_deletion = true
    }
  }

  # Tells the provider to use GitHub OIDC for authentication
  use_oidc = true
}