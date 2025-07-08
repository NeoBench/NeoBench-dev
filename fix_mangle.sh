#!/bin/bash

for file in src/*/src/lib.rs; do
  echo "Fixing: $file"

  # Clean up any invalid lines
  sed -i 's/\#\[unsafe(no_mangle)\]/#[no_mangle]/g' "$file"
  sed -i 's/pub extern/pub unsafe extern/g' "$file"

  # (Optional) Confirm presence of full correct pattern
  if ! grep -q 'pub unsafe extern "C" fn' "$file"; then
    echo "⚠️ Warning: $file may not contain a valid _start function!"
  fi
done

echo "✅ All unsafe attributes and functions fixed."
