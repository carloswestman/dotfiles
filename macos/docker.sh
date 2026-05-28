#!/bin/bash
set -e

echo "Installing Homebrew packages..."

# Core tools
brew install kubectl helm k9s jq yq wget curl git gh lazydocker

echo "Installing OrbStack..."
brew install --cask orbstack

echo ""
echo "Done."
echo ""
echo "Installed:"
echo "  - OrbStack (Docker + Compose + optional Kubernetes)"
echo "  - kubectl"
echo "  - helm"
echo "  - k9s"
echo "  - lazydocker"
echo "  - jq / yq"
echo "  - gh"
echo ""
echo "Next steps:"
echo "1. Open OrbStack manually once:"
echo "   open -a OrbStack"
echo ""
echo "2. Verify docker:"
echo "   docker version"
echo "   docker compose version"
echo ""
echo "3. Verify kubectl:"
echo "   kubectl version --client"
echo ""
echo "4. Enable Kubernetes inside OrbStack settings if desired."
echo ""
echo "5. Add your production kubeconfig:"
echo "   mkdir -p ~/.kube"
echo "   cp your-config ~/.kube/config"
echo ""
echo "6. Check contexts:"
echo "   kubectl config get-contexts"