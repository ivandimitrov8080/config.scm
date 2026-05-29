(use-modules (gnu)
             (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu services)
             (gnu services base)
             (gnu services dbus)
             (gnu services desktop)
             (gnu services guix)
             (gnu services networking)
             (gnu system)
             (gnu system image)
             (gnu system keyboard)
             (gnu packages wm)
             (systems common))

(use-service-modules base networking desktop dbus pm)

(define %vm-home-environment
  (home-environment
    (inherit %desktop-home-environment)
    (services
     (cons (service home-bash-service-type
                    (home-bash-configuration
                     (bash-profile (list (plain-file "sway-autostart"
                                          "# Auto-start sway on tty1
if [ \"$(tty)\" = \"/dev/tty1\" ] && [ -z \"$WAYLAND_DISPLAY\" ]; then

fi
")))))
           (home-environment-user-services %desktop-home-environment)))))

(operating-system
  (host-name "guix-vm")
  (timezone "UTC")
  (locale "en_US.utf8")
  (keyboard-layout %my-keyboard-layout)

  (firmware '())

  (initrd-modules (append '("virtio_gpu" "virtio_pci"
                            "virtio_blk"
                            "virtio_net"
                            "virtio_console"
                            "drm"
                            "drm_kms_helper") %base-initrd-modules))

  (kernel-arguments (list "console=tty0" "console=ttyS0,115200"))

  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (targets '("/dev/vda"))
                (terminal-outputs '(console))))

  (file-systems (cons (file-system
                        (mount-point "/")
                        (device (file-system-label root-label))
                        (type "ext4")) %base-file-systems))

  (users (cons (user-account
                 (inherit %primary-user)
                 (password "")) %base-user-accounts))

  (sudoers-file (plain-file "sudoers" "root ALL=(ALL) ALL
%wheel ALL=(ALL) NOPASSWD: ALL
"))

  (pam-services (base-pam-services #:allow-empty-passwords? #t))

  (packages (append (list swayfx) %base-packages))

  (services
   (append (list (service elogind-service-type)

                 (service dbus-root-service-type)

                 (service upower-service-type)

                 (service dhcpcd-service-type)

                 (guix-home-service-for "ivand" %vm-home-environment))

           %base-services)))
