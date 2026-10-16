; extends

;; Highlight GitHub Actions / other CI `run:` steps as bash.

;; Block scalar form:
;;   run: |
;;     echo hi
;; The `@injection.content` capture starts at the `|`/`>` indicator, so offset
;; the start column by 1 to keep it out of the injected bash.
(block_mapping_pair
  key: (flow_node) @_key
  value: (block_node
    (block_scalar) @injection.content)
  (#eq? @_key "run")
  (#set! injection.language "bash")
  (#offset! @injection.content 0 1 0 0))

;; Single-line form:
;;   run: echo hi
(block_mapping_pair
  key: (flow_node) @_key
  value: (flow_node) @injection.content
  (#eq? @_key "run")
  (#set! injection.language "bash"))
