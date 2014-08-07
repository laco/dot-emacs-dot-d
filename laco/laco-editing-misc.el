;;; laco-editing-misc.el -- Misc. editing options

;; right alt is alt, left alt is super, cmd is meta, fn is hyper
(setq mac-option-key-is-meta t)
(setq mac-command-key-is-meta nil)
(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)
(setq mac-right-option-modifier nil)
(setq mac-function-modifier 'hyper)

(setq delete-selection-mode t)
(setq use-dialog-box nil)
(setq use-file-dialog nil)
(setq visible-bell t)

;; display column number in status bar
(setq column-number-mode t)

;; cmd-alt-x, cmd-alt-c, cmd-alt-v
(global-set-key (kbd "M-s-x") 'clipboard-kill-region)
(global-set-key (kbd "M-s-c") 'clipboard-kill-ring-save)
(global-set-key (kbd "M-s-v") 'clipboard-yank)

(global-set-key (kbd "C-,") 'comment-or-uncomment-region)

;; toggle-window-split

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))

(define-key ctl-x-4-map "t" 'toggle-window-split)

;; cool buffer names
(require 'uniquify)


(provide 'laco-editing-misc)
