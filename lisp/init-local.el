;;; init-local.el --- Load the local configuration
;;; Commentary:

;; This file contains local configuration.

;;; Code:

;; Set path for Emacs 27 for GPG path
;; (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
;; (setq exec-path (append exec-path '("/usr/local/bin")))

;; Package cl is deprecated
;; (setq byte-compile-warnings '(cl-functions))
;; (require 'loadhist)
;; (file-dependents (feature-file 'cl))

;; Produce backtraces when errors occur
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(epg-gpg-program "/usr/local/bin/gpg"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(maybe-require-package 'web-mode)
(maybe-require-package 'undo-tree)
(maybe-require-package 'flycheck-mode)

(global-undo-tree-mode)

;; (require 'emmet-mode)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.svelte\\'" . web-mode))

(defun web-mode-config ()
  "The web-mode configuration, for web-mode-hook."
  (local-set-key (kbd "RET") 'newline-and-indent)
  (setq company-dabbrev-downcase nil)
  (emmet-mode 1)
  )

(add-hook 'web-mode-hook 'web-mode-config)

(after-load 'js2-mode
  (define-key js2-mode-map (kbd "<f5>") 'rjsx-mode))

(provide 'init-local)

;; Map key for avy-goto-line
;; (define-key global-map (kbd "M-g f") 'avy-goto-line)
(global-set-key (kbd "M-g f") 'avy-goto-line)

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

;; Using Sourcekit with LSP
;; (require 'lsp-sourcekit)
;; (setenv "SOURCEKIT_TOOLCHAIN_PATH" "/Library/Developer/Toolchains/swift-latest.xctoolchain")
;; (setq lsp-sourcekit-executable (expand-file-name "usr/bin/sourcekit-lsp" (getenv "SOURCEKIT_TOOLCHAIN_PATH")))

;; (require 'company-lsp)
;; (push 'company-lsp company-backends)

;; Add winnow mode for ag-mode
(add-hook 'ag-mode-hook 'winnow-mode)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
;;; init-local.el ends here
