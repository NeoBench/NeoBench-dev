#!/bin/bash
echo "🔧 Fixing #[no_mangle] usage across all crates..."

find ./src -name lib.rs | while read file; do
    echo "📄 Patching $file"

    # Remove incorrect #[unsafe(no_mangle)]
    sed -i 's/#\[unsafe(no_mangle)\]/#[no_mangle]/g' "$file"

    # Ensure the entry function is declared as unsafe
    sed -i '/#[no_mangle]/{
        N
        s/pub extern "C" fn/pub unsafe extern "C" fn/
    }' "$file"

    echo "✅ Fixed: $file"
done

echo "🎉 All #[no_mangle] declarations corrected."
