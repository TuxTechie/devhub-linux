#!/bin/bash

# DevSetup - Interactive Developer Environment Setup Tool
echo "Welcome to DevSetup - Your Interactive Developer Environment Setup Tool"

# Function to add color
add_color() {
    case $1 in
        "green") echo -e "\e[32m$2\e[0m" ;;
        "red") echo -e "\e[31m$2\e[0m" ;;
    esac
}

echo "Please select the tools you want to install:"

# Function to install a tool
install_tool() {
    case $1 in
        "Git") sudo apt-get install -y git ;;
        "VS Code") sudo snap install --classic code ;;
        "Terminator") sudo apt-get install -y terminator ;;
        "Homebrew") /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" ;;
        "Docker") sudo apt-get install -y docker.io ;;
        "PostgreSQL") sudo apt-get install -y postgresql postgresql-contrib ;;
        "Virtualenv") pip install virtualenv ;;
        "Slack") sudo snap install slack --classic ;;
        "Ansible") sudo apt-get install -y ansible ;;
        "htop") sudo apt-get install -y htop ;;
        "Google Chrome") sudo apt-get install -y google-chrome-stable ;;
        "Postman") sudo snap install postman ;;
        "ESLint") npm install -g eslint ;;
        "Prettier") npm install -g prettier ;;
    esac
}

# List of tools to install
tools=("Git" "VS Code" "Terminator" "Homebrew" "Docker" "PostgreSQL" "Virtualenv" "Slack" "Ansible" "htop" "Google Chrome" "Postman" "ESLint" "Prettier" "Custom Package")

# Loop through the list of tools and prompt user for installation
installed=()
not_installed=()
for tool in "${tools[@]}"; do
    read -p "Do you want to install $tool? (y/n): " choice
    if [[ $choice == "y" || $choice == "Y" ]]; then
        if [[ $tool == "Custom Package" ]]; then
            read -p "Enter the name of the custom package to install: " custom_package
            sudo apt-get install -y $custom_package
            installed+=("Custom Package: $custom_package")
        else
            install_tool "$tool"
            installed+=("$tool")
        fi
    else
        if [[ $tool == "Custom Package" ]]; then
            not_installed+=("Custom Package")
        else
            not_installed+=("$tool")
        fi
    fi
done

# Check if no packages were selected
if [ ${#installed[@]} -eq 0 ]; then
    echo -e "\nNo packages were selected for installation."
    if [ ${#not_installed[@]} -ne 0 ]; then
        echo -e "The following tools were not installed:"
        for tool in "${not_installed[@]}"; do
            echo -e "$(add_color "red" "- $tool")"
        done
    fi
    echo -e "Exiting the script. 😊\n"
    exit 0
fi

if [ ${#installed[@]} -ne 0 ]; then
    echo -e "The following tools were installed:"
    for tool in "${installed[@]}"; do
        echo -e "$(add_color "green" "- $tool")"
    done
fi

if [ ${#not_installed[@]} -ne 0 ]; then
    echo -e "The following tools were not installed:"
    for tool in "${not_installed[@]}"]; do
        if [[ $tool == "Custom Package" ]]; then
            echo -e "$(add_color "red" "- Custom Package")"
        else
            echo -e "$(add_color "red" "- $tool")"
        fi
    done
fi

echo ""
