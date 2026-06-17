#!/bin/bash

# GitHub API Token - Replace with your token
GITHUB_TOKEN="${GITHUB_TOKEN}"
USERNAME="goswami800"

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if token is provided
if [ -z "$GITHUB_TOKEN" ]; then
    echo -e "${RED}Error: GITHUB_TOKEN environment variable is not set${NC}"
    echo "Usage: GITHUB_TOKEN=your_token ./update-descriptions.sh"
    exit 1
fi

# Function to update repository description
update_repo_description() {
    local repo=$1
    local description=$2
    
    echo -e "${YELLOW}Updating $repo...${NC}"
    
    response=$(curl -s -X PATCH \
        "https://api.github.com/repos/${USERNAME}/${repo}" \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"description\":\"${description}\"}")
    
    # Check if request was successful
    if echo "$response" | grep -q '"id"'; then
        echo -e "${GREEN}✓ Successfully updated $repo${NC}"
    else
        echo -e "${RED}✗ Failed to update $repo${NC}"
        echo "$response"
    fi
}

# Array of repositories with their descriptions
declare -A repos=(
    ["goswami800"]="Personal GitHub profile with portfolio, tech stack, and contribution statistics. Showcasing DevOps skills and learning journey."
    ["animal-health-tracker"]="3-tier web application for tracking animals and health status. Built with Flask, PostgreSQL, HTML, Bootstrap, and fully Dockerized."
    ["city-explorer-hub"]="Modern frontend application built with React, TypeScript, Vite, Tailwind CSS, and shadcn-ui. Lovable project."
    ["DEVOPS_Bootcamp"]="Learning resources and notes from Kunal Kushwaha's DevOps Bootcamp course."
    ["docker-student-app"]="Dockerized student management application demonstrating containerization best practices and Docker fundamentals."
    ["git-DevOps-Commands"]="Comprehensive guide to Git concepts for DevOps with commands, tutorials, videos, and practical projects."
    ["kubernetes-projects-learning"]="Comprehensive hands-on Kubernetes learning with practical real-time projects, CKAD exercises, and deployment scenarios."
    ["mean-devops-project"]="Full-stack MEAN application deployed on AWS EC2 with Docker Compose, NGINX reverse proxy, and GitHub Actions CI/CD pipeline."
    ["my-flask-calculator"]="Simple web calculator built with Python Flask and HTML. Supports basic arithmetic operations and is Dockerized."
    ["my-portfolio-showcase"]="Modern portfolio website built with React, TypeScript, Vite, Tailwind CSS showcasing professional projects."
    ["paxx-s"]="React TypeScript web application built with Vite, Tailwind CSS, and shadcn-ui. Lovable project template."
    ["SnakeGame"]="Classic Snake Game implementation built with JavaScript. Interactive and fun to play."
    ["Student-App"]="Java-based student management application deployed on AWS using Tomcat, MySQL RDS, and EC2 infrastructure."
    ["ultimate-linux-guide"]="Comprehensive Linux learning guide covering fundamentals, user management, file systems, networking, and system administration."
    ["vivek-s-digital-hub"]="React TypeScript web application built with Vite, Tailwind CSS, and shadcn-ui. Lovable project template."
)

# Update all repositories
echo -e "${YELLOW}Starting repository description updates...${NC}\n"

for repo in "${!repos[@]}"; do
    update_repo_description "$repo" "${repos[$repo]}"
    sleep 1  # Rate limiting
done

echo -e "\n${GREEN}All repositories updated!${NC}"
