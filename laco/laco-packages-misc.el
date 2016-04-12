;;; laco-packages-misc.el

(package-require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


(package-require 'autopair)

(package-require 'popwin)
(setq popwin-mode 1)
(require 'popwin)
(push '(" *undo-tree*" :width 0.2 :position right) popwin:special-display-config)
(push '("*Occur*" :width 0.4 :position right :stick t) popwin:special-display-config)
(push '("*pytest*" :width 0.4 :position right :stick t) popwin:special-display-config)



(package-require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x" "C-x 4" "C-c" "C-x n" "C-x p"))
(setq guide-key/recursive-key-sequence-flag t)
(guide-key-mode 1)

(global-linum-mode)
(defcustom linum-disabled-modes-list '(eshell-mode wl-summary-mode compilation-mode org-mode text-mode dired-mode doc-view-mode image-mode)
  "* List of modes disabled when global linum mode is on"
  :type '(repeat (sexp :tag "Major mode"))
  :tag " Major modes where linum is disabled: "
  :group 'linum
  )
(defcustom linum-disable-starred-buffers 't
  "* Disable buffers that have stars in them like *Gnu Emacs*"
  :type 'boolean
  :group 'linum)

(defun linum-on ()
  "* When linum is running globally, disable line number in modes defined in `linum-disabled-modes-list'. Changed by linum-off. Also turns off numbering in starred modes like *scratch*"

  (unless (or (minibufferp)
              (member major-mode linum-disabled-modes-list)
              (string-match "*" (buffer-name))
              (> (buffer-size) 3000000)) ;; disable linum on buffer greater than 3MB, otherwise it's unbearably slow
    (linum-mode 1)))


;; Show parenthesis mode
(show-paren-mode 1)

(package-require 'undo-tree)
(global-undo-tree-mode)


;; acejump mode for quick navigation
(package-require 'ace-jump-mode)
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode)


(package-require 'helm)
(package-require 'helm-projectile)
(require 'helm-config)

(package-require 'helm-ag)
(package-require 'ag)
(global-set-key (kbd "C-c /") 'helm-ag-project-root)

(defun setup-helm-keybindings ()
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))
  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "M-x") 'helm-M-x))

(add-hook 'after-init-hook 'setup-helm-keybindings)

(package-require 'ace-window)
(global-set-key (kbd "C-x o") 'ace-window)

(provide 'laco-packages-misc)
