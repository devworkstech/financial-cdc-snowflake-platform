# Financial CDC & Snowflake Data Platform Architecture

## Change Data Capture Mechanics
- Debezium monitors PostgreSQL WAL files using the `pgoutput` logical replication plugin.
- Each event contains:
  - `op`: Operation type ('c'=create, 'u'=update, 'd'=delete, 'r'=read/snapshot)
  - `before`: Record state prior to modification
  - `after`: Record state following modification
  - `ts_ms`: Exact millisecond transaction timestamp

## Data Quality Assurance
Great Expectations checkpoints run after every dbt run, alerting Slack/PagerDuty on critical schema deviations or reconcile failures.
