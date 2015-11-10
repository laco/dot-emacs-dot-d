;;; laco-python.el -- Python configuration

;; ;; Require, not autoload, to override Emacs bundled python.el
;; (package-require 'python-mode)

;; ;; Pytest bindings
;; (package-require 'pytest)
;; (require 'pytest)
;; (add-to-list 'pytest-project-names "emacs-pytest.py")
;; (setq pytest-cmd-flags "-x -v --ignore tests/system --ignore node_modules --ignore data --color yes --durations=10 -s")

;; ;; compilation mode ansi support
;; (ignore-errors
;;   (require 'ansi-color)
;;   (defun my-colorize-compilation-buffer ()
;;     (when (eq major-mode 'compilation-mode)
;;       (ansi-color-apply-on-region compilation-filter-start (point-max))))
;;   (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer))

;; (defun pytest-run ()
;;   "Run the tests interactively asking for the test flags and
;; file/dir"
;;   (interactive)
;;   (let ((tests (expand-file-name
;;         (read-file-name "Test directory or file: "
;;                         (pytest-find-project-root)))))
;;     (run-pytest tests)))


;; (add-hook
;;  'python-mode-hook
;;  (lambda ()
;;    (define-key python-mode-map (kbd "C-c t f") 'pytest-module)
;;    (define-key python-mode-map (kbd "C-c t t") 'pytest-one)
;;    (define-key python-mode-map (kbd "C-c t d") 'pytest-directory)
;;    (define-key python-mode-map (kbd "C-c t a") 'pytest-all)
;; ))

;; ;; Sphinx doc
;; (package-require 'sphinx-doc)
;; (add-hook
;;  'python-mode-hook
;;  (lambda ()
;;    (sphinx-doc-mode t)))


;; ;; Jedi settings
;; (package-require 'jedi)
;; ;; It's also required to run "pip install --user jedi" and "pip
;; ;; install --user epc" to get the Python side of the library work
;; ;; correctly.
;; ;; With the same interpreter you're using.
;; (setq jedi:server-command
;;       '("python3" "/Users/landrasi/.emacs.d/elpa/jedi-20150623.2335/jediepcserver.py"))

;; (add-hook
;; 'python-mode-hook
;; (lambda ()
;;   (jedi:setup)
;;   (jedi:ac-setup)
;;   (local-set-key "\C-cd" 'jedi:show-doc)
;;   (local-set-key (kbd "M-p") 'jedi:complete)
;;   (local-set-key (kbd "M-.") 'jedi:goto-definition)))


;; ;; Enable auto-complete, autopair and yas for python
;; (add-hook 'python-mode-hook 'autopair-mode)
;; (add-hook 'python-mode-hook 'yas-minor-mode)
;; ;; (add-hook 'python-mode-hook 'auto-complete-mode)

;; ;; switch to the interpreter after executing code
;; (setq py-shell-switch-buffers-on-execute-p t)
;; (setq py-switch-buffers-on-execute-p t)

;; ;; don't split windows
;; (setq py-split-windows-on-execute-p nil)

;; ;; try to automagically figure out indentation
;; (setq py-smart-indentation t)

;; (add-to-list 'auto-mode-alist '("\\.py$" . python-mode))


(package-require 'elpy)
(setq elpy-rpc-python-command "python3")
(elpy-enable)

(provide 'laco-python)
