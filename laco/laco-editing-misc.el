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
(setq visible-bell nil)

(setq-default indent-tabs-mode nil) ;; never use tabs!!!


;; display column number in status bar
(setq column-number-mode t)

;; cmd-alt-x, cmd-alt-c, cmd-alt-v
;; nem igazan hasznaltam...
;; (global-set-key (kbd "M-s-x") 'clipboard-kill-region)
;; (global-set-key (kbd "M-s-c") 'clipboard-kill-ring-save)
;; (global-set-key (kbd "M-s-v") 'clipboard-yank)

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

;; expand-region <3 @magnars
(package-require 'expand-region)
(global-set-key (kbd "C-+") 'er/expand-region)


;; Multiple cursors!
(package-require 'multiple-cursors)
(global-set-key (kbd "C-H-c C-H-c") 'mc/edit-lines)
(global-set-key (kbd "C-H-p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-H-n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-H-m") 'mc/mark-more-like-this-extended)
(global-set-key (kbd "C-H-a") 'mc/mark-all-like-this-dwim)


;; Entering annoying-arrows-mode makes emacs ring the bell in your face if you move long distances in the buffer one char at a time.
;;(package-require 'annoying-arrows-mode)
;;(global-annoying-arrows-mode)

;; Joining lines
;; https://github.com/rejeep/emacs/blob/master/rejeep-defuns.el#L150-L158
(defun l/join-line-or-lines-in-region ()
  "Join this line or the lines in the selected region."
  (interactive)
  (cond ((region-active-p)
         (let ((min (line-number-at-pos (region-beginning))))
           (goto-char (region-end))
           (while (> (line-number-at-pos) min)
             (join-line))))
        (t (call-interactively 'join-line))))
(global-set-key (kbd "M-j") 'l/join-line-or-lines-in-region)


;; Some bindings for special characters
(global-set-key (kbd "H-l") (lambda () (interactive) (insert "\u03bb"))) ;lambda
(global-set-key (kbd "H-f") (lambda () (interactive) (insert "\u0192"))) ;function
(global-set-key (kbd "H--") (lambda () (interactive) (insert "\u2192"))) ;arrow

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'laco-editing-misc)
