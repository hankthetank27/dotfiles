[
 "{{"
 "}}"
 "{{-"
 "-}}"
 "{%"
 "%}"
 "{%-"
 "-%}"
] @tag.delimiter

[
 "]"
 "["
] @punctuation.bracket

[
 "|"
 "."
 ":"
 ","
 (predicate)
] @operator

[
 (statement)
 (unless_tag)
 (if_tag)
 (elseif_tag)
 (else_tag)
 (for_loop_tag)
 ; "with"
 ; "for"
 ; "as"
] @keyword

(identifier) @variable
(string) @string
(boolean) @boolean
(number) @number

(filter
  name: (identifier) @function.call)

(comment) @comment
