;; sublime themes install https://github.com/owainlewis/emacs-color-themes
(package-require 'sublime-themes)


(package-require 'smart-mode-line)
(require 'smart-mode-line)
(defun setup-sml () 
  (sml/setup)
  (setq sml/no-confirm-load-theme t))

(add-hook 'after-init-hook 'setup-sml)

(provide 'laco-themes)
