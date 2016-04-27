;;; laco-snippets.el --- Yasnippets

(package-require 'popup)
(package-require 'yasnippet)
(require 'yasnippet)

(yas/global-mode 1)

(setq yas-snippet-dirs (append yas-snippet-dirs
   (list (concat dotfiles-dir "snippets") (concat dotfiles-dir "snippets-official"))))

; git clone git@github.com:AndreaCrotti/yasnippet-snippets.git ~/.emacs.d/snippets-official


;;;; Load Magnar's snippet helpers
;;(require 'snippet-helpers)
;;(require 'buster-snippet-helpers)

(provide 'laco-snippets)
