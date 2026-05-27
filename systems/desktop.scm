;; systems/desktop.scm — Guix Home configuration for the desktop machine
;;
;; Manages the user environment: sway (swayfx), Emacs, fonts, and supporting
;; desktop tools.  This is a *home-environment* (managed by `guix home'), not
;; an operating-system declaration.
;;
;; Usage:
;;   guix home reconfigure systems/desktop.scm
;;
;; First time:
;;   guix home container systems/desktop.scm   ; test in a container first
;;
;; The operating-system (bootloader, filesystems, system services) lives in a
;; separate file — add systems/myhost-os.scm when you need it, following the
;; pattern in systems/common.scm.

(use-modules
 ;; Guix Home core
 (gnu home)
 (gnu home services)
 (gnu home services desktop)     ; home-dbus-service-type
 ;; home-files-service-type is in (gnu home services)
 (gnu home services fontutils)   ; home-fontconfig-service-type
 (gnu home services sway)        ; home-sway-service-type
 (gnu home services shepherd)    ; home-shepherd-service-type

 ;; System modules (for keyboard-layout, packages, etc.)
 (gnu system keyboard)

 ;; Package collections
 (gnu packages admin)            ; htop, etc.
 (gnu packages base)
 (gnu packages bash)
 (gnu packages certs)
 (gnu packages curl)
 (gnu packages emacs-xyz)        ; emacs-pgtk referenced indirectly
 (gnu packages file)
 (gnu packages fonts)
 (gnu packages fontutils)
 (gnu packages freedesktop)      ; xdg-utils, pipewire, etc.
 (gnu packages glib)             ; dbus-launch
 (gnu packages gnome)            ; gnome-keyring, polkit-gnome
 (gnu packages gtk)              ; gtk+ themes
 (gnu packages image-viewers)    ; imv
 (gnu packages linux)            ; brightnessctl, alsa-utils
 (gnu packages man)
 (gnu packages music)            ; playerctl, etc.
 (gnu packages password-utils)
 (gnu packages pulseaudio)       ; pactl / pamixer for volume
 (gnu packages ssh)
 (gnu packages terminals)        ; kitty
 (gnu packages version-control)
 (gnu packages video)            ; mpv
 (gnu packages gnuzilla)        ; icecat (Firefox is not in official Guix)
 (gnu packages wm)               ; swayfx, swaylock, swayidle, waybar, rofi, mako, kanshi
 (gnu packages xdisorg)          ; slurp, grim (screenshots)
 (gnu packages xorg)             ; xrdb, fonts

 ;; Our custom channel packages
 (config packages emacs))         ; emacs-ivan

;; ============================================================================
;; Keyboard layout (matches the sway input config below)
;; ============================================================================

(define %keyboard-layout
  (keyboard-layout "us,bg" "phonetic"
                   #:options '("grp:win_space_toggle")))

;; ============================================================================
;; Sway keybindings
;; translated from the Nix wayland.windowManager.sway config
;; ============================================================================

(define %sway-keybindings
  ;; Keybindings are an alist: (symbol . "action-string").
  ;; $mod refers to the sway variable set in (variables ...) below.
  `(;; --- Launchers ---
    ($mod+p           . "exec rofi -show drun")
    ($mod+Return      . "exec kitty")
    (end              . "exec rofi -show calc")

    ;; --- Window management ---
    ($mod+Shift+q     . "kill")
    ($mod+Shift+c     . "reload")
    ($mod+f           . "fullscreen toggle")
    ($mod+Shift+space . "floating toggle")
    ($mod+space       . "focus mode_toggle")

    ;; --- Focus movement (vim-style) ---
    ($mod+h           . "focus left")
    ($mod+j           . "focus down")
    ($mod+k           . "focus up")
    ($mod+l           . "focus right")
    ($mod+Left        . "focus left")
    ($mod+Down        . "focus down")
    ($mod+Up          . "focus up")
    ($mod+Right       . "focus right")

    ;; --- Move windows ---
    ($mod+Shift+h     . "move left")
    ($mod+Shift+j     . "move down")
    ($mod+Shift+k     . "move up")
    ($mod+Shift+l     . "move right")

    ;; --- Workspaces ---
    ($mod+1           . "workspace number 1")
    ($mod+2           . "workspace number 2")
    ($mod+3           . "workspace number 3")
    ($mod+4           . "workspace number 4")
    ($mod+5           . "workspace number 5")
    ($mod+6           . "workspace number 6")
    ($mod+7           . "workspace number 7")
    ($mod+8           . "workspace number 8")
    ($mod+9           . "workspace number 9")
    ($mod+0           . "workspace number 10")
    ($mod+Shift+1     . "move container to workspace number 1")
    ($mod+Shift+2     . "move container to workspace number 2")
    ($mod+Shift+3     . "move container to workspace number 3")
    ($mod+Shift+4     . "move container to workspace number 4")
    ($mod+Shift+5     . "move container to workspace number 5")
    ($mod+Shift+6     . "move container to workspace number 6")
    ($mod+Shift+7     . "move container to workspace number 7")
    ($mod+Shift+8     . "move container to workspace number 8")
    ($mod+Shift+9     . "move container to workspace number 9")
    ($mod+Shift+0     . "move container to workspace number 10")

    ;; --- Layout ---
    ($mod+b           . "splith")
    ($mod+v           . "splitv")
    ($mod+s           . "layout stacking")
    ($mod+w           . "layout tabbed")
    ($mod+e           . "layout toggle split")

    ;; --- Scratchpad ---
    ($mod+Shift+minus . "move scratchpad")
    ($mod+minus       . "scratchpad show")

    ;; --- Audio (XF86 keys) ---
    (XF86AudioMute          . "exec pactl set-sink-mute @DEFAULT_SINK@ toggle")
    (Shift+XF86AudioMute    . "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    (XF86AudioLowerVolume   . "exec pactl set-sink-volume @DEFAULT_SINK@ -5%")
    (Shift+XF86AudioLowerVolume . "exec pactl set-source-volume @DEFAULT_SOURCE@ -5%")
    (XF86AudioRaiseVolume   . "exec pactl set-sink-volume @DEFAULT_SINK@ +5%")
    (Shift+XF86AudioRaiseVolume . "exec pactl set-source-volume @DEFAULT_SOURCE@ +5%")

    ;; --- Brightness ---
    (XF86MonBrightnessUp    . "exec brightnessctl set 10%+")
    (XF86MonBrightnessDown  . "exec brightnessctl set 10%-")

    ;; --- Lock screen ---
    (alt+shift+l      . "exec swaylock -c 000000")

    ;; --- Screenshots (grim + slurp) ---
    ($mod+Shift+s     . "exec grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png")
    ($mod+Shift+a     . "exec grim -g \"$(slurp)\" - | wl-copy")
    ($mod+Shift+w     . "exec grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png")

    ;; --- Resize mode ---
    ($mod+r           . "mode \"resize\"")))

;; ============================================================================
;; Sway configuration
;; ============================================================================

(define %sway-config
  (sway-configuration
   ;; Install swayfx instead of plain sway; also bring in supporting tools.
   (packages
    (list swayfx
          swaylock
          swayidle
          waybar
          rofi
          mako              ; notification daemon
          kanshi            ; dynamic output management
          grim              ; screenshot tool
          slurp             ; screen area selector
          wl-clipboard      ; wl-copy / wl-paste
          brightnessctl
          playerctl))

   ;; Sway variables — referenced as $name in keybindings and exec commands.
   (variables
    `((mod      . "Mod4")
      (term     . "kitty")
      (menu     . "rofi -show drun")))

   ;; Keyboard + pointer inputs.
   (inputs
    (list
     (sway-input
      (identifier "*")
      (layout %keyboard-layout))
     ;; Touchpad-specific overrides.
     (sway-input
      (identifier "type:touchpad")
      (tap #t)
      (disable-while-typing #t)
      (extra-content '("scroll_method two_finger"
                       "natural_scroll enabled")))))

   ;; Keybindings (defined above).
   (keybindings %sway-keybindings)

   ;; No bars — waybar is started as a startup program.
   ;; (bar ...) omitted intentionally.

   ;; Autostart programs (exec — run once on sway start).
   (startup-programs
    (list
     ;; Status bar
     "waybar"
     ;; Notification daemon
     "mako"
     ;; Idle + lock: lock after 5 min, screen off after 10 min
     "swayidle -w timeout 300 'swaylock -c 000000' timeout 600 'swaymsg \"output * power off\"' resume 'swaymsg \"output * power on\"'"
     ;; Browser on workspace 2 (update app_id if using Firefox via nonguix)
     "swaymsg 'workspace 2; exec icecat'"
     ;; Terminal on workspace 1
     "swaymsg 'workspace 1; exec kitty'"))

   ;; exec_always (re-run on sway reload — good for output managers)
   (startup+reload-programs
    (list "kanshi"))

   ;; Window assignments (app_id → workspace)
   ;; SwayFX visual effects, gaps, borders, and other extras.
   (extra-content
    '(;; --- Window assignments ---
      "assign [app_id=\"^icecat$\"] workspace 2"
      ;; If using Firefox from nonguix, change to: assign [app_id=\"^firefox$\"] workspace 2

      ;; --- Gaps (matching your Nix config: horizontal=2, vertical=2) ---
      "gaps horizontal 2"
      "gaps vertical 2"

      ;; --- Borders ---
      "default_border none"
      "default_floating_border none"
      "titlebar_border_thickness 0"

      ;; --- SwayFX visual effects ---
      "blur enable"
      "shadows enable"
      "corner_radius 15"
      "default_dim_inactive 0.2"

      ;; --- Misc behaviour ---
      "focus_follows_mouse no"
      "mouse_warping none"

      ;; --- Resize mode ---
      "mode \"resize\" {"
      "  bindsym h resize shrink width 10px"
      "  bindsym j resize grow height 10px"
      "  bindsym k resize shrink height 10px"
      "  bindsym l resize grow width 10px"
      "  bindsym Left resize shrink width 10px"
      "  bindsym Down resize grow height 10px"
      "  bindsym Up resize shrink height 10px"
      "  bindsym Right resize grow width 10px"
      "  bindsym Return mode \"default\""
      "  bindsym Escape mode \"default\""
      "}"))))

;; ============================================================================
;; Home environment
;; ============================================================================

(home-environment

 ;; Packages installed into the user profile.
 ;; Add GUI / desktop packages here.  CLI base packages belong in
 ;; systems/common.scm:%base-packages.
 (packages
  (list
   ;; Emacs (custom build with all packages)
   emacs-ivan

   ;; Terminal
   kitty

   ;; Browser — Firefox is not in official Guix; IceCat is the packaged
   ;; GNU/Firefox fork.  To use upstream Firefox, add a custom package in
   ;; config/packages/ fetching from upstream Mozilla binaries, or use
   ;; nonguix channel's `firefox' package (add it to channels.scm).
   icecat

   ;; Fonts
   font-dejavu
   font-liberation
   font-google-noto
   font-awesome         ; used by waybar / doom-modeline icons

   ;; Screenshot / clipboard
   grim
   slurp
   wl-clipboard

   ;; Media
   mpv
   imv                  ; image viewer

   ;; TLS certs
   nss-certs

   ;; Core CLI tools
   curl
   git
   openssh
   brightnessctl
   playerctl
   pamixer              ; volume CLI (alternative to pactl scripts)

   ;; Nix LSP for Emacs eglot:
   ;; Neither `nil' nor `nixd' are in official Guix as of 2026.
   ;; Options:
   ;;   a) Build from source: add a custom package in config/packages/nil-lsp.scm
   ;;   b) Install via `guix shell' in Nix-managed projects
   ;; Uncomment when you have a nil package:
   ;; nil
   ))

 ;; Home services
 (services
  (list
   ;; ---- User D-Bus session ----
   (service home-dbus-service-type)

   ;; ---- Font cache ----
   (service home-fontconfig-service-type)

   ;; ---- Sway (swayfx) ----
   (service home-sway-service-type %sway-config)

   ;; ---- Emacs init files ----
   ;; Place emacs.org at ~/.emacs.d/emacs.org.
   ;; Also drop a minimal init.el that loads it via org-babel.
   (service home-files-service-type
    `((".emacs.d/emacs.org"
       ,(local-file "emacs.org"))
      (".emacs.d/init.el"
       ,(plain-file "init.el"
         ";; init.el — generated by systems/desktop.scm
;; Loads the literate config from emacs.org via org-babel.
(require 'org)
(org-babel-load-file
 (expand-file-name \"emacs.org\" user-emacs-directory))
"))))

   ;; ---- Shepherd user daemons ----
   ;; Add long-running user services here (e.g. a local syncthing instance).
   ;; Example (commented out):
   ;;
   ;; (service home-shepherd-service-type
   ;;  (home-shepherd-configuration
   ;;   (services
   ;;    (list
   ;;     (shepherd-service
   ;;      (provision '(syncthing))
   ;;      (start #~(make-forkexec-constructor
   ;;                (list #$(file-append syncthing "/bin/syncthing")
   ;;                      "-no-browser")))
   ;;      (stop #~(make-kill-destructor)))))))
   )))
