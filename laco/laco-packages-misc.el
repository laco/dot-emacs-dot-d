;;; laco-packages-misc.el

(package-require 'autopair)

(package-require 'popwin)
(setq popwin-mode 1)

(package-require 'smart-mode-line)
(sml/setup)

(package-require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x" "C-x 4" "C-c" "C-x n" "C-x p"))
(setq guide-key/recursive-key-sequence-flag t)
(guide-key-mode 1)

(global-linum-mode)

;; Show parenthesis mode
(show-paren-mode 1)

(provide 'laco-packages-misc)
