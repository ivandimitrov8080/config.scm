;; config/packages/emigo.scm — agentic AI Emacs plugin (not in upstream Guix)
;;
;; Source: https://github.com/MatthewZMD/emigo
;; emigo requires a Python environment at runtime for its backend process.
;; The Python deps are bundled separately via the emigo-python input.
;;
;; To update the hash, run:
;;   guix hash -rx . (in the fetched source directory)

(define-module (config packages emigo)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:export (emacs-emigo))

(define-public emacs-emigo
  (let ((commit "91d122a85cac1965e1a52185ed8711c5ef8f24c9")
        (revision "1"))
    (package
      (name "emacs-emigo")
      (version (git-version "0.1.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/MatthewZMD/emigo")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          ;; Run: guix hash -rx . (in the fetched source directory)
          (base32 "0000000000000000000000000000000000000000000000000000"))))
      (build-system emacs-build-system)
      ;; emigo spawns a Python subprocess for its AI backend.
      ;; These are runtime dependencies placed on PATH via propagated-inputs.
      (propagated-inputs
       (list python
             python-networkx
             python-pygments))
      (synopsis "Agentic AI coding assistant for Emacs")
      (description
       "Emigo is an agentic AI coding plugin for Emacs.  It spawns a Python
backend process and communicates with AI language model APIs to assist with
code generation and editing tasks.")
      (home-page "https://github.com/MatthewZMD/emigo")
      (license license:gpl3+))))
