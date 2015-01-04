;;; laco-autocomplete.el -- auto-complete settings


(package-require 'auto-complete)

(setq
 ac-auto-start 2
 ac-override-local-map nil
 ac-use-menu-map t
 ac-candidate-limit 20)


(package-require 'company)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "C-\\") 'company-complete)

(setq company-global-modes '(not term-mode python-mode))

(setq company-minimum-prefix-length 2
      company-selection-wrap-around t
      company-show-numbers t
      company-tooltip-align-annotations t
      company-require-match nil)

;;; Javascript

(package-require 'company-tern)
(add-to-list 'company-backends 'company-tern)

;;; Haskell

(package-require 'company-ghc)
(eval-after-load "haskell-mode"
  '(progn
     (require 'company-ghc)
     (add-to-list 'company-backends 'company-ghc)))

(provide 'laco-autocomplete)
