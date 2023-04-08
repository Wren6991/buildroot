#!/bin/bash

set -ex

cp output/build/linux-5.15.43/vmlinux vmlinux
riscv32-unknown-elf-objcopy output/build/linux-5.15.43/vmlinux vmlinux-phys --adjust-vma -0x3fc00000
riscv32-unknown-elf-objdump -d vmlinux-phys > vmlinux-phys.dis
riscv32-unknown-elf-objdump -d vmlinux > vmlinux-virt.dis
../../rvcpp/test/scripts/annotate_trace.py run.log run_annotated.log -d vmlinux-phys.dis -d vmlinux-virt.dis
