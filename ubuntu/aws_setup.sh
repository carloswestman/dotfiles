#!/bin/bash
# aws_setup.sh
# Install and configure AWS CLI on Ubuntu

echo "=== AWS CLI Setup ==="

# 1. Install AWS CLI
if ! command -v aws &> /dev/null; then
    echo "Installing AWS CLI..."
    sudo apt update
    sudo apt install -y awscli
else
    echo "AWS CLI already installed: $(aws --version)"
fi

# 2. Configure credentials and default region
echo ""
echo "Running 'aws configure' — you'll need your Access Key ID and Secret Access Key."
echo "Get these from: AWS Console > IAM > Users > Your User > Security Credentials"
echo ""
aws configure

# 3. Verify setup
echo ""
echo "Verifying AWS identity..."
aws sts get-caller-identity

if [ $? -eq 0 ]; then
    echo ""
    echo "AWS CLI configured successfully!"
    echo ""
    echo "Useful commands:"
    echo "  aws s3 ls                                    # List S3 buckets"
    echo "  aws s3 cp file.txt s3://bucket/              # Upload to S3"
    echo "  aws s3 sync ./dir s3://bucket/dir            # Sync directory to S3"
    echo "  aws cloudfront create-invalidation \\         # Invalidate CloudFront cache"
    echo "    --distribution-id DIST_ID --paths '/*'"
else
    echo ""
    echo "AWS verification failed. Check your credentials and try: aws configure"
fi
