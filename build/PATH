#!/bin/bash

RUSTUP='export RUSTUP_HOME="$HOME/.local/share/rustup"'
CARGO='export CARGO_HOME="$HOME/.local/share/cargo"'
SHELL=~/.zshrc

if ! grep -qF "$RUSTUP" "$SHELL"; then
    echo >> "$SHELL"
    echo "$RUSTUP" >> "$SHELL"
    echo "$CARGO" >> "$SHELL"
fi
