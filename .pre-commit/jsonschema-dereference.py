import json
from typing import List, Dict, Any
from pathlib import Path

import jsonref

JSONSCHEMA_TEMPLATE_NAME = "values.schema.tmpl.json"
JSONSCHEMA_NAME = "values.schema.json"
CHART_LOCK = "Chart.lock"

def load_template_schema(chart_dir: Path) -> Dict[str, Any]:
    """Load values.schema.tmpl.json and template it via Jinja2."""
    with open(chart_dir / JSONSCHEMA_TEMPLATE_NAME, "r") as f:
        return json.loads(f.read())

def save(chart_dir: Path, schema: Any):
    """Take schema containing $refs and dereference them."""
    with open(chart_dir / JSONSCHEMA_NAME, "w") as f:
        json.dump(schema, f, indent=4, sort_keys=True)

if __name__ == '__main__':
    charts = [p.parent for p in Path(".").rglob(CHART_LOCK)]

    errors: List[BaseException] = []
    for chart in charts:
        try:
            schema_template = load_template_schema(chart)
            schema = jsonref.replace_refs(schema_template)
            save(chart, schema)
        except BaseException as e:
            print(f"Could not process schema for '{chart}': {e}")
            errors.append(e)
    if errors:
        exit(1)
