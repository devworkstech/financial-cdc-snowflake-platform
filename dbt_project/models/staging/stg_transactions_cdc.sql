WITH raw_cdc AS (
    SELECT
        cdc_payload:transaction_id::STRING AS transaction_id,
        cdc_payload:account_id::STRING AS account_id,
        cdc_payload:amount::DECIMAL(18,2) AS amount,
        cdc_payload:currency::STRING AS currency,
        cdc_payload:direction::STRING AS direction,
        TO_TIMESTAMP(cdc_payload:_cdc_timestamp::NUMBER / 1000) AS transaction_time
    FROM {{ source('snowflake_raw', 'raw_transactions_cdc') }}
)
SELECT * FROM raw_cdc
WHERE transaction_id IS NOT NULL
