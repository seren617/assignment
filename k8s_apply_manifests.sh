#!/bin/bash

# Define the repository directory name
REPO_DIR="assignment"

# Check if the directory exists
if [ -d "$REPO_DIR" ]; then
    echo "Directory '$REPO_DIR' already exists. Pulling latest changes."
    cd "$REPO_DIR" || exit
    git pull
else
    echo "Cloning repository."
    git clone https://github.com/seren617/assignment.git
    cd "$REPO_DIR" || exit
fi

# Navigate to the kubernetes folder
cd kubernetes || exit

# Array of Kubernetes manifest files in the desired order
files=("namespace.yaml" "secret.yaml" "deployment.yaml" "service.yaml" "metrics-server.yaml" "hpa.yaml")

# Apply each file in the specified order
for file in "${files[@]}"; do
    if kubectl apply -f "$file"; then
        echo "Successfully applied $file"
    else
        echo "Failed to apply $file"
        exit 1
    fi
done

echo "All files have been successfully applied."
