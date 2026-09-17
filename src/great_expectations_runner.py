"""Automated Data Quality & Observability Suite."""
from typing import List, Dict, Any

class DataQualityChecker:
    @staticmethod
    def validate_transactions(records: List[Dict[str, Any]]) -> Dict[str, Any]:
        failed = []
        for r in records:
            # Rule 1: Amount must be strictly positive
            if float(r.get("amount", 0)) <= 0:
                failed.append({"id": r.get("transaction_id"), "rule": "positive_amount"})
            # Rule 2: Account ID must not be null
            if not r.get("account_id"):
                failed.append({"id": r.get("transaction_id"), "rule": "non_null_account"})

        passed = len(failed) == 0
        return {
            "suite": "financial_transactions_quality",
            "total_records": len(records),
            "failed_checks": len(failed),
            "passed": passed,
            "error_rate_pct": round(len(failed) / max(len(records), 1) * 100, 2)
        }

if __name__ == "__main__":
    sample_data = [
        {"transaction_id": "tx_1", "account_id": "acc_100", "amount": 150.0},
        {"transaction_id": "tx_2", "account_id": "acc_101", "amount": -10.0}
    ]
    res = DataQualityChecker.validate_transactions(sample_data)
    print("Quality Suite Result:", res)
