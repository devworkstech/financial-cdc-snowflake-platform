import pytest
from src.cdc_consumer import CDCProcessor
from src.great_expectations_runner import DataQualityChecker

def test_cdc_insert_envelope():
    record = {
        "op": "c",
        "ts_ms": 1726588800000,
        "after": {"account_id": "acc_123", "balance": 500.0}
    }
    processed = CDCProcessor.process_envelope(record)
    assert processed["account_id"] == "acc_123"
    assert processed["_cdc_op"] == "c"
    assert processed["_is_deleted"] is False

def test_cdc_delete_envelope():
    record = {
        "op": "d",
        "ts_ms": 1726588800000,
        "before": {"account_id": "acc_123"}
    }
    processed = CDCProcessor.process_envelope(record)
    assert processed["account_id"] == "acc_123"
    assert processed["_is_deleted"] is True

def test_data_quality_suite():
    data = [
        {"transaction_id": "t1", "account_id": "a1", "amount": 100.0},
        {"transaction_id": "t2", "account_id": "a2", "amount": 250.0}
    ]
    report = DataQualityChecker.validate_transactions(data)
    assert report["passed"] is True
    assert report["failed_checks"] == 0
