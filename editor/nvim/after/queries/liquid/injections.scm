((template_content) @injection.content
 (#is-file-extension? ".liquid")
 (#set! injection.language "html")
 (#set! injection.combined))

((template_content) @injection.content
 (#is-file-extension? ".js.liquid")
 (#set! injection.language "javascript")
 (#set! injection.combined))

((template_content) @injection.content
 (#is-file-extension? ".css.liquid")
 (#set! injection.language "css")
 (#set! injection.combined))

((template_content) @injection.content
 (#is-file-extension? ".scss.liquid")
 (#set! injection.language "css")
 (#set! injection.combined))

((schema_statement
  (template_content) @injection.content)
 (#set! injection.language "json")
 (#set! injection.combined))

((style_statement
  (template_content) @injection.content)
 (#set! injection.language "css")
 (#set! injection.combined))

((javascript_statement
  (template_content) @injection.content)
 (#set! injection.language "javascript")
 (#set! injection.combined))

