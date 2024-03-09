((template_content) @injection.content
 (#set-lang-by-filetype! "liquid" "html")
 (#set-lang-by-filetype! "js.liquid" "javascript")
 (#set-lang-by-filetype! "css.liquid" "css")
 (#set-lang-by-filetype! "scss.liquid" "scss")
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

