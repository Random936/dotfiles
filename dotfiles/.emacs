; Enable following symlinks
(setq vc-follow-symlinks t)

; Load the main config file for emacs
(require 'org)
(org-babel-load-file
 (expand-file-name "config.org"
                   user-emacs-directory))
