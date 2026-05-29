(define-module (systems common)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix records)

  #:use-module (gnu)
  #:use-module (gnu system)
  #:use-module (gnu system keyboard)

  #:use-module (gnu services)
  #:use-module (gnu services networking)
  #:use-module (gnu services ssh)
  #:use-module (gnu services desktop)
  #:use-module (gnu services guix)

  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services desktop)
  #:use-module (gnu home services fontutils)
  #:use-module (gnu home services sway)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home services sound)
  #:use-module (gnu home services xdg)

  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages nss)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages file)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gnuzilla)
  #:use-module (gnu packages image-viewers)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages lsof)
  #:use-module (gnu packages man)
  #:use-module (gnu packages music)
  #:use-module (gnu packages ncdu)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages rsync)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages busybox)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages tmux)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages video)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages web)
  #:use-module (gnu packages wget)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages image)
  #:use-module (gnu packages xdisorg)

  #:use-module (config packages emacs)
  #:use-module (config packages wttrbar)
  #:use-module (config packages wpaperd)

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

(define-public %my-keyboard-layout
  (keyboard-layout "us,bg" ",phonetic"
                   #:options '("grp:win_space_toggle")))

(define-public %primary-user
  (user-account
    (name "ivand")
    (comment "Ivan")
    (group "users")
    (supplementary-groups '("wheel" "audio" "video" "input" "netdev"))
    (home-directory "/home/ivand")))

(define %upstream-base-packages
  (@ (gnu system) %base-packages))

(define-public %base-packages
  (append (list busybox
                curl
                wget
                git
                openssh
                bash
                bash-completion
                vim
                file
                tree
                which
                diffutils
                zip
                unzip
                htop
                lsof
                strace
                nmap
                netcat
                ripgrep
                jq
                rsync
                ncdu
                tmux
                font-dejavu
                font-liberation
                man-pages
                password-store
                brightnessctl) %upstream-base-packages))

(define-public %my-base-services
  (list (service network-manager-service-type)
        (service wpa-supplicant-service-type)))

(define-public %guix-service
  (service guix-service-type))

(define-public (guix-home-service-for user home-env)
  (service guix-home-service-type
           (list (list user home-env))))

(define-record-type* <home-wpaperd-configuration> home-wpaperd-configuration
                     make-home-wpaperd-configuration
  home-wpaperd-configuration?
  (wpaperd home-wpaperd-configuration-wpaperd
           (default wpaperd))
  (path home-wpaperd-configuration-path
        (default "~/Pictures/bg"))
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
                (extensions (list (service-extension
                                   home-shepherd-service-type
                                   home-wpaperd-shepherd-service)
                                  (service-extension
                                   home-xdg-configuration-files-service-type
                                   home-wpaperd-xdg-config-files)
                                  (service-extension home-profile-service-type
                                   home-wpaperd-profile-service)))
                (default-value (home-wpaperd-configuration))
                (description
                 "Run @command{wpaperd}, a wallpaper daemon for Wayland compositors
implementing the wlr-layer-shell protocol.  Writes
@file{~/.config/wpaperd/wallpaper.toml} and registers a Shepherd service
so the daemon starts automatically with the user session.")))

(define-public %sway-keybindings
  `(($mod+p . "exec rofi -show drun") ($mod+Return . "exec kitty")
    (end . "exec rofi -show calc")
    ($mod+Shift+q . "kill")
    ($mod+Shift+c . "reload")
    ($mod+f . "fullscreen toggle")
    ($mod+Shift+space . "floating toggle")
    ($mod+space . "focus mode_toggle")
    ($mod+h . "focus left")
    ($mod+j . "focus down")
    ($mod+k . "focus up")
    ($mod+l . "focus right")
    ($mod+Left . "focus left")
    ($mod+Down . "focus down")
    ($mod+Up . "focus up")
    ($mod+Right . "focus right")
    ($mod+Shift+h . "move left")
    ($mod+Shift+j . "move down")
    ($mod+Shift+k . "move up")
    ($mod+Shift+l . "move right")
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
    ($mod+b . "splith")
    ($mod+v . "splitv")
    ($mod+s . "layout stacking")
    ($mod+w . "layout tabbed")
    ($mod+e . "layout toggle split")
    ($mod+Shift+minus . "move scratchpad")
    ($mod+minus . "scratchpad show")
    (XF86AudioMute . "exec pactl set-sink-mute @DEFAULT_SINK@ toggle")
    (Shift+XF86AudioMute . "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    (XF86AudioLowerVolume . "exec pactl set-sink-volume @DEFAULT_SINK@ -5%")
    (Shift+XF86AudioLowerVolume . "exec pactl set-source-volume @DEFAULT_SOURCE@ -5%")
    (XF86AudioRaiseVolume . "exec pactl set-sink-volume @DEFAULT_SINK@ +5%")
    (Shift+XF86AudioRaiseVolume . "exec pactl set-source-volume @DEFAULT_SOURCE@ +5%")
    (XF86MonBrightnessUp . "exec brightnessctl set 10%+")
    (XF86MonBrightnessDown . "exec brightnessctl set 10%-")
    (alt+shift+l . "exec swaylock")
    ($mod+Shift+s . "exec grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png")
    ($mod+Shift+a . "exec grim -g \"$(slurp)\" - | wl-copy")
    ($mod+Shift+w . "exec grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png")
    ($mod+r . "mode \"resize\"")))

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

                      (startup-programs (list "exec kitty"))

                      (startup+reload-programs (list "kanshi"))

                      (extra-content '("assign [app_id=\"^icecat$\"] workspace 2"
                                       "gaps horizontal 2"
                                       "gaps vertical 2"
                                       "default_border none"
                                       "default_floating_border none"
                                       "titlebar_border_thickness 0"
                                       "blur enable"
                                       "shadows enable"
                                       "corner_radius 15"
                                       "default_dim_inactive 0.2"
                                       "focus_follows_mouse no"
                                       "mouse_warping none"))))

(define %waybar-config
  (local-file "waybar-config"))

(define %waybar-style
  (local-file "waybar-style.css"))
(define-public %desktop-home-environment
  (home-environment
    (packages (list emacs-ivan
                    kitty
                    icecat
                    font-dejavu
                    font-liberation
                    font-google-noto
                    font-awesome
                    grim
                    slurp
                    wl-clipboard
                    mpv
                    imv
                    nss-certs
                    curl
                    git
                    openssh
                    brightnessctl
                    playerctl
                    wttrbar
                    wireplumber))

    (services
     (list (service home-dbus-service-type)

           (service home-pipewire-service-type)

           (service home-sway-service-type %sway-config)

           (service home-wpaperd-service-type
                    (home-wpaperd-configuration (path "~/Pictures/bg")
                                                (duration "10m")))

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
                      (".config/waybar/mocha.css" ,(local-file "mocha.css"))
                      ("Pictures/bg/wallpaper.jpeg" ,(local-file
                                                      "../wallpaper.jpeg"))))))))

