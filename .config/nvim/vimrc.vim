" TODO: turn this into a prompt (ie: select how to modify the url)
" TODO: convert this to lua
" REF: https://stackoverflow.com/questions/9458294/open-url-under-cursor-in-vim-with-browser
function! HandleURL()
  let s:general = substitute(matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*'), '["'."'".' '.']', "", "g")
  let s:github = substitute(matchstr(getline("."), '["'."'".'].*["'."'".']' ), '["'."'".' '.']' , "", "g")
  if s:general == "" && s:github == ""
    echo "No URI found in line."
    return
  endif
  let s:uri = s:general != "" ? s:general : "https://www.github.com/".s:github
  echo s:uri
  silent exec "!open '".s:uri."'"
endfunction
" map <leader>u :call HandleURL()<cr>

