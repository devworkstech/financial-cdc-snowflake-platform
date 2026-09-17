param([string]$Username = "soniablake")
git init; git branch -M main; git add .
git commit -m "feat: Financial CDC & Modern Data Stack Platform - Debezium, Kafka, Snowflake, dbt Core, Great Expectations"
git remote remove origin 2>$null
git remote add origin "https://github.com/$Username/financial-cdc-snowflake-platform.git"
git push -u origin main
