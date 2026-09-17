WITH raw_cdc AS (
    SELECT
        cdc_payload:account_id::STRING AS account_id,
        cdc_payload:customer_id::STRING AS customer_id,
        cdc_payload:account_type::STRING AS account_type,
        cdc_payload:balance::DECIMAL(18,2) AS balance,
        cdc_payload:status::STRING AS status,
        TO_TIMESTAMP(cdc_payload:_cdc_timestamp::NUMBER / 1000) AS cdc_timestamp,
        cdc_payload:_is_deleted::BOOLEAN AS is_deleted
    FROM {{ source('snowflake_raw', 'raw_accounts_cdc') }}
)
SELECT * FROM raw_cdc
WHERE NOT is_deleted
