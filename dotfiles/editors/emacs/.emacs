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

(custom-set-variables                               ;; Packages
    '(custom-enabled-themes '(coffee\.emacs))       ;; Themes
    '(custom-safe-themes
        '("fd29c0580c88251e0e2004dbce4a135bf0c6894d64bfc80f169971351b2cb7cb" default))

    '(highlight-indent-guides-character 183)        ;; Hlinum config
    '(highlight-indent-guides-method 'character)

    '(linum-relative-format '"%5s ")                ;; Linum config

    ;; Packages
    '(package-selected-packages
        '(linum-relative hlinum highlight-indent-guides format-all auto-yasnippet yasnippet-snippets dap-mode helm-xref which-key avy-menu avy-flycheck company flycheck projectile helm-lsp yasnippet auto-complete lsp-python-ms helm ## lsp-pyright lsp-mode term-run))

    '(tab-width 4)                                  ;; 4 spaces indentation
)

(custom-set-faces
    ;; Faces
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
