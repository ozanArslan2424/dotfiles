;; Inject zsh into template string as second argument of cmd function
(call_expression
  function: (identifier) @tag (#eq? @tag "cmd")
  arguments: (arguments
    (string)
    (template_string) @injection.content)
  (#set! injection.language "zsh"))
