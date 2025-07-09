#!/bin/bash
echo "Patching edition2024 opt-in..."
for file in src/*/Cargo.toml; do
  if ! grep -q 'cargo-features = \["edition2024"\]' "$file"; then
    echo "Fixing $file"
    sed -i '1icargo-features = ["edition2024"]' "$file"
  fi
done
