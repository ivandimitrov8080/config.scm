;; pwntools development environment
;; Usage: guix shell -m shell.scm -- xonsh
(specifications->manifest
 '(;; core CTF framework (brings capstone, unicorn, ropgadget, pyelftools,
   ;; paramiko, requests, rpyc, psutil, etc. transitively)
   "pwntools"
   "python"

   ;; shell
   "xonsh"                     ; Python-ish interactive shell

   ;; crypto / math
   "python-pycryptodome"       ; AES, RSA, DES, hashing, padding oracles
   "python-cryptography"       ; higher-level crypto primitives
   "python-gmpy2"              ; GMP big-integer math (RSA/DLP/factoring)
   "python-sympy"              ; symbolic math, modular arithmetic, factoring

   ;; numeric / interactive
   "python-numpy"              ; arrays, struct packing helpers
   "python-ipython"            ; enhanced REPL with tab-completion

   ;; debugging & reverse engineering
   "gdb-multiarch"             ; debugger with multi-arch support
   "radare2"                   ; disassembler / RE framework

   ;; tracing
   "strace"                    ; syscall tracing
   "ltrace"                    ; library call tracing

   ;; assembler / binary utilities
   "nasm"                      ; x86/x64 assembler
   "binutils"                  ; objdump, readelf, strings, nm, objcopy

   ;; networking
   "netcat"                    ; raw TCP/UDP interaction

   ;; misc
   "file"))                    ; ELF/binary identification
