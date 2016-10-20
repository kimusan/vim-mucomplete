" Chained completion that works as I want!
" Maintainer: Lifepillar <lifepillar@lifepillar.me>
" License: This file is placed in the public domain

if exists("g:loaded_mucomplete")
  finish
endif
let g:loaded_mucomplete = 1

let s:save_cpo = &cpo
set cpo&vim

fun! s:mucomplete_enable_auto()
  let s:completedone = 0
  augroup MUcompleteAuto
    autocmd!
    autocmd TextChangedI * noautocmd if s:completedone | let s:completedone = 0 | else | silent call mucomplete#autocomplete() | endif
    autocmd CompleteDone * noautocmd let s:completedone = 1
  augroup END
endf

fun! s:mucomplete_disable_auto()
  if exists('#MUcompleteAuto')
    autocmd! MUcompleteAuto
    augroup! MUcompleteAuto
  endif
  if exists('s:completedone')
    unlet s:completedone
  endif
endf

if !exists(":MUcompleteAutoOn")
  command -nargs=0 MUcompleteAutoOn :call <sid>mucomplete_enable_auto()
endif

if !exists(":MUcompleteAutoOff")
  command -nargs=0 MUcompleteAutoOff :call <sid>mucomplete_disable_auto()
endif

imap <expr> <silent> <tab>   mucomplete#complete(0)
imap <expr> <silent> <s-tab> mucomplete#complete(1)

let &cpo = s:save_cpo
unlet s:save_cpo
