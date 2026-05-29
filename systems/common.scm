;; systems/common.scm — shared definitions reused across machine configs
;;
;; Exports:
;;   %my-keyboard-layout        — keyboard-layout record (us+bg phonetic)
;;   %primary-user              — user-account for ivand
;;   %base-packages             — CLI packages for every machine
;;   %my-base-services          — services for every machine
;;   %guix-service              — guix daemon service (guix-service-type)
;;   guix-home-service-for      — helper: (user he) → guix-home-service-type
;;   %sway-keybindings          — sway keybinding alist
;;   %sway-config               — sway-configuration record
;;   home-wpaperd-configuration — configuration record for wpaperd
;;   home-wpaperd-service-type  — Guix home service for wpaperd
;;   %desktop-home-environment  — home-environment for the desktop
;;
;; Import in any system config with:
;;   (use-modules (systems common))

(define-module (systems common)
  ;; Guix core
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix records) ;define-record-type*
  
  ;; GNU system
  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (gnu system keyboard)

  ;; Services
  #:use-module (gnu services)
  #:use-module (gnu services networking)
  #:use-module (gnu services ssh)
  #:use-module (gnu services desktop) ;seatd-service-type
  #:use-module (gnu services guix) ;guix-service-type, guix-home-service-type
  
  ;; Home
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services desktop) ;home-dbus-service-type
  #:use-module (gnu home services fontutils) ;home-fontconfig-service-type
  #:use-module (gnu home services sway) ;home-sway-service-type
  #:use-module (gnu home services shepherd) ;home-shepherd-service-type
  #:use-module (gnu home services sound) ;home-pipewire-service-type
  #:use-module (gnu home services xdg) ;home-xdg-configuration-files-service-type
  
  ;; Packages
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages admin) ;htop, tree, nmap, netcat
  #:use-module (gnu packages compression) ;zip, unzip
  #:use-module (gnu packages nss) ;nss-certs
  #:use-module (gnu packages curl)
  #:use-module (gnu packages emacs) ;emacs-pgtk (fallback base)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages file)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gnuzilla) ;icecat
  #:use-module (gnu packages image-viewers) ;imv
  #:use-module (gnu packages linux) ;brightnessctl, strace
  #:use-module (gnu packages lsof) ;lsof
  #:use-module (gnu packages man)
  #:use-module (gnu packages music) ;playerctl
  #:use-module (gnu packages ncdu) ;ncdu
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages rsync) ;rsync
  #:use-module (gnu packages rust-apps) ;ripgrep
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages busybox)
  #:use-module (gnu packages terminals) ;kitty
  #:use-module (gnu packages tmux) ;tmux
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages video) ;mpv
  #:use-module (gnu packages vim)
  #:use-module (gnu packages web) ;jq
  #:use-module (gnu packages wget) ;wget
  #:use-module (gnu packages wm) ;swayfx, waybar, rofi, mako, etc.
  #:use-module (gnu packages image) ;grim, slurp
  #:use-module (gnu packages xdisorg) ;wl-clipboard
  
  ;; Custom channel packages
  #:use-module (config packages emacs) ;emacs-ivan, %emacs-packages
  #:use-module (config packages wttrbar) ;wttrbar
  #:use-module (config packages wpaperd) ;wpaperd
  
  #:export (%my-keyboard-layout %primary-user
                                %base-packages
                                %my-base-services
                                %sway-keybindings
                                %sway-config
                                %waybar-config
                                %waybar-style
                                %desktop-home-environment
                                %guix-service
                                guix-home-service-for
                                home-wpaperd-configuration
                                home-wpaperd-configuration?
                                home-wpaperd-configuration-wpaperd
                                home-wpaperd-configuration-path
                                home-wpaperd-configuration-duration
                                home-wpaperd-service-type))

;; ---------------------------------------------------------------------------
;; Keyboard layout
;; ---------------------------------------------------------------------------

(define-public %my-keyboard-layout
  (keyboard-layout "us,bg" ",phonetic"
                   #:options '("grp:win_space_toggle")))

;; ---------------------------------------------------------------------------
;; Primary user account
;; ---------------------------------------------------------------------------

(define-public %primary-user
  (user-account
    (name "ivand")
    (comment "Ivan")
    (group "users")
    (supplementary-groups '("wheel" "audio" "video" "input" "netdev"))
    (home-directory "/home/ivand")))

;; ---------------------------------------------------------------------------
;; Base packages — every machine
;; ---------------------------------------------------------------------------

;; Capture upstream %base-packages before we shadow the name.
(define %upstream-base-packages
  (@ (gnu system) %base-packages))

(define-public %base-packages
  (append (list busybox

                ;; Network / download
                curl
                wget

                ;; Version control
                git

                ;; Remote access
                openssh

                ;; Shell
                bash
                bash-completion

                ;; Editors
                vim

                ;; File inspection
                file
                tree
                which
                diffutils

                ;; Archives
                zip
                unzip

                ;; Process / system inspection
                htop
                lsof
                strace

                ;; Networking tools
                nmap
                netcat

                ;; Text processing
                ripgrep
                jq

                ;; File transfer / sync
                rsync

                ;; Disk usage
                ncdu

                ;; Terminal multiplexer
                tmux

                ;; Fonts
                font-dejavu
                font-liberation

                ;; Docs
                man-pages

                ;; Security
                password-store

                ;; Hardware
                brightnessctl) %upstream-base-packages))

;; ---------------------------------------------------------------------------
;; Base services — every machine
;; ---------------------------------------------------------------------------

(define-public %my-base-services
  ;; Services for real machines.  The VM uses the upstream %base-services
  ;; directly to avoid conflicts with dhcpcd.
  (list (service network-manager-service-type)
        (service wpa-supplicant-service-type)))

;; ---------------------------------------------------------------------------
;; Guix daemon and home wiring
;; ---------------------------------------------------------------------------

;; The Guix package-manager daemon.  Every proper operating-system should
;; include this (it is also present in the upstream %base-services, but
;; making it explicit here lets other modules reference it directly).
(define-public %guix-service
  (service guix-service-type))

;; Return a guix-home-service-type service that activates HOME-ENV for USER
;; at boot.  Typically used in an operating-system's services list.
;;
;; Example:
;;   (guix-home-service-for "ivand" %vm-home-environment)
(define-public (guix-home-service-for user home-env)
  (service guix-home-service-type
           (list (list user home-env))))

;; ---------------------------------------------------------------------------
;; wpaperd home service
;;
;; Manages the wpaperd wallpaper daemon for Wayland.  Writes
;; ~/.config/wpaperd/wallpaper.toml, installs the package into the home
;; profile, and registers a shepherd service so the daemon starts with the
;; user session.
;;
;; Configuration:
;;   (service home-wpaperd-service-type
;;            (home-wpaperd-configuration
;;             (path     "~/Pictures/bg")  ; wallpaper directory
;;             (duration "10m")))          ; time per image
;;
;; The generated wallpaper.toml looks like:
;;   [default]
;;   path = "~/Pictures/bg"
;;   duration = "10m"
;;
;; wpaperd expands ~ at startup, so the path works regardless of $HOME.
;; ---------------------------------------------------------------------------

(define-record-type* <home-wpaperd-configuration> home-wpaperd-configuration
                     make-home-wpaperd-configuration
  home-wpaperd-configuration?
  ;; The wpaperd package (daemon + wpaperctl CLI).
  (wpaperd home-wpaperd-configuration-wpaperd
           (default wpaperd))
  ;; Wallpaper directory for the "default" monitor section.
  ;; Supports ~ (tilde expansion performed by wpaperd at runtime).
  (path home-wpaperd-configuration-path
        (default "~/Pictures/bg"))
  ;; How long each wallpaper is displayed before rotating.
  ;; Uses humantime format: "30s", "10m", "2h", etc.
  (duration home-wpaperd-configuration-duration
            (default "10m")))

(define (home-wpaperd-config-file config)
  "Serialize HOME-WPAPERD-CONFIGURATION to a wallpaper.toml file-like object."
  (plain-file "wallpaper.toml"
              (string-append "[default]\n"
                             "path = \""
                             (home-wpaperd-configuration-path config)
                             "\"\n"
                             "duration = \""
                             (home-wpaperd-configuration-duration config)
                             "\"\n")))

(define (home-wpaperd-xdg-config-files config)
  "Return the XDG config file alist for wpaperd."
  `(("wpaperd/wallpaper.toml" ,(home-wpaperd-config-file config))))

(define (home-wpaperd-shepherd-service config)
  "Return a shepherd service that starts the wpaperd daemon."
  (list (shepherd-service (provision '(wpaperd))
                          (documentation
                           "wpaperd wallpaper daemon for Wayland.")
                          ;; No hard requirement on sway: shepherd launches it and sway connects
                          ;; to the already-running daemon via the wlr-layer-shell protocol.
                          (start #~(make-forkexec-constructor (list #$(file-append
                                                                       (home-wpaperd-configuration-wpaperd
                                                                        config)
                                                                       "/bin/wpaperd"))))
                          (stop #~(make-kill-destructor))
                          (respawn? #t))))

(define (home-wpaperd-profile-service config)
  "Install wpaperd into the home profile so wpaperctl is on PATH."
  (list (home-wpaperd-configuration-wpaperd config)))

(define-public home-wpaperd-service-type
  (service-type (name 'home-wpaperd)
                (extensions (list
                             ;; Register the shepherd daemon.
                             (service-extension home-shepherd-service-type
                                                home-wpaperd-shepherd-service)
                             ;; Write ~/.config/wpaperd/wallpaper.toml.
                             (service-extension
                              home-xdg-configuration-files-service-type
                              home-wpaperd-xdg-config-files)
                             ;; Add wpaperd to the home profile (makes wpaperctl available on PATH).
                             (service-extension home-profile-service-type
                                                home-wpaperd-profile-service)))
                (default-value (home-wpaperd-configuration))
                (description
                 "Run @command{wpaperd}, a wallpaper daemon for Wayland compositors
implementing the wlr-layer-shell protocol.  Writes
@file{~/.config/wpaperd/wallpaper.toml} and registers a Shepherd service
so the daemon starts automatically with the user session.")))

;; ---------------------------------------------------------------------------
;; Sway keybindings
;; ---------------------------------------------------------------------------

(define-public %sway-keybindings
  `( ;--- Launchers ---
     ($mod+p . "exec rofi -show drun")
    ($mod+Return . "exec kitty")
    (end . "exec rofi -show calc")

    ;; --- Window management ---
    ($mod+Shift+q . "kill")
    ($mod+Shift+c . "reload")
    ($mod+f . "fullscreen toggle")
    ($mod+Shift+space . "floating toggle")
    ($mod+space . "focus mode_toggle")

    ;; --- Focus movement (vim-style) ---
    ($mod+h . "focus left")
    ($mod+j . "focus down")
    ($mod+k . "focus up")
    ($mod+l . "focus right")
    ($mod+Left . "focus left")
    ($mod+Down . "focus down")
    ($mod+Up . "focus up")
    ($mod+Right . "focus right")

    ;; --- Move windows ---
    ($mod+Shift+h . "move left")
    ($mod+Shift+j . "move down")
    ($mod+Shift+k . "move up")
    ($mod+Shift+l . "move right")

    ;; --- Workspaces 1-10 ---
    ($mod+1 . "workspace number 1")
    ($mod+2 . "workspace number 2")
    ($mod+3 . "workspace number 3")
    ($mod+4 . "workspace number 4")
    ($mod+5 . "workspace number 5")
    ($mod+6 . "workspace number 6")
    ($mod+7 . "workspace number 7")
    ($mod+8 . "workspace number 8")
    ($mod+9 . "workspace number 9")
    ($mod+0 . "workspace number 10")
    ($mod+Shift+1 . "move container to workspace number 1")
    ($mod+Shift+2 . "move container to workspace number 2")
    ($mod+Shift+3 . "move container to workspace number 3")
    ($mod+Shift+4 . "move container to workspace number 4")
    ($mod+Shift+5 . "move container to workspace number 5")
    ($mod+Shift+6 . "move container to workspace number 6")
    ($mod+Shift+7 . "move container to workspace number 7")
    ($mod+Shift+8 . "move container to workspace number 8")
    ($mod+Shift+9 . "move container to workspace number 9")
    ($mod+Shift+0 . "move container to workspace number 10")

    ;; --- Layout ---
    ($mod+b . "splith")
    ($mod+v . "splitv")
    ($mod+s . "layout stacking")
    ($mod+w . "layout tabbed")
    ($mod+e . "layout toggle split")

    ;; --- Scratchpad ---
    ($mod+Shift+minus . "move scratchpad")
    ($mod+minus . "scratchpad show")

    ;; --- Audio ---
    (XF86AudioMute . "exec pactl set-sink-mute @DEFAULT_SINK@ toggle")
    (Shift+XF86AudioMute . "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    (XF86AudioLowerVolume . "exec pactl set-sink-volume @DEFAULT_SINK@ -5%")
    (Shift+XF86AudioLowerVolume . "exec pactl set-source-volume @DEFAULT_SOURCE@ -5%")
    (XF86AudioRaiseVolume . "exec pactl set-sink-volume @DEFAULT_SINK@ +5%")
    (Shift+XF86AudioRaiseVolume . "exec pactl set-source-volume @DEFAULT_SOURCE@ +5%")

    ;; --- Brightness ---
    (XF86MonBrightnessUp . "exec brightnessctl set 10%+")
    (XF86MonBrightnessDown . "exec brightnessctl set 10%-")

    ;; --- Lock ---
    (alt+shift+l . "exec swaylock -c 000000")

    ;; --- Screenshots ---
    ($mod+Shift+s . "exec grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png")
    ($mod+Shift+a . "exec grim -g \"$(slurp)\" - | wl-copy")
    ($mod+Shift+w . "exec grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png")

    ;; --- Resize mode ---
    ($mod+r . "mode \"resize\"")))

;; ---------------------------------------------------------------------------
;; Sway configuration
;; ---------------------------------------------------------------------------

(define-public %sway-config
  (sway-configuration (packages (list swayfx
                                      swaylock
                                      swayidle
                                      waybar
                                      rofi
                                      mako
                                      kanshi
                                      grim
                                      slurp
                                      wl-clipboard
                                      brightnessctl
                                      playerctl))

                      (variables `((mod . "Mod4") (left . "h")
                                   (down . "j")
                                   (up . "k")
                                   (right . "l")
                                   (term . "kitty")
                                   (menu . "rofi -show drun")))

                      (inputs (list (sway-input (identifier "*")
                                                (layout %my-keyboard-layout))
                                    (sway-input (identifier "type:touchpad")
                                                (tap #t)
                                                (disable-while-typing #t)
                                                (extra-content '("scroll_method two_finger"
                                                                 "natural_scroll enabled")))))

                      (keybindings %sway-keybindings)

                      (startup-programs (list "mako"
                                         "swaymsg 'workspace 2; exec icecat'"
                                         "swaymsg 'workspace 1; exec kitty'"))

                      (startup+reload-programs (list "kanshi"))

                      (extra-content '("assign [app_id=\"^icecat$\"] workspace 2"
                                       ;; Gaps
                                       "gaps horizontal 2"
                                       "gaps vertical 2"
                                       ;; Borders
                                       "default_border none"
                                       "default_floating_border none"
                                       "titlebar_border_thickness 0"
                                       ;; SwayFX
                                       "blur enable"
                                       "shadows enable"
                                       "corner_radius 15"
                                       "default_dim_inactive 0.2"
                                       ;; Behaviour
                                       "focus_follows_mouse no"
                                       "mouse_warping none"))))

;; ---------------------------------------------------------------------------
;; Waybar
;; ---------------------------------------------------------------------------

;; Waybar config as a mixed-text-file so the wttrbar store path is
;; spliced in at build time without needing a computed-file gexp.
(define %waybar-config
  (mixed-text-file "waybar-config"
   "[{\n"
   "  \"layer\": \"top\",\n"
   "  \"position\": \"top\",\n"
   "  \"height\": 30,\n"
   "  \"output\": [\"eDP-1\", \"HDMI-A-1\", \"*\"],\n"
   "  \"modules-left\": [\"sway/workspaces\", \"sway/mode\"],
"
   "  \"modules-center\": [\"clock#week\", \"clock#year\", \"clock#time\"],
"
   "  \"modules-right\": [\"custom/weather\", \"network\", \"wireplumber#sink\", \"wireplumber#source\", \"battery\"],
"
   "  \"clock#time\": {\"interval\": 1, \"format\": \"{:%H:%M:%S}\", \"tooltip\": false},
"
   "  \"clock#week\": {\"format\": \"{:%a}\", \"tooltip\": false},
"
   "  \"clock#year\": {\"format\": \"{:%Y-%m-%d}\", \"tooltip\": false},
"
   "  \"battery\": {\n"
   "    \"interval\": 1,\n"
   "    \"format\": \"{icon} {capacity}% {time}\",
"
   "    \"format-time\": \" {H} h {M} m\",\n"
   "    \"format-icons\": [\"\", \"\", \"\", \"\", \"\"],
"
   "    \"states\": {\"warning\": 30, \"critical\": 15},
"
   "    \"tooltip\": false\n"
   "  },\n"
   "  \"wireplumber#sink\": {\n"
   "    \"node-type\": \"Audio/Sink\",\n"
   "    \"format\": \"{volume}% <span color='#a6e3a1'>{icon}</span>\",
"
   "    \"format-muted\": \"{volume}% <span color='#f38ba8'>󰝟</span>\",
"
   "    \"format-icons\": [\"\", \"\", \"\"],\n"
   "    \"max-volume\": 200,\n"
   "    \"scroll-step\": 0.2\n"
   "  },\n"
   "  \"wireplumber#source\": {\n"
   "    \"node-type\": \"Audio/Source\",\n"
   "    \"format\": \"{volume}% <span color='#a6e3a1'></span>\",
"
   "    \"format-muted\": \"{volume}% <span color='#f38ba8'></span>\",
"
   "    \"max-volume\": 200,\n"
   "    \"scroll-step\": 0.2\n"
   "  },\n"
   "  \"network\": {\n"
   "    \"interval\": 1,\n"
   "    \"format-ethernet\": \"<span color='#89dceb'>󰈁</span> Cable\",
"
   "    \"format-wifi\": \"<span color='#06b6d4'>{icon}</span> WiFi\",
"
   "    \"format-disconnected\": \"<span color='#eba0ac'>󰈂</span> Disconnected\",
"
   "    \"format-icons\": [\"󰤟\", \"󰤢\", \"󰤥\", \"󰤨\"],
"
   "    \"tooltip\": false\n"
   "  },\n"
   "  \"custom/weather\": {\n"
   "    \"format\": \"{}°\",\n"
   "    \"tooltip\": true,\n"
   "    \"interval\": 3600,\n"
   "    \"exec\": \""
   (file-append wttrbar "/bin/wttrbar")
   "\",\n"
   "    \"return-type\": \"json\"\n"
   "  },\n"
   "  \"sway/workspaces\": {\n"
   "    \"disable-scroll\": true,\n"
   "    \"all-outputs\": true\n"
   "  }\n"
   "}]\n"))

(define %waybar-style
  (plain-file "waybar-style.css"
   "@import \"mocha.css\";

* {
    font-family: FontAwesome, 'Fira Code';
    font-size: 13px;
}

window#waybar {
    background-color: alpha(@base, 0.1);
    border-bottom: 2px solid alpha(@sky, 0.5);
    color: @rosewater;
}

#workspaces button {
    padding: 0 5px;
    background-color: alpha(@base, 0.85);
    color: @text;
    font-weight: 900;
    border-radius: 6px;
}

#workspaces button:hover {
    background: @mantle;
}

#workspaces button.focused {
    background-color: alpha(@crust, 0.85);
    box-shadow: inset 0 -2px @sky;
}

#workspaces button.urgent {
    background-color: alpha(@red, 0.85);
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#scratchpad,
#power-profiles-daemon,
#mpd,
#custom-weather {
    padding: 0 1em;
    color: @text;
    font-weight: 900;
    background-color: alpha(@base, 0.85);
    border-radius: 9999px;
}

#clock.week {
  margin-right: 0px;
  color: @peach;
  border-radius: 9999px 0px 0px 9999px;
}

#clock.year {
  margin: 0px;
  padding: 0px;
  color: @pink;
  border-radius: 0px;
}

#clock.time {
  margin-left: 0px;
  color: @sky;
  border-radius: 0px 9999px 9999px 0px;
}

#battery.charging, #battery.plugged {
    color: @green;
}

#battery.discharging {
    color: @yellow;
}

#battery.warning:not(.charging) {
    background-color: alpha(@red, 0.85);
    color: @crust;
}

/* Using steps() instead of linear as a timing function to limit cpu usage */
#battery.critical:not(.charging) {
    color: @crust;
    animation-name: blink;
    animation-duration: 1s;
    animation-timing-function: steps(12);
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

@keyframes blink {
    0%   { background-color: alpha(@mauve, 0.85); }
    25%  { background-color: alpha(@red, 0.85); }
    50%  { background-color: alpha(@maroon, 0.85); }
    75%  { background-color: alpha(@peach, 0.85); }
    100% { background-color: alpha(@mauve, 0.85); }
}
"))

;; ---------------------------------------------------------------------------
;; Desktop home environment
;;
;; Used by:
;;   systems/desktop.scm  — guix home reconfigure (real machine)
;;   systems/vm.scm       — embedded via home-service-type (VM)
;;
;; Note: emacs-ivan is used here.  emacs-emigo and emacs-ob-nix are included
;; in emacs-ivan but have placeholder sha256 hashes until built for the first
;; time.  For VM builds before those hashes are resolved, see vm.scm which
;; can override the emacs package.
;; ---------------------------------------------------------------------------

(define-public %desktop-home-environment
  (home-environment
    (packages (list
               ;; Emacs with all packages from config/packages/emacs.scm
               emacs-ivan

               ;; Terminal
               kitty

               ;; Browser (IceCat = GNU Firefox fork, the packaged variant in Guix)
               ;; To use upstream Firefox: add nonguix channel and swap to `firefox'
               icecat

               ;; Fonts
               font-dejavu
               font-liberation
               font-google-noto
               font-awesome

               ;; Screenshot / clipboard
               grim
               slurp
               wl-clipboard

               ;; Media
               mpv
               imv

               ;; TLS certs
               nss-certs

               ;; Core CLI
               curl
               git
               openssh
               brightnessctl
               playerctl

               ;; Waybar utilities
               wttrbar
               wireplumber))

    (services
     (list
      ;; User D-Bus session
      (service home-dbus-service-type)

      ;; PipeWire + WirePlumber (audio — required for wireplumber waybar module)
      (service home-pipewire-service-type)

      ;; Sway (swayfx)
      (service home-sway-service-type %sway-config)

      ;; Wallpaper daemon — rotates images from ~/Pictures/bg every 10 minutes.
      ;; Writes ~/.config/wpaperd/wallpaper.toml and registers a shepherd service.
      (service home-wpaperd-service-type
               (home-wpaperd-configuration (path "~/Pictures/bg")
                                           (duration "10m")))

      ;; Emacs init files:
      ;; ~/.emacs.d/emacs.org  — the literate config
      ;; ~/.emacs.d/init.el    — bootstrapper that loads emacs.org via org-babel
      (service home-files-service-type
               `((".emacs.d/emacs.org" ,(local-file "emacs.org"))
                 (".emacs.d/init.el" ,(plain-file "init.el"
                                       ";; init.el — generated by systems/common.scm
;; Loads the literate config from emacs.org via org-babel.
(require 'org)
(org-babel-load-file
 (expand-file-name \"emacs.org\" user-emacs-directory))
"))
                 ;; Waybar
                 (".config/waybar/config" ,%waybar-config)
                 (".config/waybar/style.css" ,%waybar-style)
                 (".config/waybar/mocha.css" ,(local-file "mocha.css"))))))))
