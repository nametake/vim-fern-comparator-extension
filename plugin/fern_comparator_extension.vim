if exists('g:fern_comparator_extension_loaded')
  finish
endif
let g:fern_comparator_extension_loaded = 1

call extend(g:fern#comparators, {
      \ 'extension': function('fern#comparator#extension#new'),
      \})
