;;; laco-autocomplete.el -- auto-complete settings


(package-require 'auto-complete)

(setq
 ac-auto-start 2
 ac-override-local-map nil
 ac-use-menu-map t
 ac-candidate-limit 20)

(provide 'laco-autocomplete)
