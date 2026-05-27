;; channels.scm — copy to ~/.config/guix/channels.scm
;;
;; Usage:
;;   cp channels.scm ~/.config/guix/channels.scm
;;   guix pull
;;
;; After pulling, (config packages emacs) and other modules are available.

(cons* (channel
         (name 'config)
         (url "https://github.com/ivand/config.scm")  ; update with your actual URL
         (branch "main"))
       %default-channels)
