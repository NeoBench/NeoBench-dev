#!/bin/bash
echo "🛠️  Patching all Cargo.toml files for edition 2024 + #[no_mangle]..."

# Find all Cargo.toml files and patch them
find . -name "Cargo.toml" | while read file; do
    # Insert cargo-features if not present
    if ! grep -q 'cargo-features' "$file"; then
        sed -i '1icargo-features = ["edition2024"]' "$file"
        echo "✅ Added cargo-features to $file"
    fi

    # Force edition = "2024"
    sed -i 's/^edition *= *".*"/edition = "2024"/' "$file"
    echo "✅ Set edition = \"2024\" in $file"
done

# Fix all #[unsafe(no_mangle)] to #[no_mangle]
find ./src -name "*.rs" | while read rsfile; do
    sed -i 's/#\[unsafe(no_mangle)\]/#[no_mangle]/g' "$rsfile"
    echo "✅ Cleaned up #[no_mangle] in $rsfile"
done

echo "🎉 All Cargo.toml files patched for edition 2024 and no_mangle syntax cleaned."
