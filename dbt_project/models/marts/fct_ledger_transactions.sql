SELECT
    t.transaction_id,
    a.account_sk,
    t.account_id,
    t.amount,
    t.currency,
    t.direction,
    t.transaction_time,
    CASE WHEN t.direction = 'CREDIT' THEN t.amount ELSE -t.amount END AS signed_amount
FROM {{ ref('stg_transactions_cdc') }} t
LEFT JOIN {{ ref('dim_accounts_scd2') }} a
    ON t.account_id = a.account_id
    AND t.transaction_time >= a.valid_from
    AND t.transaction_time < a.valid_to
