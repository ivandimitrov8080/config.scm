;; config/packages/emacs.scm — custom Emacs build with all packages
;;
;; Defines `emacs-ivan': emacs-pgtk with every package from the Emacs config
;; bundled as propagated-inputs, including the two custom packages (ob-nix,
;; emigo) that are not in upstream Guix.
;;
;; The init file (systems/emacs.org) is installed to
;; ~/.emacs.d/emacs.org at the home-environment level via
;; home-files-service-type in systems/desktop.scm.
;;
;; To add a new Emacs package:
;;   1. Find its Guix name:  guix search emacs-<name>
;;   2. Add it to the list in %emacs-packages below.
;;   3. If it's not in Guix, create a new file in config/packages/ and
;;      add it to the imports and the list here.

(define-module (config packages emacs)
  #:use-module (guix packages)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages mail)         ; notmuch
  #:use-module (config packages ob-nix)
  #:use-module (config packages emigo)
  #:export (emacs-ivan
            %emacs-packages))

;; ---------------------------------------------------------------------------
;; All Emacs packages to bundle.
;; Grouped by function to make additions easy.
;; ---------------------------------------------------------------------------

(define %emacs-packages
  (list
   ;; --- Completion & discovery ---
   emacs-which-key
   emacs-vertico
   emacs-orderless
   emacs-marginalia
   emacs-consult
   emacs-helpful

   ;; --- AI / agents ---
   emacs-gptel
   emacs-emigo               ; custom: config/packages/emigo.scm

   ;; --- Navigation & editing ---
   emacs-avy
   emacs-multiple-cursors
   emacs-expand-region
   emacs-smartparens
   emacs-undo-tree

   ;; --- Dev tools ---
   emacs-magit
   emacs-projectile
   emacs-company
   emacs-flycheck

   ;; --- LSP ---
   ;; eglot is built into Emacs 29+; no separate package needed.
   ;; Language servers are installed system-wide (see systems/desktop.scm).

   ;; --- Language modes ---
   emacs-nix-mode
   emacs-elm-mode
   emacs-haskell-mode
   emacs-web-mode
   emacs-js2-mode
   emacs-json-mode
   emacs-markdown-mode
   emacs-yaml-mode

   ;; --- Org ---
   emacs-htmlize
   emacs-ob-nix              ; custom: config/packages/ob-nix.scm

   ;; --- Tree-sitter (built-in treesit, Emacs 29+) ---
   ;; The old MELPA tree-sitter dynamic module is not in Guix.
   ;; emacs-treesit-auto provides automatic grammar management.
   emacs-treesit-auto

   ;; --- UI / appearance ---
   emacs-doom-modeline
   emacs-rainbow-delimiters
   emacs-catppuccin-theme
   emacs-all-the-icons
   emacs-all-the-icons-dired

   ;; --- File management ---
   emacs-dired-quick-sort

   ;; --- Mail ---
   emacs-notmuch

   ;; --- Misc ---
   emacs-sql-indent))

;; ---------------------------------------------------------------------------
;; The composed Emacs package.
;; Using package-with-configure-flag / emacs-with-packages pattern:
;;   emacs-pgtk is the base; all packages above become propagated-inputs so
;;   they land on the load-path automatically.
;; ---------------------------------------------------------------------------

(define-public emacs-ivan
  (package
    (inherit emacs-pgtk)
    (name "emacs-ivan")
    (synopsis "Emacs pgtk with full package set for Ivan's config")
    (description
     "emacs-pgtk bundled with every Emacs package referenced by
@file{systems/emacs.org}.  Drop-in replacement for @code{emacs-pgtk}.")
    (propagated-inputs
     (append %emacs-packages
             (package-propagated-inputs emacs-pgtk)))))
