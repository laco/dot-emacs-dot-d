;;; magit.el -- Git better

(package-require 'magit)

(global-set-key (kbd "C-x g") 'magit-status)

;; Github integration
(package-require 'gist)

(defun l/accept-merge-request (rbranch)
  "Accept merge request from remote origin/** branch to master."
  (interactive
   (list (magit-read-rev "Accept merge request from:" (or (magit-guess-branch)
							  (magit-get-current-branch)))))
  (when (string-match "^\\(?:refs/\\)?remotes/\\([^/]+\\)/\\(.+\\)" rbranch)
    (let* ((remote (match-string 1 rbranch))
           (branch (match-string 2 rbranch))
	   (magit-custom-options (list "--no-ff")))
      (magit-run-git "checkout" "-b" branch rbranch)
      (magit-run-git "checkout" "master")
      (magit-merge branch)
      (magit-delete-branch branch)
      )
  ))
  

(provide 'laco-magit)
