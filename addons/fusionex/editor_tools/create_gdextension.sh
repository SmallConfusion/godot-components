cargo new game_extension --lib
cp ./addons/fusionex/editor_tools/game_gdextension.txt ./game_gdextension.gdextension
cp ./addons/fusionex/editor_tools/lib.rs ./game_gdextension/src/lib.rs

cd game_extension
touch .gdignore
echo '[lib]
crate-type = ["cdylib"]' >> Cargo.toml
cargo add godot
