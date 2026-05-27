;; channels.scm — copy to ~/.config/guix/channels.scm, OR use directly with:
;;   guix time-machine --channels=channels.scm -- system vm -L . systems/vm.scm
;;
;; NOTE: `guix system' does NOT read this file automatically.  Always use
;; `guix time-machine --channels=channels.scm' to get a reproducible build.
;;
;; After pushing the repo for the first time, pin the config channel by
;; adding: (commit "FIRST-COMMIT-HASH") and removing (branch "master").

(list (channel
        (name 'config)
        (url "https://github.com/ivandimitrov8080/config.scm")
        (branch "master"))  ; TODO: replace with (commit "...") after first push
      (channel
        (name 'guix)
        (url "https://codeberg.org/guix/guix.git")
        (commit "f519ddf7330f6dd05c880f0135336a8e9d9ca026")))
