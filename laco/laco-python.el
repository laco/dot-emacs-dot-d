;;; laco-python.el -- Python configuration

;; Require, not autoload, to override Emacs bundled python.el
(package-require 'python-mode)

;; Pytest bindings
(package-require 'pytest)
(add-hook
 'python-mode-hook
 (lambda ()
   (define-key python-mode-map (kbd "C-c C-,") 'pytest-run-file)))

;; Sphinx doc
(package-require 'sphinx-doc)
(add-hook 
 'python-mode-hook
 (lambda ()
   (sphinx-doc-mode t)))


;; Jedi settings
(package-require 'jedi)
;; It's also required to run "pip install --user jedi" and "pip
;; install --user epc" to get the Python side of the library work
;; correctly.
;; With the same interpreter you're using.
(setq jedi:server-command
      '("python3" "/Users/landrasi/.emacs.d/elpa/jedi-20140321.1323/jediepcserver.py"))

(add-hook 
'python-mode-hook
(lambda ()
  (jedi:setup)
  (jedi:ac-setup)
  (local-set-key "\C-cd" 'jedi:show-doc)
  (local-set-key (kbd "M-p") 'jedi:complete)
  (local-set-key (kbd "M-.") 'jedi:goto-definition)))


;; Enable auto-complete, autopair and yas for python
(add-hook 'python-mode-hook 'autopair-mode)
(add-hook 'python-mode-hook 'yas-minor-mode)
;; (add-hook 'python-mode-hook 'auto-complete-mode)

;; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)

;; don't split windows
(setq py-split-windows-on-execute-p nil)

;; try to automagically figure out indentation
(setq py-smart-indentation t)

(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))

(provide 'laco-python)
