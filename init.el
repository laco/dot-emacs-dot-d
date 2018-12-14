;; When I was a child, I spake as a child,
;; I understood as a child, I thought as a child:
;; but when I became a man, I put away childish things.
;;   -- 1 Corinthians, 13:11
(dolist (mode '(tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))


;; Always ALWAYS use UTF-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(load-library "iso-transl")
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LC_CTYPE" "en_US.UTF-8")

;; Always ask for y/n keypress instead of typing out 'yes' or 'no'
(defalias 'yes-or-no-p 'y-or-n-p)


;; Write backup files to .saves directory
(setq backup-directory-alist `(("." . "~/.saves"))
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t
      backup-directory-alist
      `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; Ignore the ugly splash window and load an empty buffer
(setq inhibit-splash-screen t)
(switch-to-buffer "**")

;; Use Recent Files (https://www.emacswiki.org/emacs/RecentFiles)
(recentf-mode 1)
(setq recentf-max-menu-items 32)

;; Install use-package (https://github.com/jwiegley/use-package)
(package-initialize)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t
      package-archive-priorities '(("melpa-stable" . 1)))
 

;;; Essential packages

;; magit
(use-package magit)


;; helm
(use-package helm
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x C-b" . helm-buffers-list)
         ([S-f10] . helm-recentf))

  :config (helm-mode 1))


;; projectile
(use-package projectile
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (setq projectile-enable-caching t))

(use-package helm-projectile
  :bind ("M-t" . helm-projectile-find-file)
  :config
  (helm-projectile-on))

;; ag, helm-ag?

;; avy

;; evil-mode

;; ensime (scala)
(use-package ensime :pin melpa-stable)
(use-package sbt-mode :pin melpa-stable)
(use-package scala-mode :pin melpa-stable)

;; exex-path-from-shell for fixing environment variables
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;; auto complete
(use-package company
  :config
  (global-company-mode)
  (setq company-idle-delay 0)
  (setq company-echo-delay 0))

(use-package company-statistics
  :config
  (add-hook 'after-init-hook 'company-statistics-mode))


;; clojure programming essentials
(use-package clojure-mode)
(use-package paredit
  :init
  (add-hook 'clojure-mode-hook 'paredit-mode))

(use-package cider)


;; Disable background if opened in a terminal

(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

;; customization
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
