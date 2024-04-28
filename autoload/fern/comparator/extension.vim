function! fern#comparator#extension#new() abort
  return {
        \   'compare': funcref('s:compare'),
        \ }
endfunction

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
      " Extension compare
      let ext1 = tolower(fnamemodify(k1[index], ':e'))
      let ext2 = tolower(fnamemodify(k2[index], ':e'))
      let comparison = s:strcmp(ext1, ext2)
      if comparison isnot# 0
        return comparison
      endif

      " Lexical compare
      return k1[index] > k2[index] ? 1 : -1
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
