-- Enable logical replication for Debezium CDC
ALTER SYSTEM SET wal_level = 'logical';

CREATE TABLE IF NOT EXISTS accounts (
    account_id VARCHAR(64) PRIMARY KEY,
    customer_id VARCHAR(64) NOT NULL,
    account_type VARCHAR(32) NOT NULL,
    balance DECIMAL(18,2) NOT NULL DEFAULT 0.00,
    status VARCHAR(16) NOT NULL DEFAULT 'ACTIVE',
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS transactions (
    transaction_id VARCHAR(64) PRIMARY KEY,
    account_id VARCHAR(64) REFERENCES accounts(account_id),
    amount DECIMAL(18,2) NOT NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'USD',
    direction VARCHAR(8) NOT NULL, -- 'DEBIT' or 'CREDIT'
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
