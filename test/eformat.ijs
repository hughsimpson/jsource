1: 0 : 0
Rules for eformat_j_:

1. Do not assign y or any part of it to a global name.  The components of y are special headers
and their values are not protected by JE's usecount mechanism.  When eformat returns the values may
become invalid.

To guarantee a fresh copy (for debugging only) do something like
savy__ =: 3!:1 (3!:2) y

2. Remember that the noun arguments a, w, and ind may be very large.  (self may be large too but that
is less likely and we can truncate it if we need to)  Do not do anything that will require making a copy
of a/w/ind or creating a result of the same size.

These are NOT OK:
allint =. *./ (-: <.) , a  NB. <. a makes a copy of a
~. ind   NB. ~. makes a hashtable of size +:#ind
ind i. obinds   NB. (x i. y) makes a hashtable if y is a list
val =. ,a  NB. , result is virtual, but assigning it to a name realizes it

These are OK:
val =. a
val =. a ; w
(i. >./) , inds  NB. , is virtual and (i. >./) is backed by special code
10 {. a   NB. virtual
ind i. >./ obinds   NB. When x is a list and y is a scalar, no hashtable is created
)

(bx) =: >: i. #bx =. <@(,&'_j_');._2 (0 : 0)   NB. define error names
EVATTN
EVBREAK
EVDOMAIN
EVILNAME
EVILNUM
EVINDEX
EVFACE
EVINPRUPT
EVLENGTH
EVLIMIT
EVNONCE
EVASSERT
EVOPENQ
EVRANK
EVEXIT
EVSPELL
EVSTACK
EVSTOP
EVSYNTAX
EVSYSTEM
EVVALUE
EVWSFULL
EVCTRL
EVFACCESS
EVFNAME
EVFNUM
EVTIME
EVSECURE
EVSPARSE
EVLOCALE
EVRO
EVALLOC
EVNAN
EVNONNOUN
EVTHROW
EVFOLDLIMIT
EVVALENCE
EVINHOMO
)

NB.x is (1 if all of main name always needed),(max # characters allowed),(parenthesize w if compound); y is AR
NB. result is string to display, or ... if string too long
eflinAR_j_ =: {{
NB. parse the AR, recursively
if. y -: 0 0 do. '...' return. end.  NB. If no room for formatting, stop looking
'frc max par' =. x
aro =. >y
if. 2 = 3!:0 aro do.   NB. primitive or named entity
  if. (*frc) +. max >: #aro do. aro return. end.  NB. return value if short enough or we want all of it
  (_3 }. aro) , '...' return.
else.
  NB. not prim/name.  Look for other types: noun or modifier execution
  aro1 =. 1{::aro  NB. value of noun, or other ARs
  select. {. aro
  case. ;:'0' do.  NB. noun
    if. 1 < #@$ aro1 do. '...' return. end.  NB. don't try to format ranks>1
    if. 30 < #aro1  do. '...' return. end.  NB. or too many atoms
    if. (3!:0 aro1) e. 32 64 128 do. '...' return. end.  NB. or boxed/extended
    lin =. 5!:5<'aro1'  NB. value is small, take its linrep
    if. max >: #lin do. lin return. end.  NB. return value if short enough
    (_3 }. lin) , '...' return.
  case. ,&.>'234' do.  NB. hook/fork/train
    NB. these cases are not so important because they don't give verb-execution errors
    stgs=.0$a:  NB. list of strings
    for_i. aro1 do.
      stg =. (0 ,~ 0., 0. >. max%(#aro1)-i_index) eflinAR i  NB. collect strings for each AR
      max =. max - #stg [ stgs =. stgs , <stg  NB. don't allow total size to be exceeded
    end.
    NB. We have strings for each component.  If nothing has a display, return '...' unless this is top-level
    if. (frc=0) *. *./ stgs = <'...' do. '...' return. end.
    (')' ,~ '('&,)^:par ;:^:_1 stgs return. 
  case. do.  NB. default: executed A/C
    stgs =. <stg=. (0 >. (<:frc) , max , 1) eflinAR {. aro   NB. get (stg) for AC
    stgs =. stgs ,~ <stg =. (0 >. 0 , 0 ,~  max =. max -#stg) eflinAR {. aro1
    if. 1 < #aro1 do. stgs =. stgs , <stg =. (0 >. 0 , 1 ,~  max =. max -#stg) eflinAR {: aro1 end.
    if. (frc=0) *. *./ stgs = <'...' do. '...' return. end.
    (')' ,~ '('&,)^:par ; stgs return. 
  end.
end.
}}


NB. y is AR of self
NB. x is the IRS n from "n, if any (63 63 if no IRS)
NB. Result is string form, limited to 30 characters
eflinearself_j_ =: {{
'' eflinearself y
:
NB. create self as an entity; if entity has IRS, apply "n
sstg =. 2 30 0 eflinAR y
if. 63 (+./@:~:) x do. sstg =. sstg , '"' , ": (_1 x: <. (%63&~:) x) end.
sstg
}}

NB. y is list of boxes.  Result is string with the words separated and commaed
efandlist_j_ =: {{
if. 2 < #y do. y =. (,&','&.>@}: , {:) y end.
if. 1 < #y do. y =. (}: , (<'and') , {:) y end.
;:^:_1 y
}}

NB. x is 2x2 positions of <>; y is ashape;w shape  result is frame message
efcarets_j_ =: {{
bshape =. (<"1 +:x) ;@:((;:'<>')"_`[`]})&.> (a: 0 _1} (<' ') (,@,. , [) (":&.>))&.> y
'<frames> do not conform in shapes ' , (0 {:: bshape) , ' and ' , (1 {:: bshape)  
}}

NB. obsolete NB. y is message;selfar;ovr ; result has the executing entity prepended
NB. obsolete efaddself_j_ =: {{
NB. obsolete 'msg selfar ovr' =. y
NB. obsolete if. #msg do.
NB. obsolete   if. #selfmsg =. ovr eflinearself selfar do. msg =. msg ,~ selfmsg ,~ ', in ' end.
NB. obsolete end.
NB. obsolete msg
NB. obsolete }}
NB. obsolete 
NB. y is a;w;selfar;ivr;ovr
NB. Create msg if frames of a & w do not agree
efckagree_j_ =: {{
'a w selfar ivr ovr' =. y
self =. selfar 5!:0  NB. self as an entity
awr =. a ,&(#@$) w  NB. awr is ranks of noun args
emsg=.''  NB. init no return
ir =. ivr <. or =. (ovr<0)} (awr<.ovr) ,: (0 >. awr+ovr)  NB. or= outer cell ranks, limited to arg rank and adjusted for negative rank; ir is rank at which verb is applied
if. or -: awr do. or =. ir end.  NB. If outer frame is empty, switch to inner frame so we just give a shapes message without <>
if. -. -:/ (<./ awr-or) {.&> a ;&$ w do.  NB. frames must share a common prefix
  NB. error in the outermost frame.  Don't highlight it, just say the shapes disagree
NB. obsolete   bktpos =. 0 ,. awr-or
  emsg =. 'shapes ' , (":$a) , ' and ' , (":$w) , ' do not conform'
elseif. -. -:/ (<./ or-ir) {.&> (-or) {.&.> a ;&$ w do.  NB. inner frames too, after discarding outer frame
  NB. error in the inside frame.  highlight it.
  bktpos =. (awr-or) ,. awr-ir  NB. positions of <> chars for a/w, showing the position to put <> before.  There can be no agreement error if a frame is empty, so only one char per position is possible
  emsg =. bktpos efcarets a ;&$ w
end.
NB. If we found an error, prepend the failing primitive
emsg
}}

NB. y is a list of 3!:0 results (0 for empty); result is list of the types represented, including a: to mean 'empty'
efhomo_j_ =: {{
types =. ~. 0 10 14 16 17 I. 0 1 4 8 16 64 128 1024 4096 8192 16384 2 131072 262144 2048 32 32768 65536 i. ,y
types { a:,;:'numeric character boxed symbol'
}}

efarisnoun_j_ =: (((<,'0')) = {.)@>  NB. predicate.  y is an AR

NB. y is result from 9!:23, x is index arg to that 9!:23
NB. Result is message about the index if any, suitable by itself or if porefixed by ' [xy] has' 
efindexmsg_j_ =: {{
'rc il' =. y  NB. return code and index list of error
emsg =. ''
select. rc
case. 1 do. emsg =. ' nonnumeric type (' , (>efhomo 3!:0 x) , ')'
case. 2 do. emsg =. ' nonintegral value (' ,(": (<il) { x) , ') at position ' , ":il
case. 3 do. emsg =. ' invalid value (' ,(": (<il) { x) , ') at position ' , ":il
end.
emsg
}}

NB. y is jerr;curname;jt->ranks;AR of failing self;a[;w][;m]
NB. if self is a verb, a/w/m are nouns; otherwise a/w are ARs
eformat_j_ =: {{
NB. extract internal state quickly, before anything disturbs it
fill =. 9!:22''  NB. This also clears jt->fill
'e curn ovr selfar a' =. 5{.y
self =. selfar 5!:0  NB. self as an entity
psself =. 4!:0 <'self'  NB. part of speech of self
if. ism=.ovr-:'' do. ovr=.63 63 [ y =. }:y [ ind=._1{::y end.  NB. orv is the special value '' for m}.  Take the m arg in that case
if. dyad =. 5<#y do. w =. 5{::y end.
NB. now a and possibly w are args 4&5.  If self is a verb these will be the arg value(s) and dyad will be the valence
NB. if the verb is m}, there will be an m argument
NB. if self is not a verb, a and w are ARs and dyad indicates a conjunction
NB. Create the header line: terse-error [in name] [executing fragment], and a version without the fragment
hdr1 =. ((<:e) {:: 9!:8'') , (' in '&,^:(*@#) curn) , LF
hdr =. (}:hdr1) , (' executing '&,^:(*@#) ovr eflinearself selfar) , LF
emsg =. ''  NB. init no formatted result
NB. Start parsing self
while. do.
  if. 2 = 3!:0 > selfar do. prim =. selfar [ args=.0$0 break.  NB. primitive or single name: self-defining
  else.
    prim =. {. > selfar [ args =. (0;1) {:: selfar  NB. entity, args if any
    if. prim ~: ;:'!.' do. break. end.
    NB. self is u!.n - discard the !.n
    selfar =. {. args
  end.
end.
NB. Take valence error without further ado
if. (e=37) do.
  if. selfar -: {. ;:'[:' do. hdr1 , '[: must be part of a capped fork' return.
  else.
    if.  prim -: {. ;:':' do. if. efarisnoun {.args do. hdr1 , 'explicit definition has no ',(dyad{::'monad';'dyad'),'ic valence' return. end. end.  NB. could be {{ or m : and we can't distinguish
    hdr ,  ('verb has no ',(dyad{::'monad';'dyad'),'ic valence') return.
  end.
end.

NB. Go through a tree to find the message code to use
select. psself
case. 3 do.
  NB. verb. treat monad and dyad separately
  if. dyad do.
    NB. Dyads
    ivr =. }. self b. 0  NB. dyad ranks of the verb
    select. prim
    case. ;:'=<<.<:>>.>:++.+:**.*:-%%:^^.~:|!o.&."b.' do.  NB. atomic dyads and u"v
      NB. Primitive atomic verb.  Check for agreement
      if. e=9 do. if. #emsg=.efckagree a;w;selfar;ivr;ovr do. hdr,emsg return. end. end.
    case. ;: '@&&.' do.  NB. conjunctions with inherited rank
      if. (e=9) *. -. +./ efarisnoun args do. if. #emsg=.efckagree a;w;selfar;ivr;ovr do. hdr,emsg return. end. end.  NB. check only if inherited rank
    case. ;:'I.' do.
      if. (e=9) do. hdr , ((,.~ -&ivr) a ,&(#@$) w) efcarets a ;&$ w return. end.
    fcase. ;:',.' do.  NB. May have agreement error.  No IRS
      if. (e=9) do. emsg =. ' : shapes ' , (":$a) , ' and ' , (":$w) , ' have different numbers of items' end.
    case. ;:',,:' do.  NB. only error is incompatible args, but could be with fill also
      if. (e e. 3 38) do.  NB. domain /inhomo
        if. 1 < #types =. a. -.~ a efhomo@:(,&(*@(#@,) * 3!:0)) w do. emsg =. ' arguments are incompatible: ' , efandlist types
        elseif. 1=#fill do.
          if. 1 < #types =. ~. types , efhomo 3!:0 fill do. emsg =. ' arguments and fill are incompatible: ' , efandlist types end.
        end.
      end.
      hdr , emsg return.
    case. ;:'$' do.
      if. e=EVLENGTH do. emsg=.' extending an empty array requires fill'
      elseif. e=EVDOMAIN do. emsg=. ' x has'&,^:(*@#) a efindexmsg a 9!:23 (0;0)
      elseif. e=EVINHOMO do. emsg =. ' arguments and fill are incompatible: ' , efandlist w efhomo@:(,&(*@(#@,) * 3!:0)) fill
      end.
      hdr , emsg return.
NB. $ x domain and fill
NB. |. x domain and fill
NB. |: x domain
NB. ;. x domain and agreement
NB. # x domain and agreement
NB. #. xy domain and agreement
NB. #: xy domain  and agreement
NB. /. /.. agreement
NB. { x domain and index
NB. {. {: x domain rank fill
NB. } xy homo ind domain (incl fill) and index x/ind agreement
NB. }. }: x domain rank
NB. m b. domain
NB. A. x domain
NB. C. x domain agreement
NB. H. domain
NB. j. xy domain
NB. o. xy domain
NB. p. xy domain
NB. p.. xy domain
NB. p: xy domain
NB. q: xy domain
NB. s: xy domain
NB. T. xy domain
NB. u: xy domain
NB. x: xy domain
NB. Z: fold
    end.
  else.
    NB. Monads
    select. prim
    case. ;:'>;' do.
      if. (e e. 3 38) do. if. 1 < #types =. a: -.~ efhomo (,&(*@(#@,) * 3!:0)@> a do. emsg =. ' contents are incompatible: ' , efandlist types end. end.  NB. only error is incompatible args
      hdr , emsg return.
NB. |.!.f fill
NB. #. domain
NB. #: domain
NB. { domain
NB. {. {: fill
NB. } x domain
NB. ". domain
NB. ? ?. domain
NB. A. domain
NB. C. domain
NB. H. domain
NB. i. domain
NB. i: domain length
NB. I. domain
NB. j. domain
NB. o. domain
NB. p. domain
NB. p.. domain
NB. p: q: domain
NB. s: domain
NB. T. domain
NB. u: domain
NB. x: domain
    end.
  end.
end.
''
}}


1: 0 : 0
self=.+
eformat_j_ 9;'name';63 63;(5!:1<'self');a;<w [ a =. i. 2 3 4 [ w =. i. 3 3 4
eformat_j_ 9;1 63;(5!:1<'self');a;<w [ a =. i. 2 3 4 [ w =. i. 3 3 4
eformat_j_ 9;1 2;(5!:1<'self');a;<w [ a =. i. 2 3 4 [ w =. i. 3 3 4
eformat_j_ 9;1 2;(5!:1<'self');a;<w [ a =. i. 1 2 [ w =. i. 1 2 4   NB. no error
eformat_j_ 9;1 1;(5!:1<'self');a;<w [ a =. i. 1 2 [ w =. i. 1 2 4
eformat_j_ 9;63 63;(5!:1<'self');a;<w [ a =. 2 3 [ w =. 4 5 6
eflinearself_j_ 5!:1<'self'
self=.+&5
eflinearself_j_ 5!:1<'self'
self=.+&(i. 2 2)
eflinearself_j_ 5!:1<'self'
self=.+&1x
eflinearself_j_ 5!:1<'self'
self=.(+/ # *)
eflinearself_j_ 5!:1<'self'
self=.tolower
eflinearself_j_ 5!:1<'self'
self=.(tolower@tolower tolower tolower@tolower)
eflinearself_j_ 5!:1<'self'
self =. >
eformat_j_ 3;63 63;(5!:1<'self');<a [ a =. 1;'1'
self =. ,
eformat_j_ 3;63 63;(5!:1<'self');a;<w [ a =. 1 [ w=.'1'
self =. ,:!.'a'
eformat_j_ 3;63 63;(5!:1<'self');a;<w [ a =. (,2) [ w=.2 3
self=:[:
eformat_j_ 37;63 63;(5!:1<'self');a;<w [ a =. (,2) [ w=.2 3
)



