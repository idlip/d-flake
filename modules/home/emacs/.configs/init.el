;; You will most likely need to adjust this font size for your system!
(defvar default-font-size 190)
(defvar default-variable-font-size 190)
(setf use-default-font-for-symbols nil)
(set-fontset-font t 'unicode "Noto Emoji" nil 'append)

(defun display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'display-startup-time)
;; If you are thinking about adding codes for garbage-collect (gc-cons-threshold), we already did that in early-init.el

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package no-littering)

  ;; no-littering doesn't set this by default so we must place
  ;; auto save files in the same path as it uses for sessions
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
;;  (setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
  (setq delete-old-versions -1)
  (setq version-control t)
  (setq vc-make-backup-files t)

  (use-package savehist
  :init
  (savehist-mode)
  :custom
  (setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring)))

(defun split-and-follow-horizontally ()
  "Basically to balance and change cursor to split window"
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun split-and-follow-vertically ()
  "Basically to balance and change cursor to split window"
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))

(defun d/scroll-down ()
  "Trust me, make scrolling alot smoother. +1 Makes you fall in love with Emacs again!"
       (interactive)
       (pixel-scroll-precision-scroll-down 40))

(defun d/scroll-up ()
  "Trust me, adds a wonderfull smooth scroll. You can do this by trackpad too (laptop)"
       (interactive)
       (pixel-scroll-precision-scroll-up 40))
(defun d/refresh-buffer ()
    "Revert buffer without confirmation."
    (interactive)
    (revert-buffer :ignore-auto :noconfirm))

(defun window-focus-mode ()
  "Make the window focused, it can toggled in and out"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_)
    (progn
      (set-register '_ (list (current-window-configuration)))
      (delete-other-windows))))

(global-set-key (kbd "M-v") #'d/scroll-up)
(global-set-key (kbd "C-v") #'d/scroll-down)
(global-set-key (kbd "C-<f5>") #'d/refresh-buffer)

(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)
(global-set-key [C-tab] 'other-window)
(global-set-key (kbd "C-c c") 'calendar)

(global-set-key (kbd "C-c f") 'window-focus-mode)
;; (global-set-key (kbd "C-M-r") 'undo-redo)
(global-set-key (kbd "C-M-r") 'undo-tree-redo) ;; If want to use undo-tree mode
(global-set-key (kbd "M-j") 'avy-goto-char-timer) ;;Save ton to pain/strain
(global-set-key (kbd "M-K") 'avy-kill-region) ;; Practise these two avy binding, it will be of great help
(global-set-key (kbd "C-x C-k") 'd/kill-buffer) ;; My func to clear cache along killing buffer
(global-set-key (kbd "C-x k") 'd/kill-buffer)
(global-set-key (kbd "M-%") 'query-replace-regexp) ;; Hail regexp searching!

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(defalias 'yes-or-no-p 'y-or-n-p) ;; Make confirmation messages easy and not a pain.

;; First gotta unbind to use a key combo as general key. Maybe useful for custom bind and easy access. Make it for your liking
(global-unset-key (kbd "M-SPC"))

(use-package general
  :config
  (general-create-definer leader-keys
    :prefix "M-SPC"))
(leader-keys
  ;; Toggle modes and looks
  "t"  '(:ignore t :which-key "toggles")
  "tt" '(consult-theme :which-key "choose theme")
  "tc" '(rainbow-mode :which-key "colorizer")
  "te" '(insert-char :which-key "characters")
  "ti" '(all-the-icons-insert :which-key "icons")
  "tv" '(org-mode-visual-fill :which-key "visual reading")
  "tm" '(bookmark-jump :which-key "bookmarks")
  "tr" '(d/bionic-region :which-key "bionic reading region")
  "tR" '(d/bionic-read :which-key "bionic reading buffer")

  ;; tabs mode
  "y"  '(:ignore t :which-key "tabs")
  "yn" '(tab-new :which-key "new tab")
  "yk" '(tab-close :which-key "close tab")
  "yl" '(tab-list :which-key "list tabs")
  "ys" '(tab-switch :which-key "switch tabs")
  "yu" '(tab-undo :which-key "undo tab")
  "yr" '(tab-rename :which-key "rename tab")
  "yn" '(tab-next :which-key "next tab(gt)")

  ;; games
  "g" '(:ignore t :which-key "games")
  "gz" '(zone :which-key "zone out")


  ;; window manager
  "w"  '(:ignore t :which-key "window")
  "wf" '(window-focus-mode :which-key "max window")
  "wq" '(d/kill-buffer :which-key "close buffer")


  ;; Apps
  "p"  '(:ignore t :which-key "apps")
  "pe" '(elfeed :which-key "rss reader")
  "pw" '(eww :which-key "eww browser")
  "pd" '(counsel-linux-app :which-key "app menu")
  "pm" '(mingus-browse :tag "Name" :which-key "music player")
  "pn" '(newsticker-treeview :tag "Name" :which-key "rss feeds")
  "pr" '(:ignore t :which-key "reddit browser")
  "prr" '(reddigg-view-sub :tag "Name" :which-key "subreddit")
  "prp" '(reddigg-view-comments :tag "Name" :which-key "comment")
  "prm" '(reddigg-view-frontpage :which-key "main page")
  "ps" '(howdoyou-query :tag "Name" :which-key "stack overflow")

  "e" '(:ignore t :which-key "eww")
  "ew" '(eww-search-words :which-key "open in eww")
  "ef" '(elfeed-open-in-eww :which-key "open feed in eww")

  "~" '(insert-char :which-key "Insert Char/Emoji")
  "`" '(all-the-icons-insert :which-key " All Icons")    
  ;; script
  "," '(:ignore t :which-key "Script browser")
  ",," '(d/external-browser :which-key "open links avy")
  ",b" '(d/external-browser :which-key "External Browser")
  ",`" '(insert-char :which-key "Insert Char/Emoji")
  ",l" '(d/buffer-links :which-key "list buff link")
  ",p" '(d/print-buffer-links :which-key "print links")

  ;; dictionary
  "d" '(:ignore t :which-key "dictionary")
  "d w" '(sdcv-search-pointer :which-key "word at point")
  "d s" '(sdcv-search-input :which-key "search word")
  "d d" '(sdcv-search-input :which-key "search word")
  "d p" '(sdcv-search-pointer+ :which-key   "hover word at point")
  "d f" '(sdcv-search-input+ :which-key "hover input word")

  ;; open
  "o"  '(:ignore t :which-key "open-org")
  "oo" '(org-capture :which-key "org template")
  "oa" '(org-agenda :which-key "org agenda")
  "oa" '(org-agenda :which-key "org agenda")

  ;; quickie
  "RET" '(vterm :which-key "Terminal")
  "<backtab>" '(previous-buffer :which-key "prev buffer")
  "TAB" '(next-buffer :which-key "next buffer")
  "n" '(dired :which-key "file browser")
  ;;"s" '(swiper :which-key "search text")
  "3" '(comment-line :which-key "ucomment")

  ;; music
  "m"  '(:ignore t :which-key "music")
  "mp" '(mingus-toggle :tag "Name" :which-key "play/pause")
  "m>" '(mingus-next :tag "Name" :which-key "next song")
  "m<" '(mingus-prev :tag "Name" :which-key "prev song")

  ;; consults
  "c" '(:ignore t :which-key "consultant")
  "c b" '(consult-buffer :which-key "buffer list")
  "c f" '(consult-find :which-key "find files")
  "c r" '(consult-ripgrep :which-key "live grep dir")
  "c l" '(consult-line :which-key "see-lines")
  "c t" '(consult-theme :which-key "themer")
  "c k" '(consult-bookmark :which-key "bookmarks")
  "c m" '(consult-man :which-key "man pager")

  ;; registers
  "r" '(:ignore t :which-key "registers")
  "r g" '(consult-register :which-key "register")
  "r s" '(consult-register-store :which-key "store register")
  "r l" '(consult-register-load :which-key "load register")

  ;; file
  "f"  '(:ignore t :which-key "files")
  "fd" '(dired :which-key "find directory")
  "ff" '(find-file :which-key "find file")
  "RET" '(vterm :which-key "Terminal")
  "f r" '(config-reload :which-key "reload config")

  ;; configs
  "fc"  '(:ignore t :which-key "configs")
  "fce" '(lambda () (interactive) (find-file (expand-file-name "~/.__D_NIX__/modules/home/emacs/config.org"))))

(use-package which-key
  :defer 0
  :init
  (setq which-key-side-window-location 'bottom
        which-key-sort-order #'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10
        which-key-side-window-max-height 0.25
        which-key-idle-delay 0.8
        which-key-max-description-length 25
        which-key-allow-imprecise-window-fit t
        which-key-separator " → " )
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package rainbow-mode
  :init (add-hook 'prog-mode-hook 'rainbow-mode))

(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount nil)
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  (setq vertico-scroll-margin 1)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  (setq completion-cycle-threshold 3)
  (setq tab-always-indent 'complete)
  (setq enable-recursive-minibuffers t))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))
(define-key vertico-map "?" #'minibuffer-completion-help)
(define-key vertico-map (kbd "M-RET") #'minibuffer-force-complete-and-exit)
(define-key vertico-map (kbd "M-TAB") #'minibuffer-complete)
(setq completion-styles '(substring orderless basic))
(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)
;; Use `consult-completion-in-region' if Vertico is enabled.
;; Otherwise use the default `completion--in-region' function.
;; (setq completion-in-region-function
;;       (lambda (&rest args)
;;         (apply (if vertico-mode
;;                    #'consult-completion-in-region
;;                  #'completion--in-region)
;;                args)))

(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x C-b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-ripgrep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("C-s" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window)

  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key (kbd "M-.")
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both  and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")
  )

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package corfu
  :defer 1
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-preview-current t)    ;; Disable current candidate preview
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-quit-no-match t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.0)
  (corfu-quit-at-boundary 'separator)
  (corfu-echo-documentation 0.25)
  (corfu-preview-current 'insert)
  (corfu-preselect-first t)
  (corfu-history 1)
  (corfu-scroll-margin 0)
  :bind (:map corfu-map
              ("M-SPC" . corfu-insert-separator)
              ("TAB" . corfu-insert)
              ("RET" . corfu-insert))
  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  :init
  (corfu-history-mode)
  (global-corfu-mode))

(unless (display-graphic-p)
  (corfu-terminal-mode +1))

;; Add extensions
  (use-package cape
    :bind (("C-c p p" . completion-at-point) ;; capf
           ("C-c p t" . complete-tag)        ;; etags
           ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
           ("C-c p h" . cape-history)
           ("C-c p f" . cape-file)
           ("C-c p k" . cape-keyword)
           ("C-c p s" . cape-symbol)
           ("C-c p a" . cape-abbrev)
           ("C-c p i" . cape-ispell)
           ("C-c p l" . cape-line)
           ("C-c p w" . cape-dict)
           ("C-c p \\" . cape-tex)
           ("C-c p _" . cape-tex)
           ("C-c p ^" . cape-tex)
           ("C-c p &" . cape-sgml)
           ("C-c p r" . cape-rfc1345))
    :init
    (add-to-list 'completion-at-point-functions #'cape-dabbrev)
    (add-to-list 'completion-at-point-functions #'cape-file)
    (add-to-list 'completion-at-point-functions #'cape-history)
    (add-to-list 'completion-at-point-functions #'cape-keyword)
    ;; (add-to-list 'completion-at-point-functions #'cape-tex)
    ;; (add-to-list 'completion-at-point-functions #'cape-sgml)
    ;; (add-to-list 'completion-at-point-functions #'cape-rfc1345)
    (add-to-list 'completion-at-point-functions #'cape-abbrev)
    (add-to-list 'completion-at-point-functions #'cape-ispell)
    (add-to-list 'completion-at-point-functions #'cape-dict)
    ;; (add-to-list 'completion-at-point-functions #'cape-symbol)
    ;; (add-to-list 'completion-at-point-functions #'cape-line)
    )

;; Add your own file with all words
    (defcustom cape-dict-file "~/.local/share/dict/vocab"
      "Dictionary word list file."
      :type 'string)


    (setq-local corfu-auto t
                corfu-auto-delay 1
                corfu-auto-prefix 0
                completion-category-defaults nil
                completion-category-overrides '((file (styles partial-completion)))
                completion-styles '(orderless basic))

    (defun corfu-enable-always-in-minibuffer ()
      "Enable corfi in minibuffer, if vertico is not active"
      (unless (or (bound-and-true-p mct--active)
                  (bound-and-true-p vertico--input)
                  (eq (current-local-map) read-passwd-map))
        (setq-local corfu-auto t
                    corfu-popupinfo-delay nil
                    corfu-auto-delay 0
                    corfu-auto-prefix 0
                    completion-styles '(orderless basic))
        (corfu-mode 1)))
    (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1)

(use-package org-modern)
    (add-hook 'org-mode-hook #'org-modern-mode)
    (add-hook 'org-agenda-finalize-hook #'org-modern-agenda)

    ;; Option 2: Globally
    (global-org-modern-mode)
    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (scroll-bar-mode -1)

    ;; Choose some fonts
    ;; (set-face-attribute 'default nil :family "Iosevka")
    ;; (set-face-attribute 'variable-pitch nil :family "Iosevka Aile")
    ;; (set-face-attribute 'org-modern-symbol nil :family "Iosevka")

    ;; Add frame borders and window dividers
    (modify-all-frames-parameters
     '((right-divider-width . 15)
       (internal-border-width . 15)))
    (dolist (face '(window-divider
                    window-divider-first-pixel
                    window-divider-last-pixel))
      (face-spec-reset-face face)
      (set-face-foreground face (face-attribute 'default :background)))
  (setq
   ;; Edit settings
   org-auto-align-tags nil
   org-tags-column 0
   org-catch-invisible-edits 'show-and-error
   org-special-ctrl-a/e t
   org-insert-heading-respect-content t

   ;; Org styling, hide markup etc.
   org-hide-emphasis-markers t
   org-pretty-entities t
;;   org-ellipsis "…"

   ;; Agenda styling
   org-agenda-tags-column 0
   org-agenda-block-separator ?─
   org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
   org-agenda-current-time-string
   "⭠ now ─────────────────────────────────────────────────")

  (global-org-modern-mode)

(defun org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.3)
                  (org-level-2 . 1.2)
                  (org-level-3 . 1.1)
                  (org-level-4 . 1.1)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Comic Code Ligatures" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :slant 'normal :weight 'semibold :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :weight 'ultrabold :slant 'normal :inherit 'fixed-pitch ))

(defun org-mode-setup ()
  (org-indent-mode)
  (org-modern-mode 1)
  (org-display-inline-images)
  (variable-pitch-mode 1)
  (flyspell-mode 1)
  (setq
   org-startup-indented t
   org-startup-folded t)
  (visual-line-mode 1))

(use-package org
  :pin org
  :commands (org-capture org-agenda)
  :hook (org-mode . org-mode-setup)
  :config
  (setq org-ellipsis " ▾")

  (setq org-agenda-start-with-log-mode t)
  ;; (setq org-log-done 'time)
  (setq org-log-done 'note)
  (setq org-log-into-drawer t)

  ;; browser script
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "d-stuff")
  (setq browse-url-secondary-browser-function 'browse-url-generic
        browse-url-generic-program "d-stuff")

  (setq org-agenda-files
        '("~/sync/org/tasks.org"
          "~/sync/org/mails.org"
          "~/sync/org/one-time.org"))

  ;; (require 'org-habit)
  ;; (add-to-list 'org-modules 'org-habit)
  ;; (setq org-habit-graph-column 60)

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
          (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
        '(("Archive.org" :maxlevel . 1)
          ("tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
        '((:startgroup)
                                        ; Put mutually exclusive tags here
          (:endgroup)
          ("@errand" . ?E)
          ("@home" . ?H)
          ("@work" . ?W)
          ("agenda" . ?a)
          ("planning" . ?p)
          ("publish" . ?P)
          ("batch" . ?b)
          ("note" . ?n)
          ("idea" . ?i)))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
        '(("d" "Dashboard"
           ((agenda "" ((org-deadline-warning-days 7)))
            (todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))
            (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

          ("n" "Next Tasks"
           ((todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))))

          ("W" "Work Tasks" tags-todo "+work-email")

          ;; Low-effort next actions
          ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
           ((org-agenda-overriding-header "Low Effort Tasks")
            (org-agenda-max-todos 20)
            (org-agenda-files org-agenda-files)))

          ("w" "Workflow Status"
           ((todo "WAIT"
                  ((org-agenda-overriding-header "Waiting on External")
                   (org-agenda-files org-agenda-files)))
            (todo "REVIEW"
                  ((org-agenda-overriding-header "In Review")
                   (org-agenda-files org-agenda-files)))
            (todo "PLAN"
                  ((org-agenda-overriding-header "In Planning")
                   (org-agenda-todo-list-sublevels nil)
                   (org-agenda-files org-agenda-files)))
            (todo "BACKLOG"
                  ((org-agenda-overriding-header "Project Backlog")
                   (org-agenda-todo-list-sublevels nil)
                   (org-agenda-files org-agenda-files)))
            (todo "READY"
                  ((org-agenda-overriding-header "Ready for Work")
                   (org-agenda-files org-agenda-files)))
            (todo "ACTIVE"
                  ((org-agenda-overriding-header "Active Projects")
                   (org-agenda-files org-agenda-files)))
            (todo "COMPLETED"
                  ((org-agenda-overriding-header "Completed Projects")
                   (org-agenda-files org-agenda-files)))
            (todo "CANC"
                  ((org-agenda-overriding-header "Cancelled Projects")
                   (org-agenda-files org-agenda-files)))))))

  (setq org-capture-templates
        `(("t" "Tasks / Projects")
          ("tt" "Task" entry (file+olp "~/docs/org/tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

          ;;mails
          (("m" "Email Workflow")
           ("mf" "Follow Up" entry (file+olp "~/sync/org/mails.org" "Follow Up")
            "* TODO Follow up with %:fromname on %:subject\n%a\n\n%i")
           ("mr" "Read Later" entry (file+olp "~/sync/org/mails.org" "Read Later")
            "* TODO Read %:subject\n%a\n\n%i"))

          ("j" "Journal Entries")
          ("jj" "Journal" entry
           (file+olp+datetree "~/docs/org/journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
          ("jm" "Meeting" entry
           (file+olp+datetree "~/docs/org/journal.org")
           "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)

          ("w" "Workflows")
          ("we" "Checking Email" entry (file+olp+datetree "~/docs/org/journal.org")
           "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

          ("m" "Metrics Capture")
          ("mw" "Weight" table-line (file+headline "~/docs/org/metrics.org" "Weight")
           "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

  (define-key global-map (kbd "C-c j")
              (lambda () (interactive) (org-capture nil "jj")))

  (org-font-setup))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (calc . t)
     (latex . t)
     (shell .t)
     (python . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("txt" . "src text"))
  (add-to-list 'org-structure-template-alist '("conf" . "src conf"))
  (add-to-list 'org-structure-template-alist '("nix" . "src nix"))    
  (add-to-list 'org-structure-template-alist '("lx" . "src latex"))
  (add-to-list 'org-structure-template-alist '("cal" . "src calc")))

(use-package ispell
  :no-require t
  :config
  (setq ispell-dictionary "en")
  (setq ispell-highlight-face (quote flyspell-incorrect))
  (setq ispell-silently-savep t))

(use-package flyspell
  :defer t
  :init
  (progn
    (add-hook 'message-mode-hook 'turn-on-flyspell)
    (add-hook 'org-mode-hook 'flyspell-mode)))

(use-package powerthesaurus
  :defer t)

(use-package denote)
;; Remember to check the doc strings of those variables.
(setq denote-directory (expand-file-name "~/Documents/notes/"))
(setq denote-known-keywords '("emacs" "philosophy" "politics" "economics"))
(setq denote-infer-keywords t)
(setq denote-sort-keywords t)
(setq denote-file-type nil) ; Org is the default, set others here
(setq denote-prompts '(title keywords))
(setq denote-excluded-directories-regexp nil)
(setq denote-excluded-keywords-regexp nil)

;; Pick dates, where relevant, with Org's advanced interface:
(setq denote-date-prompt-use-org-read-date t)


;; Read this manual for how to specify `denote-templates'.  We do not
;; include an example here to avoid potential confusion.


;; We allow multi-word keywords by default.  The author's personal
;; preference is for single-word keywords for a more rigid workflow.
(setq denote-allow-multi-word-keywords t)

(setq denote-date-format nil) ; read doc string

;; By default, we do not show the context of links.  We just display
;; file names.  This provides a more informative view.
(setq denote-backlinks-show-context t)

;; Also see `denote-link-backlinks-display-buffer-action' which is a bit
;; advanced.

;; If you use Markdown or plain text files (Org renders links as buttons
;; right away)
(add-hook 'find-file-hook #'denote-link-buttonize-buffer)

;; We use different ways to specify a path for demo purposes.
(setq denote-dired-directories
      (list denote-directory
            (thread-last denote-directory (expand-file-name "attachments"))
            (expand-file-name "~/Documents/books")))

;; Generic (great if you rename files Denote-style in lots of places):
;; (add-hook 'dired-mode-hook #'denote-dired-mode)
;;
;; OR if only want it in `denote-dired-directories':
(add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)

;; Here is a custom, user-level command from one of the examples we
;; showed in this manual.  We define it here and add it to a key binding
;; below.
(defun my-denote-journal ()
  "Create an entry tagged 'journal', while prompting for a title."
  (interactive)
  (denote
   (denote--title-prompt)
   '("journal")))

;; Denote DOES NOT define any key bindings.  This is for the user to
;; decide.  For example:
(let ((map global-map))
  (define-key map (kbd "C-c n j") #'my-denote-journal) ; our custom command
  (define-key map (kbd "C-c n n") #'denote)
  (define-key map (kbd "C-c n N") #'denote-type)
  (define-key map (kbd "C-c n d") #'denote-date)
  (define-key map (kbd "C-c n s") #'denote-subdirectory)
  (define-key map (kbd "C-c n t") #'denote-template)
  ;; If you intend to use Denote with a variety of file types, it is
  ;; easier to bind the link-related commands to the `global-map', as
  ;; shown here.  Otherwise follow the same pattern for `org-mode-map',
  ;; `markdown-mode-map', and/or `text-mode-map'.
  (define-key map (kbd "C-c n i") #'denote-link) ; "insert" mnemonic
  (define-key map (kbd "C-c n I") #'denote-link-add-links)
  (define-key map (kbd "C-c n b") #'denote-link-backlinks)
  (define-key map (kbd "C-c n f f") #'denote-link-find-file)
  (define-key map (kbd "C-c n f b") #'denote-link-find-backlink)
  ;; Note that `denote-rename-file' can work from any context, not just
  ;; Dired bufffers.  That is why we bind it here to the `global-map'.
  (define-key map (kbd "C-c n r") #'denote-rename-file)
  (define-key map (kbd "C-c n R") #'denote-rename-file-using-front-matter))

;; Key bindings specifically for Dired.
(let ((map dired-mode-map))
  (define-key map (kbd "C-c C-d C-i") #'denote-link-dired-marked-notes)
  (define-key map (kbd "C-c C-d C-r") #'denote-dired-rename-marked-files)
  (define-key map (kbd "C-c C-d C-R") #'denote-dired-rename-marked-files-using-front-matter))

(with-eval-after-load 'org-capture
  (setq denote-org-capture-specifiers "%l\n%i\n%?")
  (add-to-list 'org-capture-templates
               '("n" "New note (with denote.el)" plain
                 (file denote-last-path)
                 #'denote-org-capture
                 :no-save t
                 :immediate-finish nil
                 :kill-buffer t
                 :jump-to-captured t)))

(use-package olivetti
  :hook ((text-mode         . olivetti-mode)
         (prog-mode         . olivetti-mode)
         (Info-mode         . olivetti-mode)
         (org-mode          . olivetti-mode)
         (dashboard-mode    . olivetti-mode)
	 (sdcv-mode         . olivetti-mode)
         (eww-mode          . olivetti-mode)
         (fundamental-mode  . olivetti-mode)
         (nov-mode          . olivetti-mode)
         (markdown-mode     . olivetti-mode)
         (mu4e-view-mode    . olivetti-mode)
         (elfeed-show-mode  . olivetti-mode)
         (mu4e-compose-mode . olivetti-mode))
  :custom
  (olivetti-body-width 0.86)
  :delight " ⊛")
  ; "Ⓐ" "⊗"

(use-package catppuccin-theme
  :config
  (setq catppuccin-flavor 'mocha)
  (load-theme 'catppuccin t))

(use-package beframe)
    ;; This is the default value.  Write here the names of buffers that
    ;; should not be beframed.
    (setq beframe-global-buffers '("*scratch*" "*Messages*" "*Backtrace*"))

    (beframe-mode 1)

    ;; This is just an example.  We do not define any key bindings.  You
    ;; do not need this command if you enable `beframe-mode', as
    ;; `switch-to-buffer' only shows a list of beframed buffers.
    (define-key global-map (kbd "C-x B") #'beframe-switch-buffer)

  (defvar consult-buffer-sources)
(declare-function consult--buffer-state "consult")

(with-eval-after-load 'consult
  (defface beframe-buffer
    '((t :inherit font-lock-string-face))
    "Face for `consult' framed buffers.")

  (defvar beframe--consult-source
    `( :name     "Frame-specific buffers (current frame)"
       :narrow   ?F
       :category buffer
       :face     beframe-buffer
       :history  beframe-history
       :items    ,#'beframe--buffer-names
       :action   ,#'switch-to-buffer
       :state    ,#'consult--buffer-state))

  (add-to-list 'consult-buffer-sources 'beframe--consult-source))

;;; Markdown support
(unless (package-installed-p 'markdown-mode)
  (package-install 'markdown-mode))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump)
         ("C-x C-d" . dired))
  :config
  (define-key dired-mode-map (kbd "q") 'kill-buffer-and-window)
  (define-key dired-mode-map (kbd "l") 'dired-single-buffer)
  (define-key dired-mode-map (kbd "n") 'dired-single-buffer)
  (define-key dired-mode-map (kbd "p") 'dired-single-up-directory)
  (define-key dired-mode-map (kbd "h") 'dired-single-up-directory)
  (define-key dired-mode-map (kbd "j") 'dired-next-line)
  (define-key dired-mode-map (kbd "k") 'dired-previous-line)    
  :custom ((dired-listing-switches "-agho --group-directories-first")))
(setq dired-listing-switches "-alt --dired --group-directories-first -h -G")
(add-hook 'dired-mode-hook 'dired-hide-details-mode)
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode)))

(use-package all-the-icons-dired)

(use-package reddigg
  :config
  (setq reddigg-subs '(bangalore india emacs fossdroid piracy aww)))
(setq org-confirm-elisp-link-function nil)

;; (use-package howdoyou)
(use-package undo-tree
  :init (global-undo-tree-mode t))
(use-package flycheck
  :init (global-flycheck-mode))


(use-package mingus
  :config
  (advice-add 'mingus-playlist-mode :after #'olivetti-mode)
  (advice-add 'mingus-browse-mode :after #'olivetti-mode))
;; (use-package wikinforg)
(use-package 0x0)
(use-package sdcv
  :config
  (setq sdcv-say-word-p t)
  (setq sdcv-dictionary-data-dir "/home/i/.local/share/stardict/") 
  (setq sdcv-dictionary-simple-list   
        '("wn" "enjp" "thesaurus"))
  )
(define-key sdcv-mode-map (kbd "q") #'kill-buffer-and-window)
(define-key sdcv-mode-map (kbd "n") 'sdcv-next-dictionary)
(define-key sdcv-mode-map (kbd "p") 'sdcv-previous-dictionary)
(define-key help-mode-map (kbd "q") #'kill-buffer-and-window)
(define-key sdcv-mode-map (kbd "M-q") 'vterm-send-next-key)

(use-package pdf-tools
  :init
  (pdf-tools-install)
  :config
  (setq pdf-tools-enabled-modes         ; simplified from the defaults
        '(pdf-history-minor-mode
          pdf-isearch-minor-mode
          pdf-links-minor-mode
          pdf-outline-minor-mode
          pdf-misc-size-indication-minor-mode
          pdf-occur-global-minor-mode))
  (setq pdf-view-display-size 'fit-page) ;;fit-height
  (setq pdf-view-continuous t)
  (setq pdf-cache-image-limit 3)
  (setq large-file-warning-threshold 700000000)
  (setq pdf-cache-prefetch-delay 0.5)
  (setq image-cache-eviction-delay 3)
  (setq pdf-annot-activate-created-annotations t)
  (setq pdf-view-use-dedicated-register nil)
  (setq pdf-view-max-image-width 2000)
  (add-hook 'pdf-view-mode-hook (lambda () (cua-mode 0)))
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  (define-key pdf-view-mode-map (kbd "M-g g") 'pdf-view-goto-page)
  (setq pdf-outline-imenu-use-flat-menus t)
  (setq pdf-view-resize-factor 1.1)
  (define-key pdf-view-mode-map (kbd "h") 'pdf-annot-add-highlight-markup-annotation)
  (define-key pdf-view-mode-map (kbd "t") 'pdf-annot-add-text-annotation)
  (define-key pdf-view-mode-map (kbd "D") 'pdf-annot-delete)
  (define-key pdf-view-mode-map (kbd "I") 'pdf-view-midnight-minor-mode)


  (defun d/kill-buffer ()
    "Clear the image cache (to release memory) after killing a pdf buffer."
    (interactive)
    (ido-kill-buffer)
    (delete-window)
    (clear-image-cache t)
    (pdf-cache-clear-data))

  (define-key pdf-view-mode-map (kbd "Q") 'd/kill-buffer))
  (define-key image-mode-map (kbd "q") 'd/kill-buffer)

;; For Comic Manga
(add-hook 'image-mode-hook (lambda ()
                             (olivetti-mode)
                             (setq olivetti-body-width 0.45)))

(defun config-reload ()
  "Uncle dev created a function to reload Emacs config."
  (interactive)
  (load-file (expand-file-name "~/.emacs.d/init.el")))

(defvar d/buffer-url-regexp
  (concat
   "\\b\\(\\(www\\.\\|\\(s?https?\\|ftp\\|file\\|gopher\\|"
   "nntp\\|news\\|telnet\\|wais\\|mailto\\|info\\):\\)"
   "\\(//[-a-z0-9_.]+:[0-9]*\\)?"
   (let ((chars "-a-z0-9_=#$@~%&*+\\/[:word:]")
         (punct "!?:;.,"))
     (concat
      "\\(?:"
      "[" chars punct "]+" "(" "[" chars punct "]+" ")"
      "\\(?:" "[" chars punct "]+" "[" chars "]" "\\)?"
      "\\|"
      "[" chars punct "]+" "[" chars "]"
      "\\)"))
   "\\)")
  "Regular expression that matches URLs.
          Copy of variable `browse-url-button-regexp'.")

(defun d/buffer-links (&optional use-generic-p)
  "Point browser at a URL in the buffer using completion.
          Which web browser to use depends on the value of the variable
          `browse-url-browser-function'.
        Also see `d/print-buffer-links'."
  (interactive "P")
  (let ((matches nil))
    (save-excursion
      (goto-char (point-min))
      (while (search-forward-regexp d/buffer-url-regexp nil t)
        (push (match-string-no-properties 0) matches)))
    (let ((url (completing-read "Browse URL: " matches nil t)))
      (if use-generic-p
          (browse-url-generic url)
        (browse-url url)))))

(defun d/print-buffer-links ()
  "Produce buttonised list of all URLs in the current buffer."
  (interactive)
  (add-hook 'occur-hook #'goto-address-mode)
  (occur d/buffer-url-regexp "\\&")
  (remove-hook 'occur-hook #'goto-address-mode)
  (other-window 1))

;; Bionic Reading

(defvar bionic-reading-face nil "a face for `d/bionic-region'.")

(setq bionic-reading-face 'bold)
;; try
;; 'bold
;; 'error
;; 'warning
;; 'highlight
;; or any value of M-x list-faces-display

(defun d/bionic-read ()
  "Bold the first few chars of every word in current buffer.
      Version 2022-05-21"
  (interactive)
  (read-only-mode -1)
  (d/bionic-region (point-min) (point-max))
  (read-only-mode 1)
  (beginning-of-buffer))

(defun d/bionic-region (Begin End)
  "Bold the first few chars of every word in region.
      Version 2022-05-21"
  (interactive "r")
  (let (xBounds xWordBegin xWordEnd  )
    (save-restriction
      (narrow-to-region Begin End)
      (goto-char (point-min))
      (while (forward-word)
        ;; bold the first half of the word to the left of cursor
        (setq xBounds (bounds-of-thing-at-point 'word))
        (setq xWordBegin (car xBounds))
        (setq xWordEnd (cdr xBounds))
        (setq xBoldEndPos (+ xWordBegin (1+ (/ (- xWordEnd xWordBegin) 2))))
        (put-text-property xWordBegin xBoldEndPos
                           'font-lock-face bionic-reading-face)))))

(use-package elfeed
  :defer t
  :config
  (define-key elfeed-show-mode-map (kbd "e") #'elfeed-open-in-eww)
  (define-key elfeed-show-mode-map (kbd "i") #'d/bionic-read)
  (define-key elfeed-show-mode-map (kbd "r") #'elfeed-open-in-reddit)
  (define-key elfeed-show-mode-map (kbd "m") #'elfeed-toggle-show-star)
  ;; (setq-default elfeed-search-filter "@1-week-ago--1-day-ago +unread -news +")
  (setq-default elfeed-search-filter "+unread -news +")
  (defalias 'elfeed-toggle-show-star
    (elfeed-expose #'elfeed-show-tag 'star))    
  (defalias 'elfeed-toggle-star
    (elfeed-expose #'elfeed-search-toggle-all 'star))

  (eval-after-load 'elfeed-search
    '(define-key elfeed-search-mode-map (kbd "m") 'elfeed-toggle-star))

  ;; face for starred articles
  (defface elfeed-search-star-title-face
    '((t :foreground "#f77"))
    "Marks a starred Elfeed entry.")

  (push '(star elfeed-search-star-title-face) elfeed-search-face-alist))

(use-package link-hint
  :ensure t
  :bind
  ("C-c l o" . link-hint-open-link)
  ("C-c l c" . link-hint-copy-link))

(use-package elfeed-org
  :after elfeed
  :config
  (elfeed-org))

(setq rmh-elfeed-org-files (list "~/.config/emacs/elfeed.org"))

(defun readable-article ()
  (interactive)
  (eww-readable)
  ;; (d/bionic-read)
  (beginning-of-buffer)
  (d/eww-rename-buffer))

(defun elfeed-open-in-eww ()
  "open in eww"
  (interactive)
  (let ((entry (if (eq major-mode 'elfeed-show-mode) elfeed-show-entry (elfeed-search-selected :single))))
    (eww (elfeed-entry-link entry))
    (add-hook 'eww-after-render-hook 'readable-article)))

(defun elfeed-open-in-reddit ()
  "open in reddit"
  (interactive)
  (let ((entry (if (eq major-mode 'elfeed-show-mode) elfeed-show-entry (elfeed-search-selected :single))))
    (reddigg-view-comments (elfeed-entry-link entry))))

(use-package eww
  :config
  (define-key eww-mode-map (kbd "e") #'readable-article)
  (define-key eww-mode-map (kbd "Q") #'d/kill-buffer)
  (define-key eww-mode-map (kbd "M-v") #'d/scroll-up)
  (define-key eww-mode-map (kbd "C-v") #'d/scroll-down)
  (define-key eww-mode-map (kbd "C-f") #'shr-next-link)
  (define-key eww-mode-map (kbd "C-b") #'shr-previous-link)
  (define-key eww-mode-map (kbd "F") #'d/visit-urls)
  (define-key eww-mode-map (kbd "U") #'elfeed-update)
  (define-key eww-mode-map (kbd "j") #'d/external-browser)
  (define-key eww-mode-map (kbd "J") #'d/jump-urls))

(defun d/external-browser ()
  (interactive)
  (link-hint-copy-link)
  (let ((url (current-kill 0)))
    (browse-url-generic url)))

  (defun d/eww-rename-buffer ()
    "Rename EWW buffer using page title or URL.
  To be used by `eww-after-render-hook'."
    (let ((name (if (eq "" (plist-get eww-data :title))
                    (plist-get eww-data :url)
                  (plist-get eww-data :title))))
      (rename-buffer (substring (format "*%s # eww*" name)0 25) t)))

  (add-hook 'eww-after-render-hook #'d/eww-rename-buffer)
  (advice-add 'eww-back-url :after #'d/eww-rename-buffer)
  (advice-add 'eww-forward-url :after #'d/eww-rename-buffer)
  ;; (advice-add 'eww-readable :after #'d/bionic-read)

  (defun d/jump-urls (&optional arg)
    "Jump to URL position on the page using completion.

      When called without ARG (\\[universal-argument]) get URLs only
      from the visible portion of the buffer.  But when ARG is provided
      consider whole buffer."
    (interactive "P")
    (when (derived-mode-p 'eww-mode)
      (let* ((links
              (if arg
                  (d/capture-urls t)
                (d/act-visible
                 (d/capture-urls t))))
             (prompt-scope (if arg
                               (propertize "URL on the page" 'face 'warning)
                             "visible URL"))
             (prompt (format "Jump to %s: " prompt-scope))
             (selection (completing-read prompt links nil t))
             (position (replace-regexp-in-string "^.*(\\([0-9]+\\))[\s\t]+~" "\\1" selection))
             (point (string-to-number position)))
        (goto-char point))))
  (defmacro d/act-visible (&rest body)
    "Run BODY within narrowed-region.
    If region is active run BODY within active region instead.
    Return the value of the last form of BODY."
    `(save-restriction
       (if (use-region-p)
           (narrow-to-region (region-beginning) (region-end))
         (narrow-to-region (window-start) (window-end)))
       ,@body))

  (defun d/capture-urls (&optional position)
    "Capture all the links on the current web page.

    Return a list of strings.  Strings are in the form LABEL @ URL.
    When optional argument POSITION is non-nil, include position info
    in the strings too, so strings take the form
    LABEL @ URL ~ POSITION."
    (let (links match)
      (save-excursion
        (goto-char (point-max))
        ;; NOTE 2021-07-25: The first clause in the `or' is meant to
        ;; address a bug where if a URL is in `point-min' it does not get
        ;; captured.
        (while (setq match (text-property-search-backward 'shr-url))
          (let* ((raw-url (prop-match-value match))
                 (start-point-prop (prop-match-beginning match))
                 (end-point-prop (prop-match-end match))
                 (url (when (stringp raw-url)
                        (propertize raw-url 'face 'link)))
                 (label (replace-regexp-in-string "\n" " " ; NOTE 2021-07-25: newlines break completion
                                                  (buffer-substring-no-properties
                                                   start-point-prop end-point-prop)))
                 (point start-point-prop)
                 (line (line-number-at-pos point t))
                 (column (save-excursion (goto-char point) (current-column)))
                 (coordinates (propertize
                               (format "%d,%d (%d)" line column point)
                               'face 'shadow)))
            (when url
              (if position
                  (push (format "%-15s ~ %s  @ %s"
                                coordinates label url)
                        links)
                (push (format "%s  @ %s"
                              label url)
                      links))))))
      links))



  (defun d/visit-urls (&optional arg)
    "Visit URL from list of links on the page using completion.

    With optional prefix ARG (\\[universal-argument]) open URL in a
    new EWW buffer."
    (interactive "P")
    (when (derived-mode-p 'eww-mode)
      (let* ((links (d/capture-urls))
             (selection (completing-read "Go To URL from page: " links nil t))
             (url (replace-regexp-in-string ".*@ " "" selection)))
        (browse-url-generic url (when arg 4)))))

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
;; (set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

(setq-default mode-line-format nil)

;; (server-start)

(setq use-dialog-box nil)
(setq sentence-end-double-space nil)
(setq inhibit-startup-screen t)
(setq initial-scratch-message
      ";; Type to your Will !.\n")
(setq frame-inhibit-implied-resize t)
;;(global-prettify-symbols-mode t)

;; tabs
(setq tab-bar-new-tab-choice "*scratch")
(setq tab-bar-close-button-show nil
      tab-bar-new-button-show nil)

;; Set up the visible bell
(setq visible-bell nil)
(setq x-select-request-type 'text/plain\;charset=utf-8)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(electric-pair-mode 1)
(setq recenter-positions '(top middle bottom))
(global-display-line-numbers-mode t)
(setq  display-line-numbers-type 'relative)
(setq text-scale-mode-step 1.05)
(setq frame-resize-pixelwise t)
(global-hl-line-mode 1)
(column-number-mode -1)
(line-number-mode -1)
(delete-selection-mode +1)
(save-place-mode +1)
;;(display-battery-mode t)
;;(setq display-time;5;9~-default-load-average nil)
;;(setq display-time-24hr-format t)
;;(setq display-time-format "%H:%M")
;;(display-time-mode t)
;;(toggle-truncate-lines t)
(setq
 shr-use-fonts  nil                          ; No special fonts
 shr-use-colors nil                          ; No colours
 shr-indentation 4                           ; Left-side margin
 shr-width 90                                ; Fold text to 70 columns
 eww-search-prefix "https://lite.duckduckgo.com/lite/?q=")

;; Set frame transparency
(set-frame-parameter (selected-frame) 'alpha-background 52)
(add-to-list 'default-frame-alist `(alpha-background . 52))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                vterm-mode-hook
                term-mode-hook
                shell-mode-hook
                olivetti-mode-hook
                treemacs-mode-hook
                pdf-view-mode-hook
                archive-mode-hook
                image-mode-hook
                elfeed-show-mode-hook
                elfeed-search-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(global-unset-key (kbd "C-x C-z"))
(global-unset-key (kbd "C-z"))

;;; Scrolling

(setq hscroll-margin 2
      hscroll-step 1
     scroll-conservatively 101
      scroll-margin 0
      scroll-preserve-screen-position t
     auto-window-vscroll nil
     mouse-wheel-scroll-amount '(2 ((shift) . hscroll))
      mouse-wheel-scroll-amount-horizontal 2)

;;; Cursor
(blink-cursor-mode -1)

;; Don't blink the paren matching the one at point, it's too distracting.
(setq blink-matching-paren nil)

;; Don't stretch the cursor to fit wide characters, it is disorienting,
;; especially for tabs.
(setq x-stretch-cursor nil)

;; A simple frame title
(setq frame-title-format '("%b")
      icon-title-format frame-title-format)

;; Don't resize the frames in steps; it looks weird, especially in tiling window
;; managers, where it can leave unseemly gaps.
(setq frame-resize-pixelwise t)
(setq pixel-dead-time 10000)

;; But do not resize windows pixelwise, this can cause crashes in some cases
;; when resizing too many windows at once or rapidly.
(setq window-resize-pixelwise nil)
(pixel-scroll-precision-mode 1)

;; Favor vertical splits over horizontal ones. Monitors are trending toward
;; wide, rather than tall.
(setq split-width-threshold 160
      split-height-threshold nil)

(setq-default fill-column 80)

(defun set-font-faces ()
  (message "Setting faces!")
  (set-face-attribute 'default nil :font "ComicCodeLigatures" :height default-font-size)

  ;; Set the fixed pitch face
  (set-face-attribute 'fixed-pitch nil :font "ComicCodeLigatures" :height default-font-size)

  ;; Set the variable pitch face
  (set-face-attribute 'variable-pitch nil :font "ComicCodeLigatures" :height default-variable-font-size :weight 'regular))
(set-face-attribute 'corfu-border nil  :background "#bcd2ee")
(setq doom-modeline-icon t)
(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                ;; (setq doom-modeline-icon t)
                (with-selected-frame frame
                  (set-font-faces))))
    (set-font-faces))
(put 'narrow-to-region 'disabled nil)
