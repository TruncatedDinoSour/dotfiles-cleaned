(prefer-coding-system 'utf-8)                       ;; Enable UTF-8
(ido-mode 1)                                        ;; Make things nice

(fset 'yes-or-no-p 'y-or-n-p)                       ;; Don't require users to type `yes` or `no`, y/n instead

(setq backup-inhibited t)                           ;; Disable backups
(setq ring-bell-function 'ignore)                   ;; Disable sound
(setq standard-indent 4)                            ;; Set indents to 4 spaces
(setq diff-switches "-u")                           ;; Enable `diff` unified context
(setq frame-background-mode 'dark)                  ;; Enable dark mode
(setq-default truncate-lines 1)                     ;; Disable word wrap
(setq custom-theme-directory "~/.emacs.d/themes")   ;; Set themes dir
(setq inhibit-startup-message t)                    ;; Hide welcome screen
(setq transient-mark-mode t)                        ;; Better selection
(setq gc-cons-threshold (* 100 1024 1024)           ;; Set up LSP
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)
(setq yas-prompt-functions                          ;; YASnippet prompt
      '(yas-x-prompt yas-dropdown-prompt))


(setq package-enable-at-startup nil)                ;; Enable packags at startup
(setq package-archives '(                           ;; Add package repositories
        ("gnu" . "http://mirrors.163.com/elpa/gnu/")
        ("melpa" . "https://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")
    )
)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(cursor-type 'hbar)
 '(custom-enabled-themes '(coffee\.emacs))
 '(custom-safe-themes
   '("82750e71e8d7484d59e258e1c0eabd5ede216fa747bf14a26318579576b9f539" default))
 '(highlight-indent-guides-character 183)
 '(highlight-indent-guides-method 'character)
 '(linum-relative-format '"%5s ")
 '(package-selected-packages
   '(web-mode python-black flymake-python-pyflakes flymake-sass json-mode flymake-eslint flymake-flycheck flymake-css flymake-shellcheck exwm highlight-numbers linum-relative hlinum highlight-indent-guides format-all auto-yasnippet yasnippet-snippets dap-mode helm-xref which-key avy-menu avy-flycheck company flycheck projectile helm-lsp yasnippet auto-complete lsp-python-ms helm ## lsp-pyright lsp-mode term-run))
 '(tab-width 4))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(which-key-mode)                                    ;; Which key


(require 'helm-xref)                                ;; Helm

(helm-mode)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)


(set-frame-font "Hack Nerd Font 15" nil t)          ;; Set default font

(setq-default frame-title-format (list '(           ;; Show full dir
    (buffer-file-name " %f"
        (dired-directory dired-directory
            (revert-buffer-function " %b" ("%b - Dir:  " default-directory))))))
)


(require 'linum-relative)                           ;; Enable relative line numbers
(require 'hlinum)                                   ;; Highlight current number

(global-linum-mode 1)                               ;; Enable line numbering
(column-number-mode 1)                              ;; Show colums in the bar
(setq display-line-numbers-type 'relative)          ;; Set relative numbers

(add-hook 'prog-mode-hook 'linum-relative-mode)
(hlinum-activate)

(require 'highlight-numbers)                        ;; Enable number highlighting
(add-hook 'prog-mode-hook 'highlight-numbers-mode)


(show-paren-mode 1)                                 ;; Highlight matching paren

(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))


(menu-bar-mode -1)                                  ;; Disable useless decorations
(scroll-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)


(add-hook 'write-file-hooks
          'delete-trailing-whitespace)              ;; Remove trailing whitespace on write


(global-set-key "\C-l" 'goto-line)                  ;; Nice shortcuts
(global-set-key (kbd "C-c c") 'comment-dwim)
(global-set-key "\C-x\C-b" 'buffer-menu-other-window)


(add-to-list 'auto-mode-alist                       ;; Modes
             '("\.py\'" . python-mode))
(add-to-list 'auto-mode-alist
             '("\.php\'" . php-mode))


(add-hook 'c-mode-hook 'lsp)                        ;; LSP
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'python-mode-hook 'lsp)
(add-hook 'javascript-mode-hook 'lsp)
(add-hook 'html-mode-hook 'lsp)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))


(require 'yasnippet)                                ;; Snippets
(define-key yas-minor-mode-map (kbd "C-c y") #'yas-expand)


(defun format-code ()
  "Auto-format whole buffer."

  (interactive)
  (if (derived-mode-p 'prolog-mode)
      (prolog-indent-buffer)
    (format-all-buffer)))

(global-set-key (kbd "M-F") #'format-code)
(add-hook 'prog-mode-hook #'format-all-ensure-formatter)


(set-window-margins (selected-window) 2 2)          ;; Add some margins


(add-hook 'prog-mode-hook
          'highlight-indent-guides-mode)            ;; Show indentation


(set 'xterm-standard-colors                         ;; Terminal setup
  '(("black"          0 (38  34  32 ))
    ("red"            1 (175 95  95 ))
    ("green"          2 (135 135 95 ))
    ("yellow"         3 (188 188 108))
    ("blue"           4 (102 108 127))
    ("magenta"        5 (205 121 152))
    ("cyan"           6 (109 151 138))
    ("white"          7 (187 187 187))
    ("brightblack"    8 (143 148 148))
    ("brightred"      9 (187 104 104))
    ("brightgreen"   10 (132 145 85 ))
    ("brightyellow"  11 (197 197 99 ))
    ("brightblue"    12 (135 175 175))
    ("brightmagenta" 13 (201 135 160))
    ("brightcyan"    14 (124 162 150))
    ("brightwhite"   15 (221 208 192)))
)

;; Disable useless keys
(dolist (useless-keys '(
              [mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]
              [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
              [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
              [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
              [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]

              [left]   [right]   [up]   [down]
              [C-left] [C-right] [C-up] [C-down]
              [M-left] [M-right] [M-up] [M-down]

              [C-backspace] [M-backspace]
              [C-delete]    [M-delete]
    ))

    (global-unset-key useless-keys)
)


;; Web-mode

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))


;; Format python using black

(require 'python-black)
(add-hook 'python-mode-hook 'python-black-on-save-mode-enable-dwim)


;; Pyflakes

(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)


;; SASS and CSS

(require 'flymake-sass)
(require 'flymake-css)

(add-hook 'sass-mode-hook 'flymake-sass-load)
(add-hook 'css-mode-hook 'flymake-css-load)


;; JSON mode

(require 'json-mode)
(add-to-list 'auto-mode-alist '("\.json\'" . json-mode))


;; ESLint for JS

(add-hook 'web-mode-hook
    (lambda ()
        (flymake-eslint-enable)))


;; Flycheck

(setq-local flymake-diagnostic-functions (flymake-flycheck-all-chained-diagnostic-functions))


;; Shellcheck

(add-hook 'sh-mode-hook 'flymake-shellcheck-load)
