#!/bin/bash
# gcp_setup.sh
# Install and configure Google Cloud CLI on Ubuntu

echo "=== Google Cloud CLI Setup ==="

# 1. Install Google Cloud SDK via apt
if ! command -v gcloud &> /dev/null; then
    echo "Installing Google Cloud SDK..."
    sudo apt install -y apt-transport-https ca-certificates gnupg curl
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
    sudo apt update
    sudo apt install -y google-cloud-cli
else
    echo "Google Cloud SDK already installed: $(gcloud version 2>/dev/null | head -1)"
fi

# 2. Login and set project
echo ""
echo "This will open a browser to authenticate with your Google account."
echo ""
gcloud auth login

echo ""
echo "Setting default project..."
echo "Available projects:"
gcloud projects list
echo ""
read -p "Enter your project ID: " PROJECT_ID
gcloud config set project "$PROJECT_ID"

# 3. Set application default credentials (for client libraries and BigQuery)
echo ""
echo "Setting application default credentials..."
gcloud auth application-default login

# 4. Add gcloud completions to .zshrc.local if not already present
touch ~/.zshrc.local
if ! grep -q "google-cloud-sdk/completion" ~/.zshrc.local 2>/dev/null; then
    cat << 'EOF' >> ~/.zshrc.local

# Google Cloud SDK
if [ -f /usr/share/google-cloud-sdk/completion.zsh.inc ]; then
    source /usr/share/google-cloud-sdk/completion.zsh.inc
fi
EOF
    echo "Added gcloud completions to ~/.zshrc.local"
fi

# 5. Verify setup
echo ""
echo "Verifying GCP setup..."
gcloud config list

echo ""
echo "GCP CLI configured successfully!"
echo ""
echo "Useful commands:"
echo "  bq query 'SELECT 1'                  # Run a BigQuery query"
echo "  bq ls                                 # List BigQuery datasets"
echo "  bq ls dataset_name                    # List tables in a dataset"
echo "  gsutil ls                             # List Cloud Storage buckets"
echo "  gcloud compute instances list         # List VM instances"
echo "  gcloud config set project PROJECT_ID  # Switch projects"
