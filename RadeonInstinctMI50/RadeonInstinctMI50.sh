#!/bin/bash
# Requires Radeon Instinct MI50 GPU Drivers
# Requires 'rocm-smi' downloaded/installed

echo "===== Radeon Instinct MI50 GPU Report ====="
rocm-smi --showproductname -d 0
rocm-smi --showrasinfo -d 0
rocm-smi --showmeminfo vram -d 0 | grep 'Total Memory' | awk -F ':' '{ printf "Total Memory: %.2f GB\n", $2 / 1024 / 1024 / 1024 }'
rocm-smi --showmeminfo vram -d 0
read -p "Press Enter to close..."
