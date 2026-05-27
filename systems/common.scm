;; systems/common.scm — shared definitions reused across machine configs
;;
;; This is a proper Guile module so any system config can import it with:
;;   (use-modules (systems common))
;;
;; To extend: add packages to %base-packages, services to %base-services,
;; or define additional user accounts alongside `%primary-user'.

(define-module (systems common)
  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (gnu system keyboard)
  #:use-module (gnu services)
  #:use-module (gnu services networking)
  #:use-module (gnu services ssh)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages file)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages man)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages wm)          ; brightnessctl, etc.
  #:use-module (gnu packages xdisorg)
  #:export (%primary-user
            %my-keyboard-layout
            %base-packages
            %base-services))

;; ---------------------------------------------------------------------------
;; Keyboard layout
;; ---------------------------------------------------------------------------

(define-public %my-keyboard-layout
  ;; us as primary, Bulgarian phonetic as secondary.
  ;; Win+Space toggles between them (matching your sway xkb_options).
  (keyboard-layout "us,bg"
                   "phonetic"
                   #:options '("grp:win_space_toggle")))

;; ---------------------------------------------------------------------------
;; Primary user account
;; ---------------------------------------------------------------------------

(define-public %primary-user
  (user-account
    (name "ivand")
    (comment "Ivan")
    (group "users")
    (supplementary-groups
     '("wheel"     ; sudo
       "audio"
       "video"
       "input"     ; evdev / libinput
       "seat"      ; seatd / logind seat management
       "netdev"))  ; NetworkManager
    (home-directory "/home/ivand")))

;; ---------------------------------------------------------------------------
;; Base packages installed on every machine
;;
;; Add broadly useful CLI tools here.  GUI / desktop packages belong in the
;; specific machine config (e.g. systems/desktop.scm).
;; ---------------------------------------------------------------------------

(define-public %base-packages
  (append
   (list
    ;; Core utilities
    nss-certs       ; TLS certificates
    curl
    git
    openssh
    ;; Shell
    bash
    bash-completion
    ;; Editors (fallback)
    vim
    ;; File tools
    file
    ;; Fonts (needed by desktop apps even on headless, harmless overhead)
    font-dejavu
    font-liberation
    ;; Manuals
    man-pages
    ;; Password management
    password-store
    ;; Brightness control (used by sway keybindings)
    brightnessctl)
   %base-packages))  ; upstream Guix base packages

;; ---------------------------------------------------------------------------
;; Base services shared across machines
;;
;; Add services that every machine should run here.
;; Machine-specific services (desktop, server, etc.) go in their own files.
;; ---------------------------------------------------------------------------

(define-public %base-services
  (list
   ;; NetworkManager for easy Wi-Fi / wired management.
   ;; Remove and use wpa_supplicant-service-type if you prefer.
   (service network-manager-service-type)
   (service wpa-supplicant-service-type)

   ;; SSH daemon — disabled by default (no open port); enable per-machine.
   ;; Uncomment and tune in the machine config:
   ;; (service openssh-service-type
   ;;          (openssh-configuration
   ;;           (permit-root-login #f)
   ;;           (password-authentication? #f)))
   ))
