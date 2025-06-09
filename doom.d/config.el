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
;;
;; Make sure we read from dir-locals

(setq enable-local-variables t)
(setq enable-local-eval t)
(setq hack-local-variables t)

(use-package! edwina
  :config
  (setq display-buffer-base-action '(display-buffer-below-selected))
  (edwina-mode 1))

(defun ed/edwina-find-file-main-push-down ()
  "Clone the active window, then find a file in the original active window.
Assumes the active window is the main edwina window.
The effect is that the new file opens in the main window,
and the previous buffer from the main window is \='pushed down\='
into the newly cloned window."
  (interactive)
  (let ((original-window (selected-window)))
    (select-window original-window)
    (edwina-clone-window)
    (call-interactively #'find-file)
    (if (eq (selected-window) (frame-first-window))
        (edwina-arrange)
      (edwina-zoom))
    (select-window (frame-first-window))))

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
               :n "m" #'edwina-zoom
               :n "i" #'edwina-inc-mfact
               :n "d" #'edwina-dec-mfact
               :n "f" #'ed/edwina-find-file-main-push-down))


(use-package! evil-cleverparens
  :hook (emacs-lisp-mode . evil-cleverparens-mode)
  :hook (clojure-mode . evil-cleverparens-mode))

(setq cider-print-fn "fipp")

(use-package! aidermacs
  :init
  ;; Must be set early to prevent ~/.config/emacs/transient from being created
  (setq transient-levels-file  (concat doom-data-dir "transient/levels")
        transient-values-file  (concat doom-data-dir "transient/values")
        transient-history-file (concat doom-data-dir "transient/history"))
  :custom
  ; See the Configuration section below
  (aidermacs-backend 'vterm)
  (aidermacs-default-model "gemini/gemini-2.5-pro-preview-05-06"))

(map! :after aidermacs
      :leader
      (:prefix ("l" . "llm")
       :desc "Start Aidermacs" :n "'" #'aidermacs-run
       (:prefix ("a" . "aidermacs")
        :desc "switch to aidermacs" :n "b" #'aidermacs-switch-to-buffer)))

(use-package! gptel
  :config
  (require 'gptel-integrations)
  (add-hook 'gptel-post-stream-hook 'gptel-auto-scroll)
  (add-hook 'gptel-post-response-functions 'gptel-end-of-response)
  (setq
   gptel-confirm-tool-calls t
   gptel-include-tool-results t
   gptel-model 'gemini-2.5-pro-preview-05-06
   gptel-backend (gptel-make-gemini "Gemini" :key (getenv "GEMINI_API_KEY") :stream t))
;;   (gptel-make-tool
;;    :name "google_search"
;;    :function (lambda (query)
;;                (let ((search-url (concat "https://www.google.com/search?q=" (url-encode-string query))))
;;                  (browse-url search-url)
;;                  (format "Opened Google search for '%s' in your default browser." query)))
;;    :description "Performs a web search using Google and opens the results in the default web browser. This tool does not return the search results directly."
;;    :args (list '(:name "query"
;;                  :type string
;;                  :description "The search query string."))
;;    :category "web")
;; (gptel-make-tool
;;  :name "google_search_and_fetch_results"
;;  :function (lambda (query)
;;              (if (fboundp 'my-custom-get-google-search-results-as-string)
;;                  (condition-case e
;;                      (let ((results (my-custom-get-google-search-results-as-string query)))
;;                        (if (stringp results)
;;                            (if (string-empty-p results) ; Check if results string is empty
;;                                (format "No search results found or returned by the custom fetch function for query: '%s'." query)
;;                              results) ; Return the results if they are a non-empty string
;;                          (format "Error: The custom search function 'my-custom-get-google-search-results-as-string' did not return a string for query '%s'. It returned: %S" query results)))
;;                    (error (format "Error executing 'my-custom-get-google-search-results-as-string' for query '%s': %s" query (error-message-string e))))
;;                (error "The required Emacs Lisp function 'my-custom-get-google-search-results-as-string' is not defined. This tool cannot fetch results without it.")))
;;  :description "Performs a Google search using a custom Emacs Lisp function ('my-custom-get-google-search-results-as-string') and returns the search results as a string to the LLM. The custom function must be implemented by the user."
;;  :args (list '(:name "query"
;;                :type string
;;                :description "The search query string."))
;;  :category "web-fetch")
  (gptel-make-tool
   :name "emacs_eval"
   :function (lambda (code-to-eval)
               (prin1-to-string (eval (read-from-string code-to-eval))))
   :description "Evaluate Emacs Lisp code and return the result as a string."
   :args (list '(:name "code_to_eval"
                 :type string
                 :description "A string containing the Emacs Lisp code to evaluate."))
   :category "emacs")
(gptel-make-preset 'clojure
  :description "Preset for Clojure/ClojureScript development using Gemini Pro. Optimized for tasks managed by clojure-mcp or similar integrations."
  gptel-backend (gptel-make-gemini "Gemini" :key (getenv "GEMINI_API_KEY") :stream t)
  :model 'gemini-2.5-pro-preview-05-06
  :system "You are an expert Clojure and ClojureScript programming assistant. Your primary role is to help the user write, understand, debug, and refactor Clojure/ClojureScript code.
Provide idiomatic solutions, adhere to best practices, and offer clear explanations.
When asked to write or modify code, provide only the code block unless explanation is explicitly requested.
Assume you are assisting a developer working in an advanced Emacs environment, possibly using tools like clojure-mcp which integrate LLM capabilities directly into their workflow."
  :tools '("read_buffer"))
  )

(use-package! mcp
  :after gptel
  :custom (mcp-hub-servers
           `(("clj-prj" . (:command "/bin/bash"
                           :args ("-c" (concat "PATH=/opt/homebrew/bin:$PATH && "
                                               "clojure -X:mcp :port 7888"))))))
  :config (require 'mcp-hub))

(map! :after gptel
      :leader
      (:prefix ("l" . "llm")
       :desc "Start gptel" :n "\"" #'gptel
       :desc "gtpel menu" :n "m" #'gptel-menu
       :desc "gtpel menu" :n "c" #'gptel-mcp-connect
       :desc "gtpel menu" :n "q" #'gptel-mcp-disconnect
       :desc "gtpel menu" :n "s" #'gptel-send)
      )

(map! :after lsp-mode
      :map lsp-mode-map
      :leader (:prefix ("j" . "lsp")
                       (:prefix ("f" . "lsp find")
                        :n "d" #'lsp-find-definition
                        :n "r" #'lsp-find-references)))

(map! :after aidermacs
      :leader (:prefix ( "l" . "llm")
                       (:prefix ("a" . "aidermacs")
                        :n "a" #'aidermacs-architect-this-code
                        :n "c" #'aidermacs-direct-change
                        :n "i" #'aidermacs-implement-todo
                        :n "q" #'aidermacs-exit
                        :n "t" #'aidermacs-write-unit-test
                        :n "s a" #'aidermacs-switch-to-architect-mode
                        :n "s A" #'aidermacs-switch-to-ask-mode
                        :n "s c" #'aidermacs-switch-to-code-mode
                        :n "s C" #'aidermacs-clear-chat-history
                        :n "f A" #'aidermacs-add-current-file
                        :n "f a" #'aidermacs-add-file
                        :n "f d" #'aidermacs-drop-file
                        :n "f D" #'aidermacs-drop-current-file
                        :n "e r" #'aidermacs-send-line-or-region
                        )))
