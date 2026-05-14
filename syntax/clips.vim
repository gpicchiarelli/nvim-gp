" Vim syntax file
" Language: CLIPS

if exists("b:current_syntax")
  finish
endif

syn case match

syn keyword clipsTopLevel defrule deftemplate deffacts deffunction defglobal defmodule defclass defmessage-handler definstances
syn keyword clipsControl if then else while loop-for-count bind return progn assert retract modify duplicate reset run clear load save watch unwatch facts agenda rules ppdefrule ppdeftemplate
syn keyword clipsConditional and or not exists forall test
syn keyword clipsBuiltin printout readline read open close format str-cat sym-cat lowcase upcase length$ nth$ member$ create$ explode$ implode$
syn keyword clipsBoolean TRUE FALSE nil

syn match clipsVariable "?[A-Za-z0-9_*+\-/<>:=.$#@!]+"
syn match clipsMultifieldVariable "$?[A-Za-z0-9_*+\-/<>:=.$#@!]+"
syn match clipsComment ";.*$"
syn match clipsNumber "\v[-+]?\d+(\.\d+)?"
syn region clipsString start=+"+ skip=+\\"+ end=+"+

hi def link clipsTopLevel Statement
hi def link clipsControl Keyword
hi def link clipsConditional Conditional
hi def link clipsBuiltin Function
hi def link clipsBoolean Boolean
hi def link clipsVariable Identifier
hi def link clipsMultifieldVariable Identifier
hi def link clipsComment Comment
hi def link clipsNumber Number
hi def link clipsString String

let b:current_syntax = "clips"
