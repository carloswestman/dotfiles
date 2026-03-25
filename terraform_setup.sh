#!/bin/bash
# terraform_setup.sh
# Install Terraform via tfenv (version manager)

echo "=== Terraform Setup ==="

# 1️⃣ Install tfenv (Terraform version manager)
if ! command -v tfenv &> /dev/null; then
    echo "Installing tfenv..."
    brew install tfenv
else
    echo "tfenv already installed."
fi

# 2️⃣ Install latest stable Terraform
echo "Installing latest Terraform..."
tfenv install latest
tfenv use latest

# 3️⃣ Verify
echo ""
terraform version

echo ""
echo "Terraform configured successfully!"
echo ""
echo "tfenv lets you manage multiple Terraform versions:"
echo "  tfenv list-remote    # List available versions"
echo "  tfenv install 1.x.x  # Install a specific version"
echo "  tfenv use 1.x.x      # Switch versions"
echo ""
echo "Terraform will use your AWS/GCP credentials from the CLIs you've configured."
