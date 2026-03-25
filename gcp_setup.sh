#!/bin/bash
# gcp_setup.sh
# Install and configure Google Cloud CLI (gcloud, bq, gsutil)

echo "=== Google Cloud CLI Setup ==="

# 1️⃣ Install Google Cloud SDK via Homebrew
if ! command -v gcloud &> /dev/null; then
    echo "Installing Google Cloud SDK..."
    brew install --cask google-cloud-sdk
else
    echo "Google Cloud SDK already installed: $(gcloud version 2>/dev/null | head -1)"
fi

# 2️⃣ Source gcloud shell completions in current session
BREW_PREFIX="$(brew --prefix)"
if [ -f "${BREW_PREFIX}/share/google-cloud-sdk/path.zsh.inc" ]; then
    source "${BREW_PREFIX}/share/google-cloud-sdk/path.zsh.inc"
    source "${BREW_PREFIX}/share/google-cloud-sdk/completion.zsh.inc"
fi

# 3️⃣ Login and set project
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

# 4️⃣ Set application default credentials (for client libraries and BigQuery)
echo ""
echo "Setting application default credentials..."
gcloud auth application-default login

# 5️⃣ Add gcloud to .zshrc.local if not already present
SHELL_INC="${BREW_PREFIX}/share/google-cloud-sdk/path.zsh.inc"
COMP_INC="${BREW_PREFIX}/share/google-cloud-sdk/completion.zsh.inc"

touch ~/.zshrc.local
if ! grep -q "google-cloud-sdk/path.zsh.inc" ~/.zshrc.local 2>/dev/null; then
    cat << EOF >> ~/.zshrc.local

# Google Cloud SDK
source "${SHELL_INC}"
source "${COMP_INC}"
EOF
    echo "Added gcloud to ~/.zshrc.local"
fi

# 6️⃣ Verify setup
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
