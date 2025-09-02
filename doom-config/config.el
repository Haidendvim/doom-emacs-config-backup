;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Claude Code
(use-package! claude-code-ide
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :config
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; C/C++ Configuration
(after! cc-mode
  (setq c-basic-offset 4
        c-default-style "linux"))

;; LSP Configuration for C/C++
(after! lsp-mode
  (setq lsp-clients-clangd-args '("--header-insertion=never"
                                  "--clang-tidy"
                                  "--completion-style=detailed"))
  ;; Enable inlay hints for better code understanding
  (setq lsp-inlay-hint-enable t))

;; DAP (Debug Adapter Protocol) Configuration for C/C++
(after! dap-mode
  ;; Enable DAP for C/C++
  (require 'dap-lldb)
  (require 'dap-gdb-lldb)
  
  ;; Configure LLDB for macOS
  (setq dap-lldb-debug-program "/opt/homebrew/opt/llvm/bin/lldb-dap")
  
  ;; Enable DAP UI components
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  
  ;; Template for C++ debugging
  (dap-register-debug-template
   "C++ Debug (lldb)"
   (list :type "lldb-dap"
         :request "launch"
         :name "C++ Debug"
         :target nil  ; Will be prompted for
         :cwd nil     ; Will use current directory
         :args []
         :environment []))
         
  ;; Key bindings for debugging
  (map! :localleader
        :map (c-mode-map c++-mode-map)
        (:prefix ("d" . "debug")
         "b" #'dap-breakpoint-toggle
         "d" #'dap-debug
         "l" #'dap-debug-last
         "r" #'dap-debug-recent
         "s" #'dap-debug-restart
         "q" #'dap-disconnect
         "n" #'dap-next
         "i" #'dap-step-in
         "o" #'dap-step-out
         "c" #'dap-continue
         "v" #'dap-ui-inspect-thing-at-point
         "w" #'dap-watch-add)))

;; CMake integration
(after! projectile
  (add-to-list 'projectile-project-root-files "CMakeLists.txt"))
