"""Debezium CDC Envelope Deserializer and Staging Formatter."""
from typing import Dict, Any, Optional

class CDCProcessor:
    @staticmethod
    def process_envelope(record: Dict[str, Any]) -> Optional[Dict[str, Any]]:
        op = record.get("op")
        ts_ms = record.get("ts_ms")

        # 'c' = Create, 'u' = Update, 'd' = Delete, 'r' = Snapshot Read
        if op in ("c", "u", "r"):
            payload = record.get("after", {})
            payload["_cdc_op"] = op
            payload["_cdc_timestamp"] = ts_ms
            payload["_is_deleted"] = False
            return payload
        elif op == "d":
            payload = record.get("before", {})
            payload["_cdc_op"] = "d"
            payload["_cdc_timestamp"] = ts_ms
            payload["_is_deleted"] = True
            return payload
        return None
