#!/bin/bash

# ============================================================
# MkDocs CV Site Management Script
# ============================================================
# This script helps manage the MkDocs CV documentation site
# Usage: ./publish.sh
# ============================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Site configuration
SITE_NAME="Allen Zhang CV"

echo -e "${BLUE}============================================================${NC}"
echo -e "${BLUE}   ${SITE_NAME} - Site Management${NC}"
echo -e "${BLUE}============================================================${NC}"
echo ""

# Check if mkdocs is installed
if ! command -v mkdocs &> /dev/null; then
    echo -e "${RED}Error: mkdocs is not installed.${NC}"
    echo -e "${YELLOW}Install it with: pip install -r requirements.txt${NC}"
    exit 1
fi

# Menu options
echo "What would you like to do?"
echo ""
echo "  1) Preview site locally (mkdocs serve)"
echo "  2) Build static site (mkdocs build)"
echo "  3) Deploy to GitHub Pages (mkdocs gh-deploy)"
echo "  4) Clean build directory"
echo "  5) Exit"
echo ""
read -p "Enter your choice [1-5]: " choice

case $choice in
    1)
        echo ""
        echo -e "${GREEN}Starting local preview server...${NC}"
        echo -e "${YELLOW}Access the site at: http://127.0.0.1:8000${NC}"
        echo -e "${YELLOW}Press Ctrl+C to stop the server${NC}"
        echo ""
        mkdocs serve
        ;;
    2)
        echo ""
        echo -e "${GREEN}Building static site...${NC}"
        mkdocs build
        echo -e "${GREEN}Build complete! Static files are in the 'site/' directory.${NC}"
        ;;
    3)
        echo ""
        echo -e "${YELLOW}This will deploy to GitHub Pages.${NC}"
        read -p "Are you sure you want to continue? (y/N): " confirm
        if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
            echo -e "${GREEN}Deploying to GitHub Pages...${NC}"
            mkdocs gh-deploy --force
            echo -e "${GREEN}Deployment complete!${NC}"
        else
            echo -e "${YELLOW}Deployment cancelled.${NC}"
        fi
        ;;
    4)
        echo ""
        echo -e "${YELLOW}Cleaning build directory...${NC}"
        rm -rf site/
        echo -e "${GREEN}Clean complete!${NC}"
        ;;
    5)
        echo ""
        echo -e "${BLUE}Goodbye!${NC}"
        exit 0
        ;;
    *)
        echo ""
        echo -e "${RED}Invalid option. Please choose 1-5.${NC}"
        exit 1
        ;;
esac

