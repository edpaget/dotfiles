;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Edward Paget"
      user-mail-address "ed.paget@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-dark)

(setq doom-font (font-spec :family "Iosevka" :size 15))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(setq-default typescript-indent-level 2)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! edwina
  :config
  (setq display-buffer-base-action '(display-buffer-below-selected))
  (edwina-mode 1))

(map! :after edwina
      :map edwina-mode-map
      :leader (:prefix ("e" . "edwina")
               :n "z" #'edwina-zoom
               :n "c" #'edwina-clone-window
               :n "k" #'edwina-delete-window
               :n "r" #'edwina-arrange
               :n "n" #'edwina-swap-next-window
               :n "p" #'edwina-swap-previous-window
               :n "N" #'edwina-select-next-window
               :n "P" #'edwina-select-previous-window
               :n "i" #'edwina-inc-mfact
               :n "d" #'edwina-dec-mfact))


(use-package! evil-cleverparens
  :hook (emacs-lisp-mode . evil-cleverparens-mode)
  :hook (clojure-mode . evil-cleverparens-mode))

(setq cider-print-fn "fipp")

(use-package aidermacs
  :init
  ;; Must be set early to prevent ~/.config/emacs/transient from being created
  (setq transient-levels-file  (concat doom-data-dir "transient/levels")
        transient-values-file  (concat doom-data-dir "transient/values")
        transient-history-file (concat doom-data-dir "transient/history"))
  :custom
  ; See the Configuration section below
  (aidermacs-use-architect-mode t)
  (aidermacs-default-model "sonnet"))

(map! :leader
      (:prefix ("c" . "code")
        :desc "Start Aidermacs" "A" #'aidermacs-transient-menu))
