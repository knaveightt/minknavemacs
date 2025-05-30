;; ---
(defvar minknavemacs/window-manage-repeat-map
  (let ((map (make-sparse-keymap)))
	(define-key map (kbd "c") 'enlarge-window)
	(define-key map (kbd "C") 'shrink-window)
	(define-key map (kbd "v") 'enlarge-window-horizontally)
	(define-key map (kbd "V") 'shrink-window-horizontally)
	map))

(put 'enlarge-window 'repeat-map 'minknavemacs/window-manage-repeat-map)
(put 'shrink-window 'repeat-map 'minknavemacs/window-manage-repeat-map)
(put 'enlarge-window-horizontally 'repeat-map 'minknavemacs/window-manage-repeat-map)
(put 'shrink-window-horizontally 'repeat-map 'minknavemacs/window-manage-repeat-map)

;; ---
(defun minknavemacs/modal-find-file ()
  "Runs find file or set-fill-column depending on ryo-modal-mode"
  (interactive)
  (if ryo-modal-mode
      (call-interactively 'find-file)
    (call-interactively 'set-fill-column)))

;; ---
(defun minknavemacs/modal-print-backtick ()
  "A function to print the backtick character, since the key has special meaning."
  (interactive)
  (insert "`"))

;; --- 
(defun minknavemacs/modal-shift-point-top ()
  "Move the point to the top of the window without any scrolling."
  (interactive)
  (move-to-window-line-top-bottom '(0)))

;; --- 
;; https://www.reddit.com/r/emacs/comments/r7l3ar/how_do_you_scroll_half_a_page/
(defun minknavemacs/scroll-down-half-page ()
  "scroll down half a page while keeping the cursor centered" 
  (interactive)
  (let ((ln (line-number-at-pos (point)))
        (lmax (line-number-at-pos (point-max))))
    (cond ((= ln 1) (move-to-window-line nil))
          ((= ln lmax) (recenter (window-end)))
          (t (progn
               (move-to-window-line -1)
               (recenter))))))

;; --- 
(defun minknavemacs/scroll-up-half-page ()
  "scroll up half a page while keeping the cursor centered"
  (interactive)
  (let ((ln (line-number-at-pos (point)))
        (lmax (line-number-at-pos (point-max))))
    (cond ((= ln 1) nil)
          ((= ln lmax) (move-to-window-line nil))
          (t (progn
               (move-to-window-line 0)
               (recenter))))))

;; --- 
(defun minknavemacs/modal-shift-point-bottom ()
  "Move the point to the bottom of the window without any scrolling."
  (interactive)
  (let ((current-prefix-arg '-))
    (call-interactively 'move-to-window-line-top-bottom)))

;; ---
(defun minknavemacs/modal-open-line-below ()
  "Creates a new line below the current line."
  (interactive)
  (end-of-line)
  (electric-newline-and-maybe-indent))

;; ---
(defun minknavemacs/modal-open-line-above ()
  "Creates a new line above the current line."
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1))

;; ---
(defun minknavemacs/modal-set-mark-line ()
  "Selects the current line."
  (interactive)
  (beginning-of-line)
  (call-interactively 'set-mark-command)
  (forward-line))

;; ---
(defun minknavemacs/modal-quick-set-mark ()
  "Sets the mark by calling set mark command interactively."
  (interactive)
  (call-interactively 'set-mark-command))

;; ---
(defun minknavemacs/modal-backward-symbol ()
  "Moves backward a symbol."
  (interactive)
  (forward-symbol -1))

;; ---
(defun minknavemacs/modal-recenter-top ()
  "Moves the line containing the point to the top of window."
  (interactive)
  (recenter-top-bottom 0))

(defun minknavemacs/modal-recenter-bottom ()
  "Moves the line containing the point to the bottom of window."
  (interactive)
  (recenter-top-bottom -1))

(defun minknavemacs/jump-back-to-mark ()
  "Interactive function that attempts to move the cursor to the previously set mark."
  (interactive)
  (setq current-prefix-arg '(4)) ; C-u
  (call-interactively 'set-mark-command))

(defun minknavemacs/dwim-delete ()
  "Kills a region if a region is active, otherwise executes kill-line"
  (interactive)
  (if (region-active-p)
	  (call-interactively 'kill-region)
	(kill-line)))

;; end minknavemacs-keyfunc.el
(provide 'minknavemacs-keyfunc)
