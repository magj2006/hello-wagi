set dotenv-load

watch sample:
    cargo watch -s "just run {{sample}}"

run sample: (build sample "--target wasm32-wasi")
    wagi -c modules.toml --log-dir ./logs

run-native sample:
    cd {{justfile_directory()}}/{{sample}}; cargo run

build sample target:
    cd {{justfile_directory()}}/{{sample}}; cargo clippy; cargo build {{target}}

push sample:
    wasm-to-oci push target/wasm32-wasi/debug/{{sample}}.wasm rustlinzwasm.azurecr.io/wagi-{{sample}}-oci::latest