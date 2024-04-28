function! fern#comparator#extension#new() abort
  return {
        \   'compare': funcref('s:compare'),
        \ }
endfunction

let g:fern_comparator_extension#disable_compare_extension = get(g:, 'fern_comparator_extension#disable_compare_extension', 0)
let g:fern_comparator_extension#disable_go_test_grouping = get(g:, 'fern_comparator_extension#disable_go_test_grouping', 1)

function s:strcmp(str1, str2)
  if a:str1 < a:str2
    return -1
  elseif a:str1 == a:str2
    return 0
  else
    return 1
  endif
endfunction

function! s:compare(n1, n2) abort
  let k1 = a:n1.__key
  let k2 = a:n2.__key
  let t1 = a:n1.status > 0
  let t2 = a:n2.status > 0
  let l1 = len(k1)
  let l2 = len(k2)

  for index in range(0, min([l1, l2]) - 1)
    if k1[index] ==# k2[index]
      continue
    endif
    let _t1 = index + 1 is# l1 ? t1 : 1
    let _t2 = index + 1 is# l2 ? t2 : 1
    if _t1 is# _t2
      let _k1 = k1[index]
      let _k2 = k2[index]
      " Extension compare
      if g:fern_comparator_extension#disable_compare_extension is# 0
        let ext1 = tolower(fnamemodify(_k1, ':e'))
        let ext2 = tolower(fnamemodify(_k2, ':e'))
        let comparison = s:strcmp(ext1, ext2)
        if comparison isnot# 0
          return comparison
        endif
      endif

      if g:fern_comparator_extension#disable_go_test_grouping is# 0
        let _g1 = substitute(_k1, '.go$', '', '')
        let _g2 = substitute(_k2, '.go$', '', '')
        let _gt1 = substitute(_g1, '_test$', '', '')
        let _gt2 = substitute(_g2, '_test$', '', '')
        if _gt1 is# _gt2
          return _k1 > _k2 ? 1 : -1
        endif
        return _gt1 > _gt2 ? 1 : -1
      endif

      " Lexical compare
      return _k1 > _k2 ? 1 : -1
    else
      " Directory first
      return _t1 ? -1 : 1
    endif
  endfor
  " Shorter first
  let r = fern#util#compare(l1, l2)
  if r isnot# 0
    return r
  endif
  " Leaf first
  return fern#util#compare(!a:n1.status, !a:n2.status)
endfunction
