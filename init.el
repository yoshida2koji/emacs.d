;; 起動画面を表示しない
(setq inhibit-startup-screen t)
;; ツールバーを非表示
(tool-bar-mode 0)
;; スクロールバーを非表示
(scroll-bar-mode 0)
;; カーソルのある行をハイライト
(global-hl-line-mode 1)
;; 起動時の位置とサイズ
(setq initial-frame-alist
      '((top . 25) (left . 0) (width . 317) (height . 55)
        (font . "-GOOG-Noto Sans Mono CJK JP-normal-normal-normal-*-*-94-*-*-*-0-iso10646-1")))
;; ウィンドウ移動
(global-set-key (kbd "C-t") 'other-window)
(global-set-key (kbd "M-t") (lambda () (interactive) (other-window -1)))
;; C-hでカーソル左を削除
(define-key key-translation-map [?\C-h] [?\C-?])
;; 代わりのヘルプの割当
(global-set-key (kbd "M-h") 'help-for-help)
;; 履歴保存
(savehist-mode 1)

(setq-default tab-width 4 indent-tabs-mode nil)

;; leaf
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf)))

(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))

(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

(leaf dired
  :bind (dired-mode-map
	 ("C-t". other-window)))

(leaf ido
  :ensure t
  :global-minor-mode fido-vertical-mode)

(leaf recentf
  :ensure t
  :global-minor-mode recentf-mode
  :bind (("C-x C-r" . recentf-open-files)))

(leaf paredit
  :ensure t
  :hook ((emacs-lisp-mode-hook 'paredit-mode)
	 (sly-mrepl-mode-hook 'paredit-mode)
	 (lisp-mode-hook 'paredit-mode)))

(leaf sly
  :ensure t
  :custom ((inferior-lisp-program . "ros -Q run")))

(leaf sly-mrepl
  :after sly
  :advice (:around paredit-RET (lambda (org-fn &rest args)
				 (if (string-prefix-p "*sly-mrepl for" (buffer-name (current-buffer)))
				     (sly-mrepl-return)
				   (apply org-fn args)))))

(leaf which-key
  :ensure t
  :global-minor-mode which-key-mode)

(leaf flycheck
  :ensure t
  :hook ((c-mode-hook . flycheck-mode)))

(leaf company
  :ensure t
  :custom ((company-idle-delay . nil))
  :bind (("C-SPC" . company-complete)
	 ("C-M-i" . company-complete))
  :global-minor-mode global-company-mode)

(leaf magit
  :ensure t)

(leaf imenu-list
  :bind (("<f10>" . imenu-list-smart-toggle))
  :custom ((imenu-list-focus-after-activation . t)))

(leaf projectile
  :ensure t
  :global-minor-mode projectile-mode
  :custom ((projectile-project-search-path '("~/")))
  :bind ((projectile-mode-map
	  ("C-c p" . 'projectile-command-map))))

(leaf neotree
  :ensure t
  :bind (("<f9>" . neotree-toggle)))

(leaf cua
  :custom ((cua-enable-cua-keys . nil))
  :global-minor-mode cua-mode)

(leaf rg
  :ensure t
  :bind (("C-M-g" . 'rg)))


;; テーマ
(leaf modus-themes
  :ensure t
  :commands modus-themes-load-theme
  :init
  (modus-themes-load-theme 'modus-vivendi-tinted))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(leaf)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
