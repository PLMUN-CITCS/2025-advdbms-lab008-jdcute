#!/bin/bash

# Database credentials
DB_HOST="${DB_HOST:-127.0.0.1}"
DB_PORT="${DB_PORT:-4000}"
DB_USER="${DB_USER:-root}"

# Directory containing SQL scripts
SQL_DIR="bookstore_database"

# List of SQL scripts in execution order
SQL_FILES=("create_bookstore_schema.sql" "insert_bookstore_data.sql" "query_bookstore_data.sql")

# Execute each SQL script
for sql_file in "${SQL_FILES[@]}"; do
  sql_filepath="$SQL_DIR/$sql_file"

  if [ ! -f "$sql_filepath" ]; then
    echo "❌ Error: SQL file '$sql_filepath' not found."
    exit 1
  fi

  echo "🚀 Executing SQL script: $sql_filepath"

  # Run the SQL file and capture errors
  output=$(mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" < "$sql_filepath" 2>&1)
  exit_code=$?

  if [ "$exit_code" -eq 0 ]; then
    echo "✅ Successfully executed: $sql_filepath"
  else
    echo "❌ Error executing $sql_filepath!"
    echo "$output"
    exit 1
  fi
done

echo "🎉 All SQL scripts executed successfully!"
exit 0