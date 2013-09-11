;; jboss-mode.el - minor mode for reading jboss logfiles
;; Author: Matthias Pfeifer (mpfeifer77@gmail.com)
;; -----------------------------------------------
;;

(defun mp::goto-next-DEBUG ()
  "Go to next line with level of debug or lower."  
  (interactive)
  (re-search-forward "^[0-9:,]+ \\(DEBUG\\)")
  )

(defun mp::goto-next-TRACE ()
  "Go to next line with level of debug or lower."  
  (interactive)
  (re-search-forward "^[0-9:,]+ \\(TRACE""\\)")
  )

(defun mp::goto-next-ERROR ()
  "Go to next line with level of error or lower."  
  (interactive)
  (re-search-forward "^[0-9:,]+ \\(FATAL\\|ERROR\\)")
  )

(defun mp::goto-next-WARN ()
  "Go to next line with level of warn or lower."
  (interactive)
  (re-search-forward "^[0-9:,]+ \\(WARN\\|ERROR\\|FATAL\\)")
  )

(defun mp::goto-next-INFO ()
  "Go to next line with level of warn or lower."
  (interactive)
  (re-search-forward "^[0-9:,]+ \\(INFO\\|WARN\\|ERROR\\|FATAL\\)")
  )

(define-derived-mode jboss-mode read-only-mode "jboss"
  "A major mode for viewing jboss logfiles."
  :keymap jboss-mode-map

    (local-set-key (kbd "C-w") 'mp::goto-next-WARN)
    (local-set-key (kbd "C-e") 'mp::goto-next-ERROR)
    (local-set-key (kbd "C-d") 'mp::goto-next-DEBUG)
    (local-set-key (kbd "k") 'scroll-down-one-line)
    (local-set-key (kbd "j") 'scroll-up-one-line)
    (let ((jboss-font-lock-keywords
           '(("^[0-9:,]+[[:space:]]" . font-lock-comment-face)
             ("INFO" . font-lock-constant-face)
             ("ERROR" . font-lock-preprocessor-face)
             ("DEBUG" . font-lock-keyword-face)
             ("WARN\\|WARNUNG" . font-lock-function-name-face)
             ("FATAL\\|SCHWERWIEGEND" . font-lock-function-name-face)
             ("\\[[a-zA-Z0-9.]+\\]" . font-lock-type-face)
             ("([[:space:]A-Za-z0-9-]+)" . font-lock-builtin-face)
             )))
      (setq font-lock-defaults '(jboss-font-lock-keywords)))
  )

(provide 'jboss-mode)
