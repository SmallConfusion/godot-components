cargo new game_extension --lib
cp ./addons/fusionex/editor_tools/game_gdextension.txt ./game_extension.gdextension
cp ./addons/fusionex/editor_tools/lib.rs ./game_extension/src/lib.rs

cd game_extension
cargo add godot
touch .gdignore
echo "target" > .gitignore

echo '[lib]
crate-type = ["cdylib"]' >> Cargo.toml
cargo build
