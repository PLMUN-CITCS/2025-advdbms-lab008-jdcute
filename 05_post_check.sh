#!/bin/bash

# Database credentials
DB_HOST="${DB_HOST:-127.0.0.1}"
DB_PORT="${DB_PORT:-4000}"
DB_USER="${DB_USER:-root}"
DB_NAME="${DB_NAME:-BookstoreDB}"

execute_sql() {
  result=$(mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -D "$DB_NAME" -se "$1")
  if [[ $? -ne 0 ]]; then
    echo "❌ Error executing SQL: $1"
    exit 1
  fi
  echo "$result"
}

echo "🔍 Starting post-execution validation..."

# Expected counts
declare -A expected_counts=(
  ["Books"]=3
  ["Authors"]=3
  ["Customers"]=3
  ["Orders"]=3
  ["OrderDetails"]=2
)

# 1. *Check row counts*
for table in "${!expected_counts[@]}"; do
  actual_count=$(execute_sql "SELECT COUNT(*) FROM $table;")
  expected_count=${expected_counts[$table]}

  echo "📊 Checking $table count... Expected: $expected_count, Found: $actual_count"

  [[ "$actual_count" -eq "$expected_count" ]] || { echo "❌ FAILED"; exit 1; }
done

# 2. *Check updated book price*
expected_price="8.99"
book_price=$(execute_sql "SELECT Price FROM Books WHERE ISBN = '9781234567890';")
echo "💰 Checking book price... Expected: $expected_price, Found: $book_price"
[[ "$book_price" == "$expected_price" ]] || { echo "❌ FAILED"; exit 1; }

# 3. *Check deleted order detail*
order_detail_count=$(execute_sql "SELECT COUNT(*) FROM OrderDetails WHERE OrderID = 1 AND ISBN = '9780321765723';")
echo "🗑 Checking deleted OrderDetails... Expected: 0, Found: $order_detail_count"
[[ "$order_detail_count" -eq 0 ]] || { echo "❌ FAILED"; exit 1; }

# 4. *Check Primary Keys*
check_primary_key() {
  table="$1"
  expected_key="$2"
  actual_key=$(execute_sql "SHOW KEYS FROM $table WHERE Key_name = 'PRIMARY';" | awk '{print $5}')
  
  echo "🔑 Checking Primary Key in $table... Expected: $expected_key, Found: $actual_key"
  
  [[ "$actual_key" == "$expected_key" ]] || { echo "❌ FAILED"; exit 1; }
}

check_primary_key "Books" "ISBN"
check_primary_key "Authors" "AuthorID"
check_primary_key "Customers" "CustomerID"
check_primary_key "Orders" "OrderID"
check_primary_key "OrderDetails" "OrderID,ISBN"

# 5. *Check Foreign Keys*
check_foreign_key() {
  table="$1"
  referenced_table="$2"
  fk_exists=$(execute_sql "SELECT COUNT(*) FROM information_schema.REFERENTIAL_CONSTRAINTS WHERE TABLE_NAME = '$table' AND REFERENCED_TABLE_NAME = '$referenced_table';")

  echo "🔗 Checking Foreign Key in $table referencing $referenced_table... Found: $fk_exists"

  [[ "$fk_exists" -ge 1 ]] || { echo "❌ FAILED"; exit 1; }
}

check_foreign_key "BookAuthors" "Books"
check_foreign_key "BookAuthors" "Authors"
check_foreign_key "Orders" "Customers"
check_foreign_key "OrderDetails" "Orders"
check_foreign_key "OrderDetails" "Books"

echo "✅ All validation checks PASSED!"
exit 0