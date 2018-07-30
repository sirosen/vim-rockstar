" Vim syntax file
" Language:    Rockstar
" Maintainer:  Stephen Rosen
" Version:     1

" general syntax highlighting plugin stuff
if exists("b:current_syntax") || exists("b:did_ftplugin") | finish | endif
let b:current_syntax = "rockstar"
let b:did_ftplugin = 1
let b:undo_ftplugin = "setl com< fo< ofu<"
let s:save_cpo= &cpo


" TODO: figure out how to detect Rockstar code regions based on
" If/Else/While/Until ... <newline> using 'syn region'

" define proper and common nouns at the beginning of the syntax file so that
" they have the *LOWEST* priority
"
" TODO: check on how this behaves in esoteric cases -- maybe overly greedy
" about matching capital letters?
syn case match
syn match rockstar_proper_noun /\v[A-Z][a-zA-Z]*(\s[A-Z][a-zA-Z]*)*/
hi link rockstar_proper_noun Identifier
syn match rockstar_common_noun /\v(a|an|the|my|your|A|An|The|My|Your)\s[a-z]+/
hi link rockstar_common_noun Identifier


" other than proper/common nouns, everything should be case insensitive
syn case ignore


" highlight constants, bools, numerics, etc
syn keyword rockstar_constant nothing nobody nowhere null
hi link rockstar_constant Constant
syn keyword rockstar_bool true false right yes ok wrong no lies
hi link rockstar_bool Boolean

" TODO: refine knock-down/build-up
" should 'Knock X down' and 'Build X up' be defined as regions?
syn keyword rockstar_arithmetic plus with minus without times of over knock build up down
hi link rockstar_arithmetic Operator

" handle "is a" and "is not" and "is" all together to avoid "is" keyword
" matching from disrupting the other two
" also include "was" / "were" here to make matching simpler
" don't include "ain't" (handled below) because "ain't not" would result
syn match rockstar_is_usage /\v\s+(is|was|were)(\s+(a|not))?\s+/
hi link rockstar_is_usage Operator

syn match rockstar_comparator /\v(higher|greater|bigger|stronger|lower|less|smaller|weaker)\s+than/
syn match rockstar_comparator /\v(as\s+)?(high|great|big|strong|low|little|small|weak)\s+as/
syn match rockstar_comparator /\vain\'t(\s+a)?/
hi link rockstar_comparator Operator

syn keyword rockstar_conditional if else
hi link rockstar_codnitional Conditional
syn keyword rockstar_repeat while until continue break
syn match rockstar_repeat /\vBreak\s+it\s+down/
syn match rockstar_repeat /\vTake\s+it\s+to\s+the\s+top/
hi link rockstar_repeat Repeat

syn keyword rockstar_keyword it he she him her them they
hi link rockstar_keyword Keyword

syn keyword rockstar_io taking takes say shout whisper scream
syn match rockstar_io /\vGive\s+back/
syn match rockstar_io /\vListen(\s+to)?/
hi link rockstar_io Statement

syn keyword rockstar_assignment put into
hi link rockstar_assignment Keyword

syn match rockstar_number /\v[-+]?\d+/
syn match rockstar_number /\v[-+]?\d+\.\d+/
hi link rockstar_number Number

" modeled on Python String syntax highlighting (i.e. I looked at vim's python
" ft plugin)
" Note that Rockstar only treats double-quotes as denoting string literals, and
" single quotes get special rock'n'roll treatment
syn region rockstar_string start=/\z(["]\)/ end="\z1" skip="\\\\\|\\\z1"
hi link rockstar_string String

" Comments are parenthesized strings not contained in a string
"   syn region rockstar_block start='{' end='}' contains=...
"   syn keyword rockstar_block_delims { }
"   hi link rockstar_block_delims Delimiter
syn region rockstar_comment start='(' end=')'
syn keyword rockstar_comment_delims ( )
hi link rockstar_comment_delims Comment
hi link rockstar_comment Comment


" TODO: is there a rock'n'roll version of FIXME/TODO ?
" If so, they need to be identified even inside of comments
"
" Will be similar to
"     syn keyword rockstar_todo FIXME TODO NOTE XXX contained
"     hi link rockstar_todo Todo
"
" with 'rockstar_comment contains=rockstar_todo'


" undo any changes to cpo
let &cpo = s:save_cpo
unlet s:save_cpo
