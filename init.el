;;; init.el --- And Now for Something Completely Different
(require 'cl)


;; When I was a child, I spake as a child,
;; I understood as a child, I thought as a child:
;; but when I became a man, I put away childish things.
;;   -- 1 Corinthians, 13:11
(dolist (mode '(tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))


;; fix PATH environment variable
(setenv "PATH"
  (concat
    "/usr/local/sbin" ":"
    "/usr/local/bin" ":"
    (getenv "PATH")
  )
)

(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LC_CTYPE" "en_US.UTF-8")

;; Always ALWAYS use UTF-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(load-library "iso-transl")

;; Automatically save buffers before compiling
(setq compilation-ask-about-save nil)

;; Always ask for y/n keypress instead of typing out 'yes' or 'no'
(defalias 'yes-or-no-p 'y-or-n-p)

;; Get hostname
(setq hostname (replace-regexp-in-string "\\(^[[:space:]\n]*\\|[[:space:]\n]*$\\)" "" (with-output-to-string (call-process "hostname" nil standard-output))))

;; Add .emacs.d/laco to load-path
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path (concat dotfiles-dir "laco"))
(add-to-list 'load-path (concat dotfiles-dir "lisp"))

;; Set paths to custom.el and loaddefs.el
(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq custom-file (concat dotfiles-dir "custom.el"))


;; Detect online status, from ESK
(defun esk-online? ()
  (if (and (functionp 'network-interface-list)
           (network-interface-list))
      (some (lambda (iface) (unless (equal "lo" (car iface))
                         (member 'up (first (last (network-interface-info
                                                   (car iface)))))))
            (network-interface-list))
    t))

;; ELPA
(setq package-user-dir (concat dotfiles-dir "elpa"))
(require 'package)
(dolist (source
         '(
           ("elpy" . "http://jorgenschaefer.github.io/packages/")
           ("melpa" . "http://melpa.milkbox.net/packages/")
           ("marmalade" . "http://marmalade-repo.org/packages/")
           ("elpa" . "http://tromey.com/elpa/")))
  (add-to-list 'package-archives source t))
(package-initialize)
(when (esk-online?)
  (unless package-archive-contents (package-refresh-contents)))

(defun package-require (pkg)
  "Install a package only if it's not already installed."
  (when (not (package-installed-p pkg))
    (package-install pkg)))

;; Write backup files to .saves directory
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Define subpackages by platform
(setq laco-pkg-full
      '(laco-defuns
        laco-themes  ; smart mode line + themes
        laco-editing-misc
	laco-packages-misc
	laco-snippets
	laco-autocomplete
	laco-ido
	laco-flycheck
	laco-magit
	laco-projectile
	laco-python
        laco-javascript
        laco-typescript
        ;; laco-haskell
        ;;laco-clojure ; bugos
))

;; Now load other things
(dolist (file laco-pkg-full)
  (require file))

;; set transparency for the window
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))
(transparency 93)

;; Load custom settings
(load custom-file 'noerror)
(put 'narrow-to-region 'disabled nil)
