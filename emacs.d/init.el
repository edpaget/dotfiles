;; Load up Org-babel
(require 'ob-tangle)
;; Load our main configuration file
(org-babel-load-file (expand-file-name "emacs.org" user-emacs-directory))

