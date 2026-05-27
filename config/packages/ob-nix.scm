;; config/packages/ob-nix.scm — org-babel support for Nix (not in upstream Guix)
;;
;; Source: https://github.com/emacsmirror/ob-nix
;; To update the hash, run:
;;   guix download https://github.com/emacsmirror/ob-nix/archive/<commit>.tar.gz

(define-module (config packages ob-nix)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (emacs-ob-nix))

(define-public emacs-ob-nix
  (let ((commit "76d71b37fb031f25bd52ff9c98b29292ebe0424e")
        (revision "1"))
    (package
      (name "emacs-ob-nix")
      (version (git-version "0.0.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/emacsmirror/ob-nix")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          ;; Run: guix hash -rx . (in the fetched source directory)
          ;; or:  guix download <tarball-url>
          (base32 "1m9xxw8kncbifr3g9spqnp16iqmcfa1rblk01d3rwiricd9agb7n"))))
      (build-system emacs-build-system)
      (synopsis "Org-babel support for Nix")
      (description
       "Provides Org mode Babel integration for the Nix expression language,
allowing @code{#+begin_src nix} blocks to be evaluated in Org documents.")
      (home-page "https://github.com/emacsmirror/ob-nix")
      (license license:gpl3+))))
