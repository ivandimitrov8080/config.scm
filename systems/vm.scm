;; systems/vm.scm — Guix operating-system for VM-based testing
;;
;; This file declares a full operating-system that embeds the desktop
;; home-environment so both the OS and the user environment are built and
;; tested in a single `guix system' invocation.
;;
;; ============================================================================
;; Quick-start
;; ============================================================================
;;
;; All commands are run from the repo root.
;;
;; IMPORTANT: `guix system' does not read channels.scm automatically — it
;; always uses the Guix currently on PATH.  Use `guix time-machine' to ensure
;; the build runs at the pinned commit in channels.scm.
;;
;; --- Ephemeral VM (fast iteration, no persistent disk) ---
;;
;;   vm=$(guix time-machine --channels=channels.scm -- system vm -L . systems/vm.scm)
;;   $vm -- \
;;     -m 2048 -smp 2 \
;;     -device virtio-gpu \
;;     -display gtk,gl=off \
;;     -nic user,model=virtio-net-pci
;;
;;   With KVM acceleration (much faster if your host supports it):
;;   $vm -- -enable-kvm -m 2048 -smp 2 -device virtio-gpu -display gtk,gl=off
;;
;;   Share the repo into the VM (useful for live editing):
;;   $vm --share=$PWD=/home/ivand/config \
;;       -- -enable-kvm -m 2048 -device virtio-gpu -display gtk,gl=off
;;
;; --- Persistent qcow2 image ---
;;
;;   guix time-machine --channels=channels.scm -- \
;;     system image -L . --image-type=qcow2 --image-size=40GiB systems/vm.scm
;;
;;   # Copy out of store (store paths are read-only):
;;   img=$(guix time-machine --channels=channels.scm -- \
;;           system image -L . --image-type=qcow2 --image-size=40GiB systems/vm.scm)
;;   cp -L "$img" /tmp/guix-desktop.qcow2
;;   chmod +w /tmp/guix-desktop.qcow2
;;
;;   qemu-system-x86_64 \
;;     -enable-kvm -m 4096 -smp 4 \
;;     -drive file=/tmp/guix-desktop.qcow2,if=virtio \
;;     -device virtio-gpu \
;;     -display gtk \
;;     -nic user,model=virtio-net-pci
;;
;;   With KVM acceleration (much faster if your host supports it):
;;   $vm -- -enable-kvm -m 2048 -smp 2 -device virtio-gpu -display gtk,gl=off
;;
;;   Share the repo into the VM (useful for live editing):
;;   $vm --share=$PWD=/home/ivand/config \
;;       -- -enable-kvm -m 2048 -device virtio-gpu -display gtk,gl=off
;;
;; --- Persistent qcow2 image ---
;;
;;   guix system image -L . --image-type=qcow2 --image-size=40GiB systems/vm.scm
;;
;;   # Copy out of store (store paths are read-only):
;;   cp -L $(guix system image -L . --image-type=qcow2 --image-size=40GiB systems/vm.scm) \
;;          /tmp/guix-desktop.qcow2
;;   chmod +w /tmp/guix-desktop.qcow2
;;
;;   qemu-system-x86_64 \
;;     -enable-kvm -m 4096 -smp 4 \
;;     -drive file=/tmp/guix-desktop.qcow2,if=virtio \
;;     -device virtio-gpu \
;;     -display gtk \
;;     -nic user,model=virtio-net-pci
;;
;; ============================================================================
;; Login
;; ============================================================================
;;
;; User:     ivand
;; Password: (empty — press Enter)
;;
;; Sway launches automatically when you log in on tty1 because .bash_profile
;; contains an autostart stanza (added via home-bash-service-type below).
;; Alternatively: log in, then run `sway'.
;;
;; ============================================================================

(use-modules
 (gnu)
 (gnu home)
 (gnu home services)
 (gnu home services shells)       ; home-bash-service-type
 (gnu services)
 (gnu services base)
 (gnu services dbus)              ; dbus-root-service-type
 (gnu services desktop)           ; seatd-service-type
 (gnu services guix)              ; guix-home-service-type
 (gnu services networking)        ; dhcpcd-service-type
 (gnu system)
 (gnu system image)               ; root-label
 (gnu system keyboard)
 (gnu packages wm)               ; swayfx
 (systems common))               ; %my-keyboard-layout, %primary-user,
                                  ; %sway-config, %desktop-home-environment

(use-service-modules base networking desktop dbus)

;; ============================================================================
;; VM-specific home environment
;;
;; Inherits everything from %desktop-home-environment but adds a bash
;; autostart stanza so sway launches on tty1 without a display manager.
;; ============================================================================

(define %vm-home-environment
  (home-environment
   (inherit %desktop-home-environment)
   (services
    (cons
     ;; Auto-launch sway on tty1 after login.
     ;; The guard prevents re-launching inside an existing Wayland session.
     (service home-bash-service-type
              (home-bash-configuration
               (bash-profile
                (list (plain-file "sway-autostart"
                        "# Auto-start sway on tty1
if [ \"$(tty)\" = \"/dev/tty1\" ] && [ -z \"$WAYLAND_DISPLAY\" ]; then
  exec sway
fi
")))))
     (home-environment-user-services %desktop-home-environment)))))

;; ============================================================================
;; Operating system
;; ============================================================================

(operating-system
  (host-name "guix-vm")
  (timezone "UTC")
  (locale "en_US.utf8")
  (keyboard-layout %my-keyboard-layout)

  ;; No non-free firmware in a VM.
  (firmware '())

  ;; Pull in virtio kernel modules so QEMU virtio devices are detected.
  (initrd-modules
   (append '("virtio_gpu"
             "virtio_pci"
             "virtio_blk"
             "virtio_net"
             "virtio_console"
             "drm"
             "drm_kms_helper")
           %base-initrd-modules))

  ;; Enable both VGA console and serial console.
  ;; Serial lets you interact even without a GUI display.
  (kernel-arguments
   (list "console=tty0"
         "console=ttyS0,115200"))

  ;; Bootloader: grub targeting the first virtio disk.
  ;; For `guix system vm' (script mode) GRUB is not actually invoked —
  ;; QEMU boots the kernel directly — but the field is still required.
  (bootloader
   (bootloader-configuration
    (bootloader grub-bootloader)
    (targets '("/dev/vda"))
    (terminal-outputs '(console))))

  ;; Root filesystem.
  ;; `root-label' expands to "Guix_image", the label used by guix system image.
  (file-systems
   (cons (file-system
           (mount-point "/")
           (device (file-system-label root-label))
           (type "ext4"))
         %base-file-systems))

  ;; Users.
  ;; Empty password for frictionless VM login.
  ;; `seat' group grants access to DRM/input devices — required by sway.
  (users
   (cons (user-account
           (inherit %primary-user)
           ;; Override the password field for the VM.
           (password ""))
         %base-user-accounts))

  ;; Allow wheel group to sudo without a password (dev convenience).
  (sudoers-file
   (plain-file "sudoers"
     "root ALL=(ALL) ALL\n%wheel ALL=(ALL) NOPASSWD: ALL\n"))

  ;; Allow PAM to accept empty passwords (matches the empty password above).
  (pam-services
   (base-pam-services #:allow-empty-passwords? #t))

  ;; System-wide packages.
  ;; swayfx is also in the home-environment but having it system-wide means
  ;; it can be launched directly from a TTY login before home activation.
  (packages
   (append (list swayfx)
           %base-packages))

  ;; Services.
  (services
   (append
    (list
     ;; --- Seat management + session tracking ---
     ;; elogind creates /run/user/<uid> (XDG_RUNTIME_DIR) on login,
     ;; manages seats, and is the standard Guix approach for Wayland
     ;; compositors on non-systemd systems.
     (service elogind-service-type)

     ;; --- D-Bus system bus ---
     ;; Many Wayland components (mako, portals, etc.) need this.
     (service dbus-root-service-type)

     ;; --- Networking ---
     (service dhcpcd-service-type)

     ;; --- Desktop home environment for ivand ---
     ;; guix-home-service-type activates the home-environment at boot via a
     ;; one-shot shepherd service.  The value is a list of (user he) pairs.
     (service guix-home-service-type
              (list (list "ivand" %vm-home-environment))))

    ;; Upstream base services: udev, logging, mingetty on ttys, etc.
    ;; This is (gnu)'s %base-services, NOT the one from (systems common).
    %base-services)))
