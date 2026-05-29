(define-module (config packages wttrbar)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses)
                #:prefix license:)
  #:use-module (gnu packages tls) ;openssl
  #:use-module (gnu packages pkg-config) ;pkg-config
  #:use-module (config packages wttrbar-crates)
  #:export (wttrbar))

(define-public wttrbar
  (let ((commit "88e8c85daf6a74b7bb176f4e5fc6afb0be07dada")
        (revision "1"))
    (package
      (name "wttrbar")
      (version (git-version "0.14.5" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/bjesus/wttrbar")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0nl7dv61i0gwjvywj5r2ism1g44bix4pqayg0i3gn33sm1va5l6f"))))
      (build-system cargo-build-system)
      (arguments
       (list
        #:install-source? #f))
      (inputs (cargo-inputs 'wttrbar
                            #:module '(config packages wttrbar-crates)))
      (native-inputs (list pkg-config))
      (propagated-inputs (list openssl))
      (home-page "https://github.com/bjesus/wttrbar")
      (synopsis "Simple but detailed weather indicator for Waybar")
      (description
       "wttrbar is a simple but detailed weather indicator for Waybar,
using wttr.in as a weather source and showing the current temperature
with a detailed tooltip.")
      (license license:expat))))
