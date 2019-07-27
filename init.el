;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;(package-initialize)

(require 'package)
(setq package-archives
  '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")
     ("melpa-china" . "http://elpa.emacs-china.org/melpa/")))
(package-initialize)
 
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
    t
    (if (or (assoc package package-archive-contents) no-refresh)
      (if (boundp 'package-selected-packages)
        ;; Record this as a package the user installed explicitly
        (package-install package nil)
        (package-install package))
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))
(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
    (require-package package min-version no-refresh)
    (error
      (message "Couldn't install optional package `%s': %S" package err)
      nil)))



(set-face-foreground 'minibuffer-prompt "blue")

;; all backups goto ~/.backups instead in the current directory
(setq backup-directory-alist (quote (("." . "~/.emacs_backups"))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit exec-path-from-shell yasnippet auto-complete company base16-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require-package 'base16-theme)
(require-package 'auto-complete)
(require-package 'company)

;;load theme
(load-theme 'base16-default-dark t)

(global-linum-mode 1) ; always show line numbers

(add-hook 'after-init-hook'global-company-mode)

(global-auto-complete-mode 1)

;;ask y or n
(fset 'yes-or-no-p 'y-or-n-p)

;;display-time
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

;;yasnippet
(require-package 'yasnippet)
(require-package 'yasnippet-snippets)
(require 'yasnippet)
(yas-global-mode 1)

;; all backups goto ~/.backups instead in the current directory
(setq backup-directory-alist (quote (("." . "~/.emacs-backups"))))

(global-auto-revert-mode t)

;; set tab
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq c-default-style "Linux")
(setq c-basic-offset 4)

(require-package 'magit)
