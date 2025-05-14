;;; ../Projects/dotfiles/doom.d/custom.el -*- lexical-binding: t; -*-


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((js2-mode-show-strict-warnings) (js2-mode-show-parse-errors)
     (eval define-clojure-indent (l/matcha '(1 (:defn))) (l/matche '(1 (:defn)))
      (p.types/def-abstract-type '(1 (:defn)))
      (p.types/defprotocol+ '(1 (:defn)))
      (p.types/defrecord+ '(2 nil nil (:defn)))
      (p.types/deftype+ '(2 nil nil (:defn)))
      (p/def-map-type '(2 nil nil (:defn))) (p/defprotocol+ '(1 (:defn)))
      (p/defrecord+ '(2 nil nil (:defn))) (p/deftype+ '(2 nil nil (:defn)))
      (tools.macro/macrolet '(1 ((:defn)) :form)))
     (eval put 'mu/defn 'clojure-doc-string-elt 2)
     (eval put 'mr/def 'clojure-doc-string-elt 2)
     (eval put 'mi/define-batched-hydration-method 'clojure-doc-string-elt 3)
     (eval put 'mi/define-simple-hydration-method 'clojure-doc-string-elt 3)
     (eval put 'methodical/defmulti 'clojure-doc-string-elt 2)
     (eval put 'methodical/defmethod 'clojure-doc-string-elt 3)
     (eval put 'p.types/defprotocol+ 'clojure-doc-string-elt 2)
     (eval put 's/defn 'clojure-doc-string-elt 2)
     (eval put 'setting/defsetting 'clojure-doc-string-elt 2)
     (eval put 'defsetting 'clojure-doc-string-elt 2)
     (eval put 'api.macros/defendpoint 'clojure-doc-string-elt 3)
     (eval put 'define-premium-feature 'clojure-doc-string-elt 2)
     (ftf-project-finders ftf-get-top-git-dir) (whitespace-line-column . 118)
     (cider-clojure-cli-parameters . "-A:dev")
     (cider-clojure-cli-parameters . "-A:dev")
     (cider-clojure-cli-aliases . ":dev:test"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
