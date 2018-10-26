"=============================================================================
" File    : autoload/unite/sources/outline/defaults/yaml.vim
" Author  : ktrysmt <kotaro.yoshimatsu@gmail.com>
" Updated : 2018-10-26
"
" Licensed under the MIT license:
" http://www.opensource.org/licenses/mit-license.php
"
"=============================================================================

" Default outline info for yaml
" Version: 0.0.1

function! unite#sources#outline#defaults#yaml#outline_info() abort
  return s:outline_info
endfunction

"---------------------------------------
" Patterns

let s:heading_pattern = '^\(\s*\)\([a-zA-Z0-9-_][a-zA-Z0-9-_ ]\+\):'

"-----------------------------------------------------------------------------
" Outline Info

let s:outline_info = {
      \ 'heading'  : s:heading_pattern,
      \ 'skip': {
        \ 'header': '^\s*#',
      },
  \ }

function! s:outline_info.create_heading(which, heading_line, matched_line, context) abort
  let heading = {
        \ 'word' : a:heading_line,
        \ 'level': 0,
        \ 'type' : 'generic',
        \ }

  let matches = matchlist(a:heading_line, s:heading_pattern)
  let level = s:matchcount(matches[1] , " ")
  let tag = matches[2]
  let heading.level = level
  let heading.word = tag

  if heading.level > 0
    return heading
  else
    return {}
  endif
endfunction

function! s:matchcount(expr, pat, ...)
    let start = get(a:, "1", 0)
    let result = match(a:expr, a:pat, start)
    return result == -1 ? 0 : s:matchcount(a:expr, a:pat, result+1) + 1
endfunction

