WITH account_history AS (
    SELECT
        account_id,
        customer_id,
        account_type,
        balance,
        status,
        cdc_timestamp AS valid_from,
        LEAD(cdc_timestamp) OVER (PARTITION BY account_id ORDER BY cdc_timestamp ASC) AS valid_to
    FROM {{ ref('stg_accounts_cdc') }}
)
SELECT
    MD5(account_id || valid_from) AS account_sk,
    account_id,
    customer_id,
    account_type,
    balance,
    status,
    valid_from,
    COALESCE(valid_to, '9999-12-31'::TIMESTAMP) AS valid_to,
    valid_to IS NULL AS is_current
FROM account_history
