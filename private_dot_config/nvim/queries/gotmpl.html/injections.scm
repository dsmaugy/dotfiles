;; Inject Go template language inside {{ ... }} blocks
((template_action) @injection.content
 (#set! injection.language "gotmpl"))

;; Inject Go template language inside {{/* */}} comments
((comment) @injection.content
 (#set! injection.language "gotmpl"))
