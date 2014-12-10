;; (add-to-list 'load-path "~/.emacs.d/git-emacs")  ; or your installation path

;;(yas/global-mode 1)

(autoload 'window-number-mode "window-number"
  "A global minor mode that enables selection of windows according to
numbers with the C-x C-j prefix.  Another mode,
`window-number-meta-mode' enables the use of the M- prefix."
  t)

(autoload 'window-number-meta-mode "window-number"
  "A global minor mode that enables use of the M- prefix to select
windows, use `window-number-mode' to display the window numbers in
the mode-line."
  t)
(setq-default indent-tabs-mode nil)
(setq visible-bell t)
(setq inhibit-startup-message t)
(window-number-mode 1)
(hl-line-mode t)
(window-number-meta-mode 1)
(prefer-coding-system 'utf-8)
(setq ring-bell-function 'ignore)                       ; 无闪屏
;; (setq debug-on-error t) 				; 报告错误
(setq backup-inhibited t) 				; 不产生备份
;;(require 'hl-line)					; 高亮当前行
;;(global-hl-line-mode t)
(define-key global-map "\C-c\C-g" 'goto-line) 		; 设置跳转快捷键
(setq auto-save-default nil) 				; 不生成名为#filename# 的临时文件

(mouse-avoidance-mode 'animate)				; 光标靠近鼠标指针时，让鼠标指针自动让开
(setq mouse-yank-at-point t)				; 支持中键粘贴
(global-cwarn-mode 1) 					; 高亮显示C/C++中的可能的错误(CWarn mode)
(setq initial-scratch-message ";; Abandon hope all ye who enter here\n") ;设置scratch的欢迎文字
(global-set-key [(f1)] 'speedbar) 			; 开启speedbar
(setq default-directory "~/Code")			; 设置打开时的默认路径
(setq inhibit-startup-message t) 			; 去掉欢迎界面
(global-set-key [C-tab] 'other-window) 			; 切换到另一个窗口，快捷键为C+Tab
(setq-default make-backup-files nil) 			; 不要生成备份文件
(setq default-directory "~/Code")			; 设置打开时的默认路径
(global-set-key [f9] 'compile) 				; compile 一键
;; (recentf-mode t)					; 设置最近打开的文件
(global-set-key (kbd "C-c d") 'delete-region)		; delete-region
(add-hook 'c-mode-common-hook 'hs-minor-mode)		; 代码折叠

;;设置TODO
(global-set-key(kbd "<f11>") 'todo-show) 		 ;F11设置为添加新的item

;; 设置shell
(ansi-color-for-comint-mode-on)

;; 显示行号
(require 'linum)
(setq linum-format "%3d ")

;对所有文件生效
(add-hook 'find-file-hooks (lambda () (linum-mode 1)))

(setq-default cursor-type 'box ); 设置光标为方块
 (setq user-full-name "samael") 
 (setq user-mail-address "samael.65535@gmail.com")


;; 加载clang  
(require 'auto-complete-clang)  
  
;; 添加c-mode和c++-mode的hook，开启auto-complete的clang扩展  
(defun wttr/ac-cc-mode-setup ()  
  (make-local-variable 'ac-auto-start)  
  (setq ac-auto-start nil)              ;auto complete using clang is CPU sensitive  
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))  
(add-hook 'c-mode-hook 'wttr/ac-cc-mode-setup)  
(add-hook 'c++-mode-hook 'wttr/ac-cc-mode-setup)
(setq ac-clang-flags  (list   
 "/usr/include/c++/4.2.1 "
 "/usr/include/c++/4.2.1/backward"
 "/usr/local/include" 
 "/usr/include"
))

(set-frame-font "Monaco-13")
(set-fontset-font "fontset-default" 'han '("STHeiti" . "unicode-bmp"))

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'insert-tab)
(setq js2-mode-hook
  '(lambda () (progn
    (set-variable 'indent-tabs-mode nil))))

(require `multi-term)
(setq multi-term-program "/bin/zsh")
;;; 在org-mode时加载 export markdown
(eval-after-load "org"
  '(require 'ox-md nil t))

(defun org-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite")))
     (list (ido-completing-read "Source code type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "#+BEGIN_SRC %s\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code)))

(add-hook 'org-mode-hook '(lambda ()
                            ;; turn on flyspell-mode by default
                            (flyspell-mode 1)
                            ;; keybinding for editing source code blocks
                            (local-set-key (kbd "C-c s e")
                                           'org-edit-src-code)
                            ;; keybinding for inserting code blocks
                            (local-set-key (kbd "C-c s i")
                                           'org-insert-src-block)
                            ))
(provide 'init-samael)

