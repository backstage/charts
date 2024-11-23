""" 
This Python module:
  - Searches for JSON Schema templates with the name values.schema.tmpl.json
  - Dereferences any $refs contained in those files
  - Outputs the new Schema to a values.schema.json file in the same directory
"""

import sys
import json
from typing import List, Dict, Any
from pathlib import Path

# External library dependency
# Install with 'pip install jsonref'
import jsonref

# File to write the dereferenced JSON Schema to
JSONSCHEMA_NAME = "values.schema.json"
# File that contains the JSON Schema that needs dereferencing
JSONSCHEMA_TEMPLATE_NAME = "values.schema.tmpl.json"

def load_template_schema(schema_dir: Path) -> Dict[str, Any]:
    """Load the schema template values.schema.tmpl.json"""
    with open(schema_dir / JSONSCHEMA_TEMPLATE_NAME, "r", encoding="utf-8") as f:
        return json.loads(f.read())

def save(schema_dir: Path, schema_data: Any):
    """Save the dereferenced schema to values.schema.json"""
    with open(schema_dir / JSONSCHEMA_NAME, "w", encoding="utf-8") as f:
        json.dump(schema_data, f, indent=4, sort_keys=True)

if __name__ == '__main__':
    # Search for all values.schema.tmpl.json files
    schema_templates = [p.parent for p in Path(".").rglob(JSONSCHEMA_TEMPLATE_NAME)]

    # Create a list to hold any exceptions
    errors: List[BaseException] = []
    # Iterate over the List of found schema templates
    for schema_template in schema_templates:
        try:
            # Load the schema into a variable as JSON
            st = load_template_schema(schema_template)
            # Dereference all of the $refs
            s = jsonref.replace_refs(st)
            # Save the dereferenced JSON
            save(schema_template, s)
        except BaseException as e:
            # Print any errors to the screen
            print(f"Could not process schema for '{schema_template}': {e}")
            # Append any exceptions to the errors List
            errors.append(e)
    if errors:
        # Exit with status 1 if any exceptions were thrown
        sys.exit(1)
