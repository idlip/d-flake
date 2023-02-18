;; You will most likely need to adjust this font size for your system!
(defvar default-font-size 190)
(defvar default-variable-font-size 190)
(setf use-default-font-for-symbols nil)
(set-fontset-font t 'unicode "Noto Emoji" nil 'append)

;; Make frame transparency overridable
(defvar frame-transparency '(90 . 90))

;; from early init
(setq gc-cons-threshold most-positive-fixnum)
(setq load-prefer-newer noninteractive)

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(defun display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'display-startup-time)

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

;; (use-package dashboard
;;   :ensure t
;;   :init      ;; tweak dashboard config before loading it
;;   (setq dashboard-set-heading-icons t)
;;   (setq dashboard-set-file-icons t)
;;   (setq dashboard-image-banner-max-height 200)
;;   (setq dashboard-startup-banner "~/.emacs.d/etc/banners/eMacs.webp")
;;   (setq dashboard-banner-logo-title "Am just Learning most of the time, 🔱 now its another new thing!")
;;   (setq dashboard-center-content t) ;; set to 't' for centered content
;;   (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))) 
;;   (setq dashboard-items '((recents . 5)
;;                           ;;                            (agenda . 2 )
;;                           (bookmarks . 5)))

;;   :config
;;   (dashboard-setup-startup-hook)
;;   (dashboard-modify-heading-icons '((recents . "file-text")
;;                                     (bookmarks . "book"))))

;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading no-littering!
                                        ;(setq user-emacs-directory "~/.cache/emacs")
(use-package no-littering)

;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))

(defun d/scroll-down ()
       (interactive)
       (pixel-scroll-precision-scroll-down 40))

(defun d/scroll-up ()
       (interactive)
       (pixel-scroll-precision-scroll-up 40))

(global-set-key (kbd "M-v") #'d/scroll-up)
(global-set-key (kbd "C-v") #'d/scroll-down)

(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(defun window-focus-mode ()
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_)
    (progn
      (set-register '_ (list (current-window-configuration)))
      (delete-other-windows))))

(global-set-key (kbd "C-c f") 'window-focus-mode)
(global-set-key (kbd "C-M-r") 'undo-redo)
(global-set-key (kbd "M-j") 'avy-goto-char-timer)
(global-set-key (kbd "M-K") 'avy-kill-region)
(global-set-key (kbd "C-x C-k") 'd/kill-buffer)
(global-set-key (kbd "C-x k") 'd/kill-buffer)
(global-set-key (kbd "M-%") 'query-replace-regexp)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(defalias 'yes-or-no-p 'y-or-n-p)

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
  "te" '(insert-char :which-key "unicodes")
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
  "wh" '(evil-window-down :which-key "down window")
  "w c"   '(evil-window-delete :which-key "Close window")
  "w n"   '(evil-window-new :which-key "New window")
  "w s"   '(evil-window-split :which-key "Horizontal split window")
  "w v"   '(evil-window-vsplit :which-key "Vertical split window")
  "wj" '(evil-window-left :which-key "left window")
  "wk" '(evil-window-up :which-key "up window")
  "wl" '(evil-window-right :which-key "right window")
  "wq" '(d/kill-buffer :which-key "close buffer")
  "ww" '(evil-window-next :which-key "next window")

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

  "`" '(insert-char :which-key "Insert Char/Emoji")
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
  "fce" '(lambda () (interactive) (find-file (expand-file-name "~/.emacs.d/config.org"))))

;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   ;; (load-theme 'doom-gruvbox t)

;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
;;   ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
;;   (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))



(use-package all-the-icons)

 ;; (use-package doom-modeline
 ;;   :init (doom-modeline-mode 1)
 ;;   (setq doom-modeline-time-icon nil)
 ;;   (setq doom-modeline-bar-width 3)
 ;;   (setq doom-modeline-major-mode-icon t)
 ;;   :custom ((doom-modeline-height 10)
 ;;            (doom-modeline-buffer-encoding nil)))

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

;;(use-package vertico-posframe)
;;  (require 'vertico-posframe)
;;
;;  (setq vertico-multiform-commands
;;      '((consult-line
;;         posframe
;;         (vertico-posframe-poshandler . posframe-poshandler-frame-top-center)
;;         (vertico-posframe-border-width . 10)
;;         ;; NOTE: This is useful when emacs is used in both in X and
;;         ;; terminal, for posframe do not work well in terminal, so
;;         ;; vertico-buffer-mode will be used as fallback at the
;;         ;; moment.
;;         (vertico-posframe-fallback-mode . vertico-buffer-mode))
;;        (t posframe)))
;;(setq vertico-posframe-parameters
;;    '((left-fringe . 8)
;;      (right-fringe . 8)))
;;(setq vertico-multiform-commands
;;    '((consult-line (:not posframe))
;;      (t posframe)))
;;(vertico-multiform-mode 1)

(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount nil)
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package rainbow-mode
  :init (add-hook 'prog-mode-hook 'rainbow-mode))

;; Enable vertico
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

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

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
         ("M-s g" . consult-grep)
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
  (add-to-list 'org-structure-template-alist '("lx" . "src latex"))
  (add-to-list 'org-structure-template-alist '("cal" . "src calc")))

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
  ;; (modify-all-frames-parameters
  ;;  '((right-divider-width . 15)
  ;;    (internal-border-width . 15)))
  ;; (dolist (face '(window-divider
  ;;                 window-divider-first-pixel
  ;;                 window-divider-last-pixel))
  ;;   (face-spec-reset-face face)
  ;;   (set-face-foreground face (face-attribute 'default :background)))

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
  ;; (add-to-list 'completion-at-point-functions #'cape-dict)
  ;; (add-to-list 'completion-at-point-functions #'cape-symbol)
  ;; (add-to-list 'completion-at-point-functions #'cape-line)
  )

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

;;; Markdown support
(unless (package-installed-p 'markdown-mode)
  (package-install 'markdown-mode))
(setq markdown-command 
    "/nix/store/ynskha10xj4gydnhii1wza0ar15x7mvx-pandoc-2.19.2/bin/pandoc -f markdown -t html -s --mathjax --highlight-style=pygments")

;; (use-package org-auto-tangle
;;   :defer t
;;   :hook (org-mode . org-auto-tangle-mode)
;;   :config
;;   (setq org-auto-tangle-default t))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump)
         ("C-x C-d" . dired))
  :config
  (define-key dired-mode-map (kbd "q") 'kill-buffer-and-window)
  :custom ((dired-listing-switches "-agho --group-directories-first")))

(use-package dired-single
  :commands (dired dired-jump)
  :config
  (define-key dired-mode-map (kbd "l") 'dired-single-buffer)
  (define-key dired-mode-map (kbd "h") 'dired-single-up-directory))

(use-package async
  :ensure t
  :init (dired-async-mode 1))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :commands (dired dired-jump)
  :config
  ;; Doesn't work as expected!
  ;; (add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "sxiv")("jpeg" . "sxiv")("jpg" . "sxiv")
                                ("pdf" . "sioyek") ("cbz" . "sioyek") ("epub" . "sioyek") ("zip" . "sioyek") ("html" . "w3m") ("webm" . "mpv") ("mp4" . "mpv") ("mkv" . "mpv")("m4a" . "mpv")("mp3" . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode))

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
  (define-key image-mode-map (kbd "Q") 'd/kill-buffer)

;; For Comic Manga
(add-hook 'image-mode-hook (lambda ()
                             (olivetti-mode)
                             (setq olivetti-body-width 0.45)))

;;(use-package mu4e
;;  :ensure t
;;  :config
;;
;;  ;; This is set to 't' to avoid mail syncing issues when using mbsync
;;  (setq mu4e-change-filenames-when-moving t)
;;  (setq message-send-mail-function 'smtpmail-send-it)
;;  (setq mu4e-compose-context-policy 'ask-if-none)
;;  (setq mu4e-compose-format-flowed t)
;;
;;  ;; Refresh mail using isync every 10 minutes
;;  (setq mu4e-update-interval (* 10 60))
;;  (setq mu4e-get-mail-command "mbsync -a")
;;  (setq mu4e-maildir "~/.local/share/mail")
;;
;;  (setq mu4e-contexts
;;        (list
;;         ;; Class account
;;         (make-mu4e-context
;;          :name "Class"
;;          :match-func
;;          (lambda (msg)
;;            (when msg
;;              (string-prefix-p "/d15" (mu4e-message-field msg :maildir))))
;;          :vars '((user-mail-address . "dilipg.s1913815@gmail.com")
;;                  (user-full-name    . "Dilip")
;;                  (mu4e-compose-signature . "Regards,\n - Dilip")
;;                  (smtpmail-smtp-server  . "smtp.gmail.com")
;;                  (smtpmail-smtp-service . 465)
;;                  (smtpmail-stream-type  . ssl)
;;                  (mu4e-drafts-folder  . "/d15[Gmail]/Drafts")
;;                  (mu4e-sent-folder  . "/d15[Gmail]/Sent Mail")
;;                  (mu4e-refile-folder  . "/d15[Gmail]/All Mail")
;;                  (mu4e-trash-folder  . "/d15[Gmail]/Trash")))
;;
;;         ;; Games account
;;         (make-mu4e-context
;;          :name "Gaming"
;;          :match-func
;;          (lambda (msg)
;;            (when msg
;;              (string-prefix-p "/imd" (mu4e-message-field msg :maildir))))
;;          :vars '((user-mail-address . "imthedilip@gmail.com")
;;                  (user-full-name    . "Dilip")
;;                  (mu4e-compose-signature . "Regards,\n - Dilip")
;;                  (smtpmail-smtp-server  . "smtp.gmail.com")
;;                  (smtpmail-smtp-service . 465)
;;                  (smtpmail-stream-type  . ssl)
;;                  (mu4e-drafts-folder  . "/imd[Gmail]/Drafts")
;;                  (mu4e-sent-folder  . "/imd[Gmail]/Sent Mail")
;;                  (mu4e-refile-folder  . "/imd[Gmail]/All Mail")
;;                  (mu4e-trash-folder  . "/imd[Gmail]/Trash")))
;;
;;         ;; Personal account
;;         (make-mu4e-context
;;          :name "Personal"
;;          :match-func
;;          (lambda (msg)
;;            (when msg
;;              (string-prefix-p "/gdk" (mu4e-message-field msg :maildir))))
;;          :vars '((user-mail-address . "igoldlip@gmail.com")
;;                  (user-full-name    . "Dilip")
;;                  (mu4e-compose-signature . "Regards,\n - Dilip")
;;                  (smtpmail-smtp-server  . "smtp.gmail.com")
;;                  (smtpmail-smtp-service . 465)
;;                  (smtpmail-stream-type  . ssl)
;;                  (mu4e-drafts-folder  . "/gdk[Gmail]/Drafts")
;;                  (mu4e-sent-folder  . "/gdk[Gmail]/Sent")
;;                  (mu4e-refile-folder  . "/gdk[Gmail]/Archive")
;;                  (mu4e-trash-folder  . "/gdk[Gmail]/Trash")))))
;;
;;
;;  (setq mu4e-maildir-shortcuts
;;        '((:maildir "/d15/Inbox"    :key ?q)
;;          (:maildir "/imd/Inbox"    :key ?w)
;;          (:maildir "/gdk/Inbox"    :key ?e)
;;          (:maildir "/d15[Gmail]/Sent Mail" :key ?a)
;;          (:maildir "/imd[Gmail]/Sent Mail" :key ?s)
;;          (:maildir "/gdk[Gmail]/Sent Mail" :key ?d)
;;          ;; (:maildir "/d15[Gmail]/Trash"     :key ?t)
;;          ;; (:maildir "/d15[Gmail]/Drafts"    :key ?d)
;;          (:maildir "/d15[Gmail]/All Mail"  :key ?z)
;;          (:maildir "/imd[Gmail]/All Mail"  :key ?x)
;;          (:maildir "/gdk[Gmail]/All Mail"  :key ?c))))

;; (use-package org-mime
;;   :ensure t
;;   :config
;;   (setq org-mime-export-options '(:section-numbers nil
;;                                                    :with-author nil
;;                                                    :with-toc nil))
;;   (add-hook 'org-mime-html-hook
;;             (lambda ()
;;               (org-mime-change-element-style
;;                "pre" (format "color: %s; background-color: %s; padding: 0.5em;"
;;                              "#E6E1DC" "#232323"))))
;;   (add-hook 'message-send-hook 'org-mime-htmlize))

;; (require 'mu4e-org)

;; (defun efs/capture-mail-follow-up (msg)
;;   (interactive)
;;   (call-interactively 'org-store-link)
;;   (org-capture nil "mf"))

;; (defun efs/capture-mail-read-later (msg)
;;   (interactive)
;;   (call-interactively 'org-store-link)
;;   (org-capture nil "mr"))


;; (defun efs/store-link-to-mu4e-query ()
;;   (interactive)
;;   (let ((org-mu4e-link-query-in-headers-mode t))
;;     (call-interactively 'org-store-link)))

;; ;; Add custom actions for our capture templates
;; (add-to-list 'mu4e-headers-actions
;;              '("follow up" . efs/capture-mail-follow-up) t)
;; (add-to-list 'mu4e-view-actions
;;              '("follow up" . efs/capture-mail-follow-up) t)
;; (add-to-list 'mu4e-headers-actions
;;              '("read later" . efs/capture-mail-read-later) t)
;; (add-to-list 'mu4e-view-actions
;;              '("read later" . efs/capture-mail-read-later) t)

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

;; Realod config
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

;; (use-package wikinforg)
(use-package 0x0)
(use-package sdcv
  :config
  (setq sdcv-say-word-p t)
  (setq sdcv-dictionary-data-dir "/home/i/.local/share/stardict/") 
  (setq sdcv-dictionary-simple-list   
        '("wn"
          "enjp"))
  )
(define-key sdcv-mode-map (kbd "q") #'kill-buffer-and-window)
(define-key help-mode-map (kbd "q") #'kill-buffer-and-window)

;;    (use-package expenses
;;      :ensure t
;;      :config
;;      (setq expenses-directory "~/test1/ledger")
;;      (setq expenses-currency "Rs.")
;;    (setq expenses-category-list '("Bike" "Clothes"  "Electronics" "Entertainment" "Fee" "Food" "Gift" "Medicine" "Home" "Petrol" "Other" "Sport" "Subscriptions" "Travel" "Transfer" "Utilities"
;; "Dmart" "Shopping"))
;;    )

(use-package elfeed
  :defer t
  :config
  (define-key elfeed-show-mode-map (kbd "e") #'elfeed-open-in-eww)
  (define-key elfeed-show-mode-map (kbd "i") #'d/bionic-read)
  (define-key elfeed-show-mode-map (kbd "r") #'elfeed-open-in-reddit)
  (define-key elfeed-show-mode-map (kbd "m") #'elfeed-toggle-show-star)
  (setq-default elfeed-search-filter "@1-week-ago--1-day-ago +unread -news +")
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
  (define-key eww-mode-map (kbd "F") #'d/visit-urls)
  (define-key eww-mode-map (kbd "U") #'elfeed-update)
  (define-key eww-mode-map (kbd "j") #'d/external-browser)
  (define-key eww-mode-map (kbd "J") #'d/jump-urls))

  ;; Cool hacks

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

;; ;; NOTE: init.el is now generated from Emacs.org.  Please edit that file
;; ;;       in Emacs and init.el will be generated automatically!
;; (use-package exwm)
;; (require 'exwm)
;; (require 'exwm-config)
;; ;; (exwm-config-ido)
;; (setq exwm-workspace-number 5)
;; (add-hook 'exwm-update-class-hook
;;           (lambda ()
;;             (unless (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
;;                         (string= "gimp" exwm-instance-name))
;;               (exwm-workspace-rename-buffer exwm-class-name))))
;; (add-hook 'exwm-update-title-hook
;;           (lambda ()
;;             (when (or (not exwm-instance-name)
;;                       (string-prefix-p "sun-awt-X11-" exwm-instance-name)
;;                       (string= "gimp" exwm-instance-name))
;;               (exwm-workspace-rename-buffer exwm-title))))
;; (defun efs/exwm-init-hook ()
;;   ;; Make workspace 1 be the one where we land at startup
;;   (exwm-workspace-switch-create 1))


;; (defun efs/exwm-update-class ()
;;   (exwm-workspace-rename-buffer exwm-class-name))

;; (defun efs/exwm-update-title ()
;;   (pcase exwm-class-name
;;     ("firefox" (exwm-workspace-rename-buffer (substring (format "%s" exwm-title)0 15)))))

;; ;; This function isn't currently used, only serves as an example how to
;; ;; position a window
;; (defun efs/position-window ()
;;   (let* ((pos (frame-position))
;;          (pos-x (car pos))
;;          (pos-y (cdr pos)))

;;     (exwm-floating-move (- pos-x) (- pos-y))))

;; (defun efs/configure-window-by-class ()
;;   (interactive)
;;   (pcase exwm-class-name
;;     ("Mozilla Firefox" (exwm-workspace-move-window 3))
;;     ("mpv" (exwm-floating-toggle-floating)
;;      (exwm-layout-toggle-mode-line))))

;; ;; When window "class" updates, use it to set the buffer name
;; (add-hook 'exwm-update-class-hook #'efs/exwm-update-class)

;; ;; When window title updates, use it to set the buffer name
;; (add-hook 'exwm-update-title-hook #'efs/exwm-update-title)

;; ;; Configure windows as they're created
;; (add-hook 'exwm-manage-finish-hook #'efs/configure-window-by-class)

;; (add-hook 'exwm-init-hook #'efs/exwm-init-hook)

;; ;; Automatically move EXWM buffer to current workspace when selected
;; (setq exwm-layout-show-all-buffers t)

;; ;; Display all EXWM buffers in every workspace buffer list
;; (setq exwm-workspace-show-all-buffers t)

;; ;; NOTE: Uncomment this option if you want to detach the minibuffer!
;; ;; Detach the minibuffer (show it with exwm-workspace-toggle-minibuffer)
;; ;; (setq exwm-workspace-minibuffer-position 'top)
;; ;; (setq exwm-workspace-warp-cursor t)
;; ;; Window focus should follow the mouse pointer
;; ;; (setq mouse-autoselect-window t
;;       ;; focus-follows-mouse t)

;; ;; Global keybindings can be defined with `exwm-input-global-keys'.
;; ;; Here are a few examples:
;; (setq exwm-input-global-keys
;;       `(
;;         ;; Bind "s-r" to exit char-mode and fullscreen mode.
;;         ([?\s-r] . exwm-reset)
;;         ([?\s-Q] . ido-kill-buffer)
;;         ;; Bind "s-w" to switch workspace interactively.
;;         ([?\s-w] . exwm-workspace-switch)
;;         ([?\s-k] . windmove-up)
;;         ([?\s-j] . windmove-down)
;;         ([?\s-h] . windmove-left)
;;         ([?\s-l] . windmove-right)
;;         ;; Bind "s-0" to "s-9" to switch to a workspace by its index.
;;         ,@(mapcar (lambda (i)
;;                     `(,(kbd (format "s-%d" i)) .
;;                       (lambda ()
;;                         (interactive)
;;                         (exwm-workspace-switch-create ,i))))
;;                   (number-sequence 0 9))
;;         ;; Bind "s-&" to launch applications ('M-&' also works if the output
;;         ;; buffer does not bother you).
;;         ([?\s-&] . (lambda (command)
;;                      (interactive (list (read-shell-command "$ ")))
;;                      (start-process-shell-command command nil command)))
;;         ;; Bind "s-<f2>" to "slock", a simple X display locker.
;;         ([s-f2] . (lambda ()
;;                     (interactive)
;;                     (start-process "" nil "/usr/bin/slock")))))

;; ;; To add a key binding only available in line-mode, simply define it in
;; ;; `exwm-mode-map'.  The following example shortens 'C-c q' to 'C-q'.
;; (define-key exwm-mode-map [?\C-q] #'exwm-input-send-next-key)

;; ;; The following example demonstrates how to use simulation keys to mimic
;; ;; the behavior of Emacs.  The value of `exwm-input-simulation-keys` is a
;; ;; list of cons cells (SRC . DEST), where SRC is the key sequence you press
;; ;; and DEST is what EXWM actually sends to application.  Note that both SRC
;; ;; and DEST should be key sequences (vector or string).
;; (setq exwm-input-simulation-keys
;;       '(
;;         ;; movement
;;         ([?\C-b] . [left])
;;         ([?\M-b] . [C-left])
;;         ([?\C-f] . [right])
;;         ([?\M-f] . [C-right])
;;         ([?\C-p] . [up])
;;         ([?\C-n] . [down])
;;         ([?\C-a] . [home])
;;         ([?\C-e] . [end])
;;         ([?\M-v] . [prior])
;;         ([?\C-v] . [next])
;;         ([?\C-d] . [delete])
;;         ([?\C-k] . [S-end delete])
;;         ;; cut/paste.
;;         ([?\C-w] . [?\C-x])
;;         ([?\M-w] . [?\C-c])
;;         ([?\C-y] . [?\C-v])
;;         ;; search
;;         ([?\C-s] . [?\C-f])))

;; (defun float-this-wind ()
;;   (interactive)
;;   (exwm-floating-toggle-floating)
;;   (exwm-layout-toggle-mode-line))

;; (exwm-input-set-key (kbd "s-SPC") 'float-this-wind)
;; (exwm-input-set-key (kbd "s-f") 'exwm-layout-toggle-fullscreen)
;; (exwm-input-set-key (kbd "s-<tab>") 'switch-to-next-buffer)

;; (exwm-enable)

;; (scroll-bar-mode -1)

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
;; (set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

(setq-default mode-line-format nil)

;; (server-start)

(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq frame-inhibit-implied-resize t)
;;(global-prettify-symbols-mode t)

;; tabs
(setq tab-bar-new-tab-choice "*scratch")
(setq tab-bar-close-button-show nil
      tab-bar-new-button-show nil)

;; Set up the visible bell
(setq visible-bell nil)
(setq x-select-request-type 'text/plain\;charset=utf-8)
(electric-pair-mode 1)

(global-display-line-numbers-mode t)
(setq  display-line-numbers-type 'relative)
(setq text-scale-mode-step 1.05)
(setq frame-resize-pixelwise t)
(global-hl-line-mode 1)
(column-number-mode -1)
(line-number-mode -1)
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
(set-frame-parameter (selected-frame) 'alpha-background 92)
(add-to-list 'default-frame-alist `(alpha-background . 92))
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


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(catppuccin-theme catppuccin vterm undo-tree flycheck no-littering doom-themes modus-themes vertico-posframe rainbow-delimiters rainbow-mode orderless marginalia embark-consult olivetti org-modern corfu cape markdown-mode nix-mode all-the-icons-dired dired-hide-dotfiles dired-single reddigg mingus pdf-tools which-key org-mime sdcv elfeed-org link-hint general doom-modeline org-auto-tangle dired-open howdoyou wikinforg 0x0)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
