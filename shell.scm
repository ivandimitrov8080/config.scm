;; pwntools development environment
;; Usage: guix shell -m shell.scm -- xonsh
(specifications->manifest
 '(
   "pwntools"
   "python"

   "xonsh"

   "python-pycryptodome"
   "python-cryptography"
   "python-gmpy2"
   "python-sympy"


   "python-numpy"
   "python-ipython"


   "gdb-multiarch"
   "radare2"


   "strace"
   "ltrace"

   "nasm"
   "binutils"


   "netcat"

   "file"))
