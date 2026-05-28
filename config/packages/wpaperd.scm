;; config/packages/wpaperd.scm — wpaperd wallpaper daemon for Wayland
;;
;; wpaperd is not currently in upstream Guix, so we package it here as a
;; custom channel package.  It is a Cargo workspace with two binaries:
;;   wpaperd   — the background daemon (reads wallpaper.toml, sets wlr backgrounds)
;;   wpaperctl — the CLI control tool  (next/previous/get-wallpaper/…)
;;
;; Cargo deps are vendored via the companion wpaperd-crates.scm file.

(define-module (config packages wpaperd)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system cargo)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages freedesktop)   ; wayland
  #:use-module (gnu packages gl)            ; mesa
  #:use-module (gnu packages pkg-config)    ; pkg-config
  #:use-module (config packages wpaperd-crates)
  #:export (wpaperd))

(define-public wpaperd
  (package
    (name "wpaperd")
    (version "1.3.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/danyspin97/wpaperd/archive/refs/tags/"
             version ".tar.gz"))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1ia8z7v5sw3qp4xp382fgwzpyxsf24bddad9mll5fazcpq2ycbqw"))))

    (build-system cargo-build-system)

    (arguments
     (list
      ;; Do not install the Rust source tree into the output.
      #:install-source? #f
      ;; Build all workspace members (daemon + CLI).
      ;; Disable the default jemalloc feature: tikv-jemalloc-sys requires
      ;; autoconf/config.sub which are not available in the Guix sandbox.
      ;; The daemon falls back to the system allocator transparently.
       #:cargo-build-flags ''("--workspace" "--no-default-features" "--release")
       ;; Pass the same flags to cargo test.
       #:cargo-test-flags ''("--workspace" "--no-default-features")
      ;; The root Cargo.toml is a virtual workspace manifest — cargo install
      ;; --path . would fail.  Replace the install phase with a simple binary
      ;; copy from the target directory built above.
      #:phases
      #~(modify-phases %standard-phases
          (replace 'install
            (lambda* (#:key outputs #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (bin (string-append out "/bin")))
                (mkdir-p bin)
                (for-each (lambda (b)
                            (install-file b bin))
                          (list "target/release/wpaperd"
                                "target/release/wpaperctl"))))))))

    (inputs
     (cargo-inputs 'wpaperd
                   #:module '(config packages wpaperd-crates)))

    (native-inputs
     (list pkg-config))

    ;; wayland-egl and khronos-egl (OpenGL/EGL) are linked at runtime.
    (propagated-inputs
     (list wayland mesa))

    (home-page "https://github.com/danyspin97/wpaperd")
    (synopsis "Wallpaper daemon for Wayland")
    (description
     "wpaperd is a wallpaper daemon for Wayland compositors that implement the
wlr-layer-shell protocol (Sway, Hyprland, river, …).  It reads a TOML
configuration file listing per-monitor wallpaper directories and rotation
durations, and displays wallpapers directly via EGL/OpenGL without any
external image viewer.  A companion CLI tool @command{wpaperctl} allows
runtime control (next/previous wallpaper, pause, get current path, etc.).")
    (license license:gpl3+)))
