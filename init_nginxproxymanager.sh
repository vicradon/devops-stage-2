#!/bin/sh

# Function to install SQLite3 if not already installed
install_sqlite3() {
  if ! command -v sqlite3 &> /dev/null; then
    echo "SQLite3 not found. Installing..."
    apt-get update && apt-get install -y sqlite3
  fi
}

# Function to create directories if they don't exist
create_directories() {
  directories=("/opt/nginxproxymanager" "/opt/nginxproxymanager/letsencrypt")
  for dir in "${directories[@]}"; do
    if [ ! -d "$dir" ]; then
      echo "Directory $dir does not exist. Creating..."
      mkdir -p "$dir"
    else
      echo "Directory $dir already exists."
    fi
  done
}

# Function to initialize SQLite database if it doesn't exist
initialize_database() {
  db_file="/opt/nginxproxymanager/db.sqlite"
  if [ ! -f "$db_file" ]; then
    echo "SQLite database $db_file does not exist. Initializing..."
    sqlite3 "$db_file" ".databases"
  else
    echo "SQLite database $db_file already exists."
  fi
}

# Function to set appropriate permissions
set_permissions() {
  chmod -R 600 /opt/nginxproxymanager
}

# Main function
main() {
  install_sqlite3
  create_directories
  initialize_database
  set_permissions
  exec "$@"
}

# Execute main function
main "$@"
