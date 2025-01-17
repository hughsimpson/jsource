prolog './g520.ijs'

NB. (prx;pcx;pivotcolnon0;newrownon0;relfuzz) 128!:12 Qk ------------------------
NB. normal precision
f =: 1:`({{
 while. 1 T. '' do. 55 T. '' end.
 while. 2 > 1. T. '' do.
  siz =. y  NB. size of Qk
  'r c' =. 2 ?@$ >:siz  NB. size of modified area
  prx =. 00 + r ? siz [ pcx =. 00 + c ? siz  NB. indexes of mods
  pivotcolnon0 =.r ?@$ 0 [ newrownon0 =. c ?@$ 0
  relfuzz =. 1e_14 * ? 0  NB. tolerance
  Qk =. (siz,siz) ?@$ 0
  expQk=. (((<prx;pcx) { Qk) ((~:!.relfuzz) * -) pivotcolnon0 */ newrownon0) (<prx;pcx)} preQk =. memu Qk
  Qk =. (prx;pcx;pivotcolnon0;newrownon0;relfuzz) 128!:12 Qk
  if. -. r =. 1e_13 > >./ , | Qk - expQk do. 13!:8]4 [ 'prx__ pcx__ pivotcolnon0__ newrownon0__ relfuzz__ expQk__ preQk__ Qk__' =: prx;pcx;pivotcolnon0;newrownon0;relfuzz;expQk;preQk;Qk end.
  0 T. 0  NB. allocate a worker thread
 end.
 while. 1 T. '' do. 55 T. '' end.
 r 
}}"0)@.(+./ ('avx2';'avx512') +./@:E.&> <9!:14'')
f i. 65

NB. quad precision
f =: 1:`({{
 epmul =. (|:~ (_1 |. i.@#@$)) @: (((0 0 1 1{[) +/@:*"1!.1 (0 1 0 1{]))"1&(0&|:))
 epadd =. (|:~ (_1 |. i.@#@$)) @: ((1.0"0 +/@:*"1!.1 ])@,"1&(0&|:))
 epsub =. (epadd -)
 epdefuzzsub =. ((]: * >.)&:|&{. ((<!.0 |@{.) *"_ _1 ]) epsub)
 epcanon =. (epadd   0 $~ $)
 siz =. y  NB. size of Qk
 while. 1 T. '' do. 55 T. '' end.
 while. 2 > 1. T. '' do.
  'r c' =. 2 ?@$ >:siz  NB. size of modified area
  prx =. 00 + r ? siz [ pcx =. 00 + c ? siz  NB. indexes of mods
  pivotcolnon0 =. (] {~ r ? #) (, -) 10 ^ (+   3 * *) 6. * _0.5 + r ?@$ 0  NB. random values 1e3 to 1e6 and 1e_3 to 1e_6, both signs
  pivotcolnon0 =. epcanon (,:   ] * (2^_53) * _0.5 + 0 ?@$~ $) pivotcolnon0  NB. append extended part
  pivotcolnon0 =. 0. + pivotcolnon0  NB. force to float
  newrownon0 =. (] {~ c ? #) (, -) 10 ^ (+   3 * *) 6. * _0.5 + c ?@$ 0  NB. random values 1e3 to 1e6 and 1e_3 to 1e_6, both signs
  newrownon0 =. epcanon (,:   ] * (2^_53) * _0.5 + 0 ?@$~ $) newrownon0  NB. append extended part
  newrownon0 =. 0. + newrownon0  NB. force to float
  relfuzz =. 1e_25 * ? 0  NB. tolerance
  Qk =. (*  0.25 < 0 ?@$~ $) 1e6 * (siz,siz) ?@$ 0.
  Qk =. epcanon (,:   ] * (2^_53) * _0.5 + 0 ?@$~ $) Qk  NB. append extended part
  expQk=. (((<a:;prx;pcx) { Qk) (relfuzz epdefuzzsub) (c #"0 pivotcolnon0) epmul (r&#@,:"1 newrownon0)) (<a:;prx;pcx)} preQk =. memu Qk
  Qk =. (prx;pcx;pivotcolnon0;newrownon0;relfuzz) 128!:12 Qk
  if. -. 1e_30 > >./ re =. , | (+/  expQk epsub Qk) % (| +/ Qk) >. (| +/ preQk) >. (| +/ expQk) do. 13!:8]4 [ 'r__ c__ re__ prx__ pcx__ pivotcolnon0__ newrownon0__ relfuzz__ expQk__ preQk__ Qk__' =: r;c;re;prx;pcx;pivotcolnon0;newrownon0;relfuzz;expQk;preQk;Qk end.
  0 T. 0  NB. allocate a worker thread
 end.
 while. 1 T. '' do. 55 T. '' end.
 1
}}"0)@.(+./ ('avx2';'avx512') +./@:E.&> <9!:14'')

f i. 65

NB. avoid repeated indexes
f =: 1:`({{
 ck =. 0. + i. 10
 prcr =. ;@:((<@:({.~  1 i.~ 0 1 2 3 ~: i.~))"1) (#: i.@:(*/)) 4 4 4 4
 prcrnub =. ~. prcr
 prcl =. (#prcr) # 01
 newrownon0 =. >: (#prcr) ?@$ 0
 mplr =. ($prcr) ?@$ 0
 ckchg =. prcr +//. (prcl # newrownon0) * mplr
 upd=. ckchg -~ prcrnub { ck
 expck=. upd prcrnub} preck =. memu ck
 ck =. (00;prcr;(,1.);(prcl #"01 newrownon0);(mplr)) 128!:12 ck
 if. -. r =. 1e_13 > >./ , | ck - expck do. 13!:8]4 [ ' prcr__  newrownon0__  expck__ preck__ ck__' =: prcr;newrownon0;expck;preck;ck end.
 1
}})@.(+./ ('avx2';'avx512') +./@:E.&> <9!:14'')
f ''


NB. (0;pcx;pivotcolnon0;newrownon0;relfuzz) 128!:12 bk ------------------------
NB. normal precision
f =: 1:`({{
 siz =. y  NB. size of bk
 r =. 1 [ c =. ? >:siz  NB. size of modified area
 pcx =. 00 + c ? siz  NB. indexes of mods
 pivotcolnon0 =. r ?@$ 0 [ newrownon0 =. c ?@$ 0
 relfuzz =. 1e_14 * ? 0  NB. tolerance
 bk =. siz ?@$ 0
 expbk=. (((<<pcx) { bk) ((~:!.relfuzz) * -) (c # pivotcolnon0) * newrownon0) (<<pcx)} prebk =. memu bk
 bk =. (00;pcx;pivotcolnon0;newrownon0;relfuzz) 128!:12 bk
 if. -. r =. 1e_13 > >./ , | bk - expbk do. 13!:8]4 [ 'pcx__ pivotcolnon0__ newrownon0__ relfuzz__ expbk__ prebk__ bk__' =: pcx;pivotcolnon0;newrownon0;relfuzz;expbk;prebk;bk end.
 r 
}}"0)@.(+./ ('avx2';'avx512') +./@:E.&> <9!:14'')
f i. 65

NB. quad precision
f =: 1:`({{
 epmul =. (|:~ (_1 |. i.@#@$)) @: (((0 0 1 1{[) +/@:*"1!.1 (0 1 0 1{]))"1&(0&|:))
 epadd =. (|:~ (_1 |. i.@#@$)) @: ((1.0"0 +/@:*"1!.1 ])@,"1&(0&|:))
 epsub =. (epadd -)
 epdefuzzsub =. ((]: * >.)&:|&{. ((<!.0 |@{.) *"_ _1 ]) epsub)
 epcanon =. (epadd   0 $~ $)
 siz =. y  NB. size of Qk
 r =. 1 [ c =. ? >:siz  NB. size of modified area
 pcx =. 00 + c ? siz  NB. indexes of mods
 pivotcolnon0 =.r ?@$ 0 [ newrownon0 =. c ?@$ 0
 pivotcolnon0 =. (] {~ r ? #) (, -) 10 ^ (+   3 * *) 6. * _0.5 + r ?@$ 0  NB. random values 1e3 to 1e6 and 1e_3 to 1e_6, both signs
 pivotcolnon0 =. epcanon (,:   ] * (2^_53) * _0.5 + 0 ?@$~ $) pivotcolnon0  NB. append extended part
 pivotcolnon0 =. 0. + pivotcolnon0  NB. force to float
 newrownon0 =. (] {~ c ? #) (, -) 10 ^ (+   3 * *) 6. * _0.5 + c ?@$ 0  NB. random values 1e3 to 1e6 and 1e_3 to 1e_6, both signs
 newrownon0 =. epcanon (,:   ] * (2^_53) * _0.5 + 0 ?@$~ $) newrownon0  NB. append extended part
 newrownon0 =. 0. + newrownon0  NB. force to float
 relfuzz =. 1e_25 * ? 0  NB. tolerance
 bk =. (*  0.25 < 0 ?@$~ $) 1e6 * siz ?@$ 0.
 bk =. epcanon (,:   ] * (2^_53) * _0.5 + 0 ?@$~ $) bk  NB. append extended part
 expbk=. (((<a:;pcx) { bk) (relfuzz epdefuzzsub) (c #"1 pivotcolnon0) epmul (newrownon0)) (<a:;pcx)} prebk=. memu bk
 bk =. (00;pcx;pivotcolnon0;newrownon0;relfuzz) 128!:12 bk
 if. -. 1e_30 > >./ re =. , | (+/  expbk epsub bk) % (| +/ bk) >. (| +/ prebk) >. (| +/ expbk) do. 13!:8]4 [ 'r__ c__ re__ pcx__ pivotcolnon0__ newrownon0__ relfuzz__ expbk__ prebk__ bk__' =: r;c;re;pcx;pivotcolnon0;newrownon0;relfuzz;expbk;prebk;bk end.
 1
}}"0)@.(+./ ('avx2';'avx512') +./@:E.&> <9!:14'')

f i. 65


NB. 128!:9  g;i;v;M ---------------------------------------------------------
{{)v
epmul =. (|:~ (_1 |. i.@#@$)) @: (((0 0 1 1{[) +/@:*"1!.1 (0 1 0 1{]))"1&(0&|:))
epadd =. (|:~ (_1 |. i.@#@$)) @: ((1.0"0 +/@:*"1!.1 ])@,"1&(0&|:))
epsub =. (epadd -)
epdefuzzsub =. ((]: * >.)&:|&{. ((<!.0 |@{.) *"_ _1 ]) epsub)
epcanon =. (epadd   0 $~ $)
M =. 0. + =/~ i. 6
assert. 1 0 0 0 0 0 -: (128!:9) 00;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0.0
assert. 0 0 1 0 0 0 -: (128!:9) 2;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0.0
assert. 1 2 0 0 0 0 -: (128!:9) 6;(,."1 (_2) ]\ 0 2);(00 1);(1. 2.);M;0.0
assert. 0 0 1 2 0 3 -: (128!:9) 8;(,."1 (_2) ]\ (4$0) , 3 3);((3$0) , 2 3 5);((3$0), 1. 2. 3.);M;0.0
NB. clamping to threshold
M =.|: _4 ]\ _1. 0 1 2  _1e_5 _2e_9 0 1e_9   0 0 0 0 0 0 0 0   NB. input by columns
assert. _1. 0 1 2 -: (128!:9) 00;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0.5
assert. 0. 0 0 2 -: (128!:9) 00;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;1.5
assert. 0. 0 0 0 -: (128!:9) 00;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;2.5
assert. _1e_5 _2e_9 0 1e_9 -: (128!:9) 01;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;1e_10
assert. _1e_5 _2e_9 0 1e_9 -: (128!:9) 01;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;1e_9
assert. _1e_5 0 0 0 -: (128!:9) 01;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;1e_8
NB. Test every different length.  Different size of M are not so important
for_l. >:  i. 50 do.
  'r c' =. $M =. _0.5 + (2 # l+?20)?@$ 0
  for_j. 100$0 do.
    ix =. l ? c  NB. indexes
    v =. l ?@$ 0  NB. vector values
    pad =. ? 20  NB. number of dummy columns to install
    ref =. (ix{"1 M) +/@:*"1 v
    assert. 1e_10 > | ref - (128!:9) (c+pad);(,."1 (-pad+1) {. (_2) ]\ 0 , #ix);ix;v;M;0.0
  end.
end.
NB. Repeat in quad precision
for_l. i. 51 do.
  M =. (*  0.25 < 0 ?@$~ $)  _0.5 + (2 # l+?20)?@$ 0  NB. random values of random sizes, with 25% 0s
  M =. 0. + epcanon (,:   ] * (2^_53) * _0.5 + 0 ?@$~ $) M  NB. append extended part, force to float
  'r2 r c' =. $M
  for_j. 100$0 do.
    ix =. 00 + l ? c  NB. indexes
    v =. l ?@$ 0  NB. vector values
    pad =. ? 20  NB. number of dummy columns to install
    ref =. |: (,~ v) +/@:*"1!.1 ,.~/ ix{"1 M  NB. M values, small first, weighted by v
    act =. (128!:9) (c+pad);(,."1 (-pad+1) {. (_2) ]\ 0 , #ix);ix;v;M;0.0
    if. -. 1e_25 > >./ re=. | +/ ref epsub act do. 13!:8]4 [ 'r__ c__ re__ ix__ v__ ref__ act__ M__' =: r;c;re;ix;v;ref;act;M end.
  end.
end.
prtpms =. ([: 1: smoutput@[ smoutput@'' smoutput@])
prtpms =. -:
bk =. _2 1 3 1e_8
M =. |: _4 ]\ 0. 1 3 0  0 0.5 3 0   1 0 0 0   0 1e_9 0 0   NB. input by columns
cons=. 1e_11 1e_6 0.0 0 1. 1.0 _1 NB. ColThr MinPivot #freepasses #improvements #amounttoimproveby prirow
Frow=. _4 _3 _2 _1. 0.
bkg=.i.#M
NB. Test DIP mode - on identity cols
assert. 0 0 1 4 10 _4 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 1 4 13 _4 prtpms (128!:9) 1 0 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 1 4 13 _4 prtpms (128!:9) 3 1 0 2;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 1 3 1 1 4 0 prtpms (128!:9) (,3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow  NB. dangerous pivot
NB. empty
assert. 6 prtpms (128!:9) (0$00);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow  NB. no columns
assert. 6 prtpms (128!:9) (0$00);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow  NB. no columns
assert. 6 prtpms (128!:9) (,3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;($0);cons;bk;Frow  NB. no rows
assert. 6 prtpms (128!:9) (,3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);(0 0$0.);bkg;cons;(0$0.);(1$0.)  NB. empty M
bkg=.i.-#M
assert. 0 0 1 4 10 _4 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 2 4 13 _4 prtpms (128!:9) 1 0 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow  NB. goes down 1st col, up the rest
assert. 0 0 1 4 10 _4 prtpms (128!:9) 2 0 1 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 2 4 13 _4 prtpms (128!:9) 3 1 0 2;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 1 3 1 1 4 0 prtpms (128!:9) (,3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow  NB. dangerous pivot
NB. row cutoff
M =. |: _4 ]\ 0. 1 3 0  0 2 3 0   1 0 0 0   0 1e_9 0 0   NB. input by columns
assert. 0 0 1 4 10 _4 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 2 4 13 _4 prtpms (128!:9) 1 0 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 1 4 10 _4 prtpms (128!:9) 2 0 1 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 2 4 13 _4 prtpms (128!:9) 2 1 0 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
NB. col cutoff
M=. 4 4 $ 1.  NB. every ele is valid
bkg=.i.#M
bk =. 1. 2 2 2  NB. the pivot is the first row
Frow=. _1 _1.1 _1.5 _2 0  NB. improvements are _1 _1.1 _3 _4
assert. 0 3 0 4 16 _2 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0 0 1 1.0 _1;bk;Frow
assert. 0 3 0 5 17 _2 prtpms (128!:9) 0 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0 0 1 1.0 _1;bk;Frow
assert. 0 3 0 4 13 _2 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0 0 1 1.2 _1;bk;Frow
assert. 0 3 0 4 13 _2 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0 0.24 1 1.2 _1;bk;Frow
assert. 0 3 0 4 16 _2 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0 0.26 1 1.2 _1;bk;Frow
assert. 0 3 0 5 14 _2 prtpms (128!:9) 0 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0 0.26 1 1.2 _1;bk;Frow  NB. cut off in cols 1 2
assert. 0 3 0 4 16 _2 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0 0.51 1 1.2 _1;bk;Frow  NB. col 1 fully evaluated
assert. 0 1 0 2 8 _1.1 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0 0 0.26 1.0 _1;bk;Frow
assert. 0 1 0 2 8 _1.1 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0 0.26 0.26 1.0 _1;bk;Frow
assert. 0 2 0 3 12 _1.5 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0 0.26 0.51 1.0 _1;bk;Frow
assert. 0 0 0 1 4 _1 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0 0.26 0 1.2 _1;bk;Frow  NB. stop after first col
M=.4 4 $!.0 ] 1e_8 1 1 1  NB. first row is pivot; first col is dangerous
assert. 0 1 0 2 8 _1.1 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0 0.26 0 1.2 _1;bk;Frow  NB. don't stop on dangerous first col
NB. bk thresh
M=. 4 4 $ 1.
bk=. 1e_1 1e_2 1 1
bkg=.i.#M
Frow=. _1 _1.1 _1.5 _2 0  NB. improvements are _1 _1.1 _3 _4
assert. 3 0 0 4 4 0 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0.5 0 1 1.0 _1;bk;Frow
assert. 3 0 0 4 4 0 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0.05 0 1 1.0 _1;bk;Frow
assert. 0 3 1 4 16 _0.02 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0.005 0 1 1.0 _1;bk;Frow
NB. unbounded
M =. |: _3 ]\ 0. 0 0 1 1 1 0 0 0   NB. input by columns
bk =. 1. 2 2  NB. the first row on each col is the pivot
bkg=.i.#M
Frow=. _1 _1.1 _1.5 0  NB. improvements
assert. 4 0 prtpms (128!:9) 0 1 2;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 4 2 prtpms (128!:9) 1 2 0;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 4 3 prtpms (128!:9) 3 1 2;(,."1 (_2) ]\ 00 1);(1$2);(1$1.0);M;bkg;cons;bk;Frow
NB. stall
bk =. 0. 0 0  NB. no improving pivots
M =. |: _3 ]\ 1. 1 1  1 1 1  1 1 1   NB. input by columns
assert. 3 0 0 3 3 0 prtpms (128!:9) 0 1 2;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
NB. virtual row gets priority
M=. |: _4 ]\ 0. 1 1 0   1 0 0 0  0 0 1 0 0 0 0 1   NB. input by columns
bk =. 1. 1 1 1  NB. every row can pivot
Frow=. _4. _3 _2 _1 0  NB. improvements reduced col by col
assert. 0 0 1 4 7 _4 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 1 2 3;1e_11 1e_6 0 0 1 1.0 _1;bk;Frow
assert. 0 1 0 2 8 __ prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 1 2 3;1e_11 1e_6 0 0 1 1.0 0;bk;Frow
assert. 0 0 1 1 4 __ prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 1 2 3;1e_11 1e_6 0 0 1 1.0 1;bk;Frow
assert. 0 2 2 3 9 __ prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 1 2 3;1e_11 1e_6 0 0 1 1.0 2;bk;Frow
assert. 0 0 2 1 4 __ prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;2 0 1 3;1e_11 1e_6 0 0 1 1.0 2;bk;Frow  NB. First row also uses bkg
assert. 0 0 2 2 8 __ prtpms (128!:9) 1 0 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;2 0 1 3;1e_11 1e_6 0 0 1 1.0 2;bk;Frow  NB. second row uses bkg
M=. |: _4 ]\ 0. 1 1 0   1 0 1 0  0 0 0 1 0 0 0 1   NB. input by columns
assert. 0 1 0 2 8 __ prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 1 2 3;1e_11 1e_6 0 0 1 1.0 0;bk;Frow
M=. |: _4 ]\ 0. 1 1 0   1 0 2 0  0 0 0 1 0 0 0 1   NB. input by columns
assert. 0 0 1 4 7 _4 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 1 2 3;1e_11 1e_6 0 0 1 1.0 0;bk;Frow  NB. later non-virtual doesn't get priority
NB. exclusion list
M=. |: _4 ]\ 1. 0 0 0   0 1 0 0   1. 0 0 0  1. 0 0 0   NB. input by columns
Frow=. _1. _5 _1 _1 0   NB. all improving
bk =. 4 $ 1.0  NB. all valid
bkg=.i.#M
assert. 0 1 1 4 10 _5 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow;($00);(4 5 6 7)
assert. 0 1 1 4 10 _5 prtpms (128!:9) 3 0 1 2;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow;($00);(4 5 6 7)
assert. 0 0 0 4 11 _1 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow;(,16b100000005);(4 5 6 7)  NB. The only pivot was excluded
Frow=. _1. _5 _2 _1 0   NB. all improving
assert. 0 2 0 4 14 _2 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow;(,16b100000005);(4 5 6 7)  NB. The only pivot was excluded
M=. |: _4 ]\ 0. 0 0 1   0 2 1 0  1 0 0 0    1 0 0 0   NB. input by columns
assert. 0 2 0 4 14 _2 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow;(,16b100000005);(4 5 6 7)  NB. Next pivot accepted
if. 0 do.  NB. no longer supported
NB. Zero Frow
M=. |: _4 ]\ _1. _1 2 1   _1 1 1 1    _1 _1 2 1e_13   1 1 _1 1   NB. 2 non0, 1 0; 2 non0, 2 0; only 1 non0 (c too small); 2 non0, 2 0 (close enough)
Frow=. ''   NB. rows are immaterial
bk =. _1e_13 1e_13 1 1  NB. bk in order
bkg=./: bk
assert. 2 0 2 0 4 1 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 1e_11 0 1 1.0 _1;bk;Frow;($00);(4 5 6 7)  NB. 2 non0, 1 0
assert. 2 0 2 3 11 1 prtpms (128!:9) 1 2 3 0;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 1e_11 0 1 1.0 _1;bk;Frow;($00);(4 5 6 7)  NB. 2 non0, 2 0
assert. 3 0 0 4 11 0 prtpms (128!:9) 1 2 3 0;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 1e_11 0 1 1.0 _1;bk;Frow;(,16b000000006);(4 5 6 7)  NB. Pivot excluded
end.

NB. Dpiv
M=. |: _4 ]\ _1. 0 2 3  0 2 3 4  2 3 4 5  3 4 5 6    NB. 
Dpiv=. (1+#M) $ _1
assert. '' prtpms 128!:9 (0 1 2);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 1 2;1.0 0 0 0 0 0 0;'';'';Dpiv  NB. init
assert Dpiv prtpms 1 2 3 _1 _1
assert. '' prtpms 128!:9 (1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;1 2 3;2.5 0 0 0 0 0 1;'';'';Dpiv  NB. add
assert Dpiv prtpms 1 4 6 2 _1
assert. '' prtpms 128!:9 (0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 3;2.5 0 0 0 0 0 _1;'';'';Dpiv  NB. sub

NB. Quad-precision M
bk =. _2 1 3 1e_8
M =. 2 {. ,: |: _4 ]\ 0. 1 3 0  0 0.5 3 0   1 0 0 0   0 1e_9 0 0   NB. input by columns
cons=.1e_11 1e_6 0.0 0 1. 1.0 _1 NB. ColThr MinPivot #freepasses #improvements #amounttoimproveby prirow
Frow=. _4 _3 _2 _1. 0.
bkg=.i.4
NB. Test DIP mode - on identity cols
assert. 0 0 1 4 10 _4 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 1 4 13 _4 prtpms (128!:9) 1 0 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 1 4 13 _4 prtpms (128!:9) 3 1 0 2;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 1 3 1 1 4 0 prtpms (128!:9) (,3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow  NB. dangerous pivot
bk =. 2 {. ,: bk  NB. Repeat with quad-prec bk
assert. 0 0 1 4 10 _4 prtpms (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 1 4 13 _4 prtpms (128!:9) 1 0 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 1 4 13 _4 prtpms (128!:9) 3 1 0 2;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 1 3 1 1 4 0 prtpms (128!:9) (,3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow  NB. dangerous pivot
M=. 2 {. ,: |: _4 ]\ _1. 0 2 3  0 2 3 4  2 3 4 5  3 4 5 6    NB. quad-prec
Dpiv=. (1+4) $ _1
assert. '' prtpms 128!:9 (0 1 2);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 1 2;1.0 0 0 0 0 0 0;'';'';Dpiv  NB. init
assert Dpiv prtpms 1 2 3 _1 _1
assert. '' prtpms 128!:9 (1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;1 2 3;2.5 0 0 0 0 0 1;'';'';Dpiv  NB. add
assert Dpiv prtpms 1 4 6 2 _1
assert. '' prtpms 128!:9 (0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 3;2.5 0 0 0 0 0 _1;'';'';Dpiv  NB. sub

NB. Repeat multithreaded
NB. obsolete bxr =. </.~  0 1 $~ $  NB. 2 threads
mt3 =. -:&(3&{.)
mt025 =. -:&(0 2 5&{)
mt0125 =. -:&(0 1 2 5&{)
delth =. {{ while. 1 T. '' do. 55 T. '' end. 1 }}  NB. delete all worker threads
delth''  NB. make sure we start with an empty system
0 T. 0  NB. Allocate 1 worker thread

bxr =. ]

NB. Test every different length.  Different size of M are not so important but must be >100 to engage multithreading
for_l. >:  i. 50 do.
  'r c' =. $M =. _0.5 + (2 # 100+?20)?@$ 0
  for_j. 100$0 do.
    ix =. l ? c  NB. indexes
    v =. l ?@$ 0  NB. vector values
    pad =. ? 20  NB. number of dummy columns to install
    ref =. (ix{"1 M) +/@:*"1 v
    assert. 1e_10 > | ref - (128!:9) (c+pad);(,."1 (-pad+1) {. (_2) ]\ 0 , #ix);ix;v;M;0.0
  end.
end.
NB. Repeat in quad precision
for_l. i. 51 do.
  M =. (*  0.25 < 0 ?@$~ $)  _0.5 + (2 # 100+?20)?@$ 0  NB. random values of random sizes, with 25% 0s
  M =. 0. + epcanon (,:   ] * (2^_53) * _0.5 + 0 ?@$~ $) M  NB. append extended part, force to float
  'r2 r c' =. $M
  for_j. 100$0 do.
    ix =. 00 + l ? c  NB. indexes
    v =. l ?@$ 0  NB. vector values
    pad =. ? 20  NB. number of dummy columns to install
    ref =. |: (,~ v) +/@:*"1!.1 ,.~/ ix{"1 M  NB. M values, small first, weighted by v
    act =. (128!:9) (c+pad);(,."1 (-pad+1) {. (_2) ]\ 0 , #ix);ix;v;M;0.0
    if. -. 1e_25 > >./ re=. | +/ ref epsub act do. 13!:8]4 [ 'r__ c__ re__ ix__ v__ ref__ act__ M__' =: r;c;re;ix;v;ref;act;M end.
  end.
end.

bk =. _2 1 3 1e_8
M =. |: _4 ]\ 0. 1 2.9 0  0 0.5 3 0   1 0 0 0   0 1e_9 0 0   NB. input by columns
cons=. 1e_11 1e_6 0.0 0 1. 1.0 _1  NB. ColThr MinPivot #freepasses #improvements #amounttoimproveby nvirt
Frow=. _4 _3 _2 _1. 0.
bkg=.i.#M
NB. Test DIP mode - on identity cols
assert. 0 0 1 4 12 _4 mt3 128!:9 (bxr 0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 1 4 13 _4 mt3 128!:9 (bxr 1 0 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 1 4 13 _4 mt3 128!:9 (bxr 3 1 0 2);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 1 3 1 1 4 0 mt3 128!:9 (bxr 3 3 3 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow  NB. dangerous pivot
NB. empty
assert. 6 mt3 128!:9 (bxr 3 3 3 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;($0);cons;bk;Frow  NB. no rows
assert. 6 mt3 128!:9 (bxr 3 3 3 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);(0 0$0.);bkg;cons;(0$0.);(1$0.)  NB. empty M
bkg=.i.-#M
assert. 0 0 1 4 14 _4 mt3 128!:9 (bxr 0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 1 4 16 _4 mt3 128!:9 (bxr 1 0 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 1 4 11 _4 mt3 128!:9 (bxr 2 0 1 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 0 0 1 4 16 _4 mt3 128!:9 (bxr 3 1 0 2);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 1 3 1 1 4 0 mt3 128!:9 (bxr 3 3 3 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow  NB. dangerous pivot
NB. bk thresh
M=. 4 4 $ 1.
bk=. 1e_1 1e_2 1 1
bkg=.i.#M
Frow=. _1 _1.1 _1.5 _2 0  NB. improvements are _1 _1.1 _3 _4
assert. 3 0 0 4 4 0 mt3 128!:9 (bxr 0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0.5 0 1 1.0 _1;bk;Frow
assert. 3 0 0 4 8 0 mt3 128!:9 (bxr 0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0.05 0 1 1.0 _1;bk;Frow
assert. 0 3 1 4 16 _0.02 mt3 128!:9 (bxr 0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 0.005 0 1 1.0 _1;bk;Frow
NB. unbounded
M =. |: _3 ]\ 0. 0 0 1 1 1 0 0 0   NB. input by columns
bk =. 1. 2 2  NB. the first row on each col is the pivot
bkg=.i.#M
Frow=. _1 _1.1 _1.5 0  NB. improvements
assert. 4 0 mt3&{. 128!:9 (bxr 0 1 2);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 4 2 mt3&{. 128!:9 (bxr 1 2 0);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
assert. 4 3 mt3&{. 128!:9 (bxr 3 1 2);(,."1 (_2) ]\ 00 1);(1$2);(1$1.0);M;bkg;cons;bk;Frow
NB. stall
bk =. 0. 0 0  NB. no improving pivots
M =. |: _3 ]\ 1. 1 1  1 1 1  1 1 1   NB. input by columns
assert. 3 0 0 3 3 0 mt3 128!:9 (bxr 0 1 2);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow
NB. virtual row gets priority
M=. |: _4 ]\ 0. 1 1 0   1 0 0 0  0 0 1 0 0 0 0 1   NB. input by columns
bk =. 1. 1 1 1  NB. every row can pivot
Frow=. _4. _3 _2 _1 0  NB. improvements reduced col by col
assert. 0 0 1 4 12 _4 mt3 128!:9 (bxr 0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 1 2 3;1e_11 1e_6 0 0 1 1.0 _1;bk;Frow
assert. 0 1 0 2 8 __ mt3 128!:9 (bxr 0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 1 2 3;1e_11 1e_6 0 0 1 1.0 0;bk;Frow
assert. 0 0 1 1 4 __ mt3 128!:9 (bxr 0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 1 2 3;1e_11 1e_6 0 0 1 1.0 1;bk;Frow
assert. 0 2 2 3 9 __ mt3 128!:9 (bxr 0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 1 2 3;1e_11 1e_6 0 0 1 1.0 2;bk;Frow
assert. 0 2 2 3 10 __ mt025 128!:9 (bxr 0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;2 0 1 3;1e_11 1e_6 0 0 1 1.0 2;bk;Frow  NB. First row processes bk in order
assert. 0 0 2 2 8 __ mt025 128!:9 (bxr 1 0 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;2 0 1 3;1e_11 1e_6 0 0 1 1.0 2;bk;Frow
assert. 0 0 2 2 8 __ mt025 128!:9 (bxr 1 2 0 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;2 0 1 3;1e_11 1e_6 0 0 1 1.0 2;bk;Frow
M=. |: _4 ]\ 0. 1 1 0   1 0 1 0  0 0 0 1 0 0 0 1   NB. input by columns
assert. 0 1 0 2 8 __ mt3 128!:9 (bxr 0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 1 2 3;1e_11 1e_6 0 0 1 1.0 0;bk;Frow
M=. |: _4 ]\ 0. 1 1 0   1 0 2 0  0 0 0 1 0 0 0 1   NB. input by columns
assert. 0 0 1 4 15 _4 mt3 128!:9 (bxr 0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 1 2 3;1e_11 1e_6 0 0 1 1.0 0;bk;Frow  NB. later non-virtual doesn't get priority
NB. exclusion list
M=. |: _4 ]\ 1. 0 0 0   0 1 0 0   1. 0 0 0  1. 0 0 0   NB. input by columns
Frow=. _1. _5 _1 _1 0   NB. all improving
bk =. 4 $ 1.0  NB. all valid
bkg=.i.#M
assert. 0 1 1 4 10 _5 mt3 (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow;($00);(4 5 6 7)
assert. 0 1 1 4 10 _5 mt3 (128!:9) 3 0 1 2;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow;($00);(4 5 6 7)
assert. 0 0 0 4 11 _1 mt3 (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow;(,16b100000005);(4 5 6 7)  NB. The only pivot was excluded
Frow=. _1. _5 _2 _1 0   NB. all improving
assert. 0 2 0 4 14 _2 mt3 (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow;(,16b100000005);(4 5 6 7)  NB. The only pivot was excluded
M=. |: _4 ]\ 0. 0 0 1   0 2 1 0  1 0 0 0    1 0 0 0   NB. input by columns
assert. 0 2 0 4 14 _2 mt3 (128!:9) 0 1 2 3;(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;cons;bk;Frow;(,16b100000005);(4 5 6 7)  NB. Next pivot accepted
if. 0 do.  NB. no longer supported
NB. Zero Frow
M=. |: _4 ]\ _1. _1 2 1   _1 1 1 1    _1 _1 2 1e_13   1 1 _1 1   NB. 2 non0, 1 0; 2 non0, 2 0; only 1 non0 (c too small); 2 non0, 2 0 (close enough)
Frow=. ''   NB. rows are immaterial
bk =. _1e_13 1e_13 1 1  NB. bk in order
bkg=./: bk
assert. 2 0 2 0 4 1 mt3 128!:9 (bxr 0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 1e_11 0 1 1.0 _1;bk;Frow;($00);(4 5 6 7)  NB. 2 non0, 1 0
assert. 2 0 2 3 11 1 mt3 128!:9 (bxr 1 2 3 0);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 1e_11 0 1 1.0 _1;bk;Frow;($00);(4 5 6 7)  NB. 2 non0, 2 0
assert. 3 0 0 4 11 0 mt3 128!:9 (bxr 1 2 3 0);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;bkg;1e_11 1e_6 1e_11 0 1 1.0 _1;bk;Frow;(,16b000000006);(4 5 6 7)  NB. Pivot excluded
end.
NB. Dpiv
M=. |: _4 ]\ _1. 0 2 3  0 2 3 4  2 3 4 5  3 4 5 6    NB. 
Dpiv=. (1+#M) $ _1
assert. '' -: 128!:9 (bxr 0 1 2);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 1 2;1.0 0 0 0 0 0 0;'';'';Dpiv  NB. init
assert Dpiv -: 1 2 3 _1 _1
assert. '' -: 128!:9 (bxr 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;1 2 3;2.5 0 0 0 0 0 1;'';'';Dpiv  NB. add
assert Dpiv -: 1 4 6 2 _1
assert. '' -: 128!:9 (bxr 0 1 2 3);(,."1 (_2) ]\ 00 0);(0$00);(0$0.0);M;0 3;2.5 0 0 0 0 0 _1;'';'';Dpiv  NB. sub
assert Dpiv -: 0 3 5 0 _1


delth''  NB. make sure we end with an empty system

1
}}^:(+./ ('avx2';'avx512') +./@:E.&> <9!:14'') 1


NB. {y ------------------------------------------------------------------

randuni''

NB. Boolean
a =: 1=?(1+?10)$2
b =: 1=?(1+?10)$2
({a;b) -: a,&.>/b

NB. literal
a =: a.{~97+?(1+?10)$26
b =: a.{~97+?(1+?10)$26
({a;b) -: a,&.>/b

NB. literal2
a =: adot1{~97+?(1+?10)$26
b =: adot1{~97+?(1+?10)$26
({a;b) -: a,&.>/b

NB. literal4
a =: adot2{~97+?(1+?10)$26
b =: adot2{~97+?(1+?10)$26
({a;b) -: a,&.>/b

NB. symbol
a =: sdot0{~97+?(1+?10)$26
b =: sdot0{~97+?(1+?10)$26
({a;b) -: a,&.>/b

NB. integer
a =: _40+?(1+?10)$100
b =: _40+?(1+?10)$100
({a;b) -: a,&.>/b
(i.v) -: v#.>{i.&.>v =: >: ?7 7 7 7
(i.v) -: v#.>{i.&.>v =: >: ?7 7 7 7
(i.v) -: v#.>{i.&.>v =: >: ?7 7 7 7

NB. floating-point
a =: 0.1*_40+?(1+?10)$100
b =: 0.1*_40+?(1+?10)$100
({a;b) -: a,&.>/b

NB. complex
a =: ^0j0.1*_40+?(1+?10)$100
b =: ^0j0.1*_40+?(1+?10)$100
({a;b) -: a,&.>/b
b =: _40+?(1+?10)$100
({a;b) -: a,&.>/b

NB. boxed
a =: (1,}.0=?(#a)$4)<;.(1) a=:_40+?(1+?20)$100
b =: (1,}.0=?(#b)$4)<;.(1) b=:0.1*_40+?(1+?20)$100
({(<a),<b) -: a<@,"0/b

count   =: */@$@>
prod    =: */\.@}.@(,&1)
copy    =: */@[ $&> prod@[ (#,)&.> ]
catalog =: ;@:($&.>) $ count <"1@|:@copy ]

f =: { -: catalog

f 0 1;1=?2 3$6
f (3 4$'foobar');'lieben'
f (3 4$u:'foobar');u:'lieben'
f (3 4$10&u:'foobar');10&u:'lieben'
f (3 4$s:@<"0 'foobar');s:@<"0 'lieben'
f (?5$105);?2 3$10
f o.&.>(?5$105);2 3$10
f 3j4;5j6 7 8 9
f 0 1;2;3.4;5j6 7

'domain error' -: { etx 1 2 3; 'ab'
'domain error' -: { etx 1 2 3;~'ab'
'domain error' -: { etx 1 2 3; u:'ab'
'domain error' -: { etx 1 2 3;~u:'ab'
'domain error' -: { etx 1 2 3; 10&u:'ab'
'domain error' -: { etx 1 2 3;~10&u:'ab'
'domain error' -: { etx 1 2 3; s:@<"0 'ab'
'domain error' -: { etx 1 2 3;~s:@<"0 'ab'
'domain error' -: { etx 1 2 3; <<4 5
'domain error' -: { etx 1 2 3;~<<4 5
'domain error' -: { etx 'abc'; <<4 5
'domain error' -: { etx 'abc';~<<4 5


NB. x{y -----------------------------------------------------------------

a -: 0{a=:?2
a -: 0{a=:(?#a.){a.
a -: 0{a=:(?#adot1){adot1
a -: 0{a=:(?#adot2){adot2
a -: 0{a=:(?#sdot0){sdot0
a -: 0{a=:?1e9
a -: 0{a=:o.?1e9
a -: 0{a=:r.?1e7
a -: 0{a=:<?1e9

NB. Boolean
a=:1=?2 3 4$2
(|.a)      -: 1 0{a
(2{."1 a)  -: 0 1{"1 a
(_2{."2 a) -: _2 _1{"2 a
(($0)$,_1 _1 _1{.a) -: (<_1 _1 _1){a

p=:?(?(?4)$5)$2
q=:?(?(?4)$5)$3
r=:?(?(?4)$5)$4
i=:p;q;r
(;$&.>i)      -: $(<i){a
(($p),3 4)    -: $(<<p){a
(($p),($q),4) -: $(<p;q){a

NB. literal
a=:a.{~?2 3 4$256
(|.a)      -: 1 0{a
(2{."1 a)  -: 0 1{"1 a
(_2{."2 a) -: _2 _1{"2 a
(($0)$,_1 _1 _1{.a) -: (<_1 _1 _1){a

NB. literal2
a=:adot1{~?2 3 4$(#adot1)
(|.a)      -: 1 0{a
(2{."1 a)  -: 0 1{"1 a
(_2{."2 a) -: _2 _1{"2 a
(($0)$,_1 _1 _1{.a) -: (<_1 _1 _1){a

NB. literal4
a=:adot2{~?2 3 4$(#adot2)
(|.a)      -: 1 0{a
(2{."1 a)  -: 0 1{"1 a
(_2{."2 a) -: _2 _1{"2 a
(($0)$,_1 _1 _1{.a) -: (<_1 _1 _1){a

NB. symbol
a=:sdot0{~?2 3 4$(#sdot0)
(|.a)      -: 1 0{a
(2{."1 a)  -: 0 1{"1 a
(_2{."2 a) -: _2 _1{"2 a
(($0)$,_1 _1 _1{.a) -: (<_1 _1 _1){a

p=:?(?(?4)$5)$2
q=:?(?(?4)$5)$3
r=:?(?(?4)$5)$4
i=:p;q;r
(;$&.>i)      -: $(<i){a
(($p),3 4)    -: $(<<p){a
(($p),($q),4) -: $(<p;q){a

NB. integer
a=:?2 3 4$10000
(|.a)      -: 1 0{a
(2{."1 a)  -: 0 1{"1 a
(_2{."2 a) -: _2 _1{"2 a
(($0)$,_1 _1 _1{.a) -: (<_1 _1 _1){a

p=:?(?(?4)$5)$2
q=:?(?(?4)$5)$3
r=:?(?(?4)$5)$4
i=:p;q;r
(;$&.>i)      -: $(<i){a
(($p),3 4)    -: $(<<p){a
(($p),($q),4) -: $(<p;q){a

NB.2 3 -: 7{"1] 3 (<1 7)} 2 5e9$2
NB.usually not enough memory for ^^

NB. floating point
a=:o.?2 3 4$10000
(|.a)      -: 1 0{a
(2{."1 a)  -: 0 1{"1 a
(_2{."2 a) -: _2 _1{"2 a
(($0)$,_1 _1 _1{.a) -: (<_1 _1 _1){a

p=:?(?(?4)$5)$2
q=:?(?(?4)$5)$3
r=:?(?(?4)$5)$4
i=:p;q;r
(;$&.>i)      -: $(<i){a
(($p),3 4)    -: $(<<p){a
(($p),($q),4) -: $(<p;q){a

NB. complex
a=:^0j1*?2 3 4$200
(|.a)      -: 1 0{a
(2{."1 a)  -: 0 1{"1 a
(_2{."2 a) -: _2 _1{"2 a
(($0)$,_1 _1 _1{.a) -: (<_1 _1 _1){a

p=:?(?(?4)$5)$2
q=:?(?(?4)$5)$3
r=:?(?(?4)$5)$4
i=:p;q;r
(;$&.>i)      -: $(<i){a
(($p),3 4)    -: $(<<p){a
(($p),($q),4) -: $(<p;q){a

NB. boxed
a=:2 3 4$;:'(($p),($q),4)-:$(<p;q){a'
(|.a)      -: 1 0{a
(2{."1 a)  -: 0 1{"1 a
(_2{."2 a) -: _2 _1{"2 a
(($0)$,_1 _1 _1{.a) -: (<_1 _1 _1){a

p=:?(?(?4)$5)$2
q=:?(?(?4)$5)$3
r=:?(?(?4)$5)$4
i=:p;q;r
(;$&.>i)      -: $(<i){a
(($p),3 4)    -: $(<<p){a
(($p),($q),4) -: $(<p;q){a

(i.0 3 0 59) -: (i.0 3){i.(_1+2^31),0 59
(i.0   )     -: (<_1+1e9 2e9){i.1e9 2e9 0
(i.0 59)     -: (<_1+1e9 2e9){i.1e9 2e9 0 59
(i. 1e9 1e9 1e9 4 0 4) -: (0 1 2 1) {"3 i. 1e9 1e9 1e9 3 0 4

(i.2 0 3 4 5 6) -: (i.2 0 3){0 4 5 6$'abc'
(i.2 0 3 4 5 6) -: (i.2 0 3){0 4 5 6$u:'abc'
(i.2 0 3 4 5 6) -: (i.2 0 3){0 4 5 6$10&u:'abc'
(i.2 0 3 4 5 6) -: (i.2 0 3){0 4 5 6$s:@<"0 'abc'
(i.2 0 3 4 5 6) -: (i.2 0 3){0 4 5 6$4
(i.2 0 3 4 5 6) -: (i.2 0 3){0 4 5 6$0.5

(i.4 5 2 0 3 6) -: (i.2 0 3){"_ 2 [ 4 5 0 6$'abc'
(i.4 5 2 0 3 6) -: (i.2 0 3){"_ 2 [ 4 5 0 6$u:'abc'
(i.4 5 2 0 3 6) -: (i.2 0 3){"_ 2 [ 4 5 0 6$10&u:'abc'
(i.4 5 2 0 3 6) -: (i.2 0 3){"_ 2 [ 4 5 0 6$s:@<"0 'abc'
(i.4 5 2 0 3 6) -: (i.2 0 3){"_ 2 [ 4 5 0 6$4
(i.4 5 2 0 3 6) -: (i.2 0 3){"_ 2 [ 4 5 0 6$0.5

j -: x i. j{x [ j=:?~#x=: ~.a.{~?100 1$256
j -: x i. j{x [ j=:?~#x=: ~.a.{~?100 2$256
j -: x i. j{x [ j=:?~#x=: ~.a.{~?100 3$256
j -: x i. j{x [ j=:?~#x=: ~.a.{~?100 4$256
j -: x i. j{x [ j=:?~#x=: ~.a.{~?100 5$256
j -: x i. j{x [ j=:?~#x=: ~.a.{~?100 6$256
j -: x i. j{x [ j=:?~#x=: ~.a.{~?100 7$256
j -: x i. j{x [ j=:?~#x=: ~.a.{~?100 8$256
j -: x i. j{x [ j=:?~#x=: ~.a.{~?100 9$256

NB. scalar right arguments

x -: i{ x=: 0    [ i=: <i.0
x -: i{ x=: 'a'
x -: i{ x=: 2
x -: i{ x=: 2.5
x -: i{ x=: 2j5
x -: i{ x=: <2 3 4
x -: i{ x=: 2x

x -: i{ x=: 0    [ i=: <''
x -: i{ x=: 0    [ i=: <u:''
x -: i{ x=: 0    [ i=: <10&u:''
x -: i{ x=: 0    [ i=: <s:@<"0 ''
x -: i{ x=: 'a'
x -: i{ x=: u:'a'
x -: i{ x=: 10&u:'a'
x -: i{ x=: s:@<"0 'a'
x -: i{ x=: 2
x -: i{ x=: 2.5
x -: i{ x=: 2j5
x -: i{ x=: <2 3 4
x -: i{ x=: 2x

x -: i{ x=: 0    [ i=: <0$<i.12
x -: i{ x=: 'a'
x -: i{ x=: u:'a'
x -: i{ x=: 10&u:'a'
x -: i{ x=: s:@<"0 'a'
x -: i{ x=: 2
x -: i{ x=: 2.5
x -: i{ x=: 2j5
x -: i{ x=: <2 3 4
x -: i{ x=: 2x

'domain error' -: 3.5       { etx i.12                       
'domain error' -: 'abc'     { etx i.12
'domain error' -: (u:'abc')     { etx i.12
'domain error' -: (10&u:'abc')     { etx i.12
'domain error' -: (s:@<"0 'abc')     { etx i.12
'domain error' -: (<3.5)    { etx i.12
'domain error' -: (<0;'abc'){ etx i.3 4
'domain error' -: (<0;u:'abc'){ etx i.3 4
'domain error' -: (<0;10&u:'abc'){ etx i.3 4
'domain error' -: (<0;s:@<"0 'abc'){ etx i.3 4
'domain error' -: (<0;3.5)  { etx i.3 4

'length error' -: (<0 2)    { etx i.12
'length error' -: (<0;2)    { etx i.12

'index error'  -: 0         { etx 0 5$'abc'
'index error'  -: 0         { etx 0 5$u:'abc'
'index error'  -: 0         { etx 0 5$10&u:'abc'
'index error'  -: 0         { etx 0 5$s:@<"0 'abc'
'index error'  -: 0         { etx i.0 5
'index error'  -: 0         { etx o.i.0 5
'index error'  -: 2         { etx a=:1=?2 3 4$2                
'index error'  -: _3        { etx a                           
'index error'  -: (<0 _4 0) { etx a                    
'index error'  -: (<2 0)    { etx a                       

'index error'  -: 2         { etx a=:(?2 3 4$#a.){a.           
'index error'  -: 2         { etx a=:(?2 3 4$#adot1){adot1          
'index error'  -: 2         { etx a=:(?2 3 4$#adot2){adot2          
'index error'  -: 2         { etx a=:(?2 3 4$#sdot0){sdot0          
'index error'  -: _3        { etx a                           
'index error'  -: (<0 _4 0) { etx a                    
'index error'  -: (<2 0)    { etx a                       

'index error'  -: 2         { etx a=:?2 3 4$333                
'index error'  -: _3        { etx a                           
'index error'  -: (<0 _4 0) { etx a                    
'index error'  -: (<2 0)    { etx a

'index error'  -: 2         { etx a=:o.?2 3 4$333              
'index error'  -: _3        { etx a                           
'index error'  -: (<0 _4 0) { etx a                    
'index error'  -: (<2 0)    { etx a                       

'index error'  -: 2         { etx a=:^0j1*?2 3 4$33            
'index error'  -: _3        { etx a                           
'index error'  -: (<0 _4 0) { etx a                    
'index error'  -: (<2 0)    { etx a                       

'index error'  -: 2         { etx a=:2 3 4$3;'abc'             
'index error'  -: 2         { etx a=:2 3 4$3;u:'abc'             
'index error'  -: 2         { etx a=:2 3 4$3;10&u:'abc'             
'index error'  -: 2         { etx a=:2 3 4$3;s:@<"0 'abc'             
'index error'  -: _3        { etx a                           
'index error'  -: (<0 _4 0) { etx a                    
'index error'  -: (<2 0)    { etx a                       
'index error'  -:  (0 1 2 1) {"2 etx i. 1e9 1e9 1e9 3 0 4
'index error'  -:  (0) {"2 etx i. 1e9 1e9 1e9 3 0 4


NB. x{y boxed indices ---------------------------------------------------

fr =: 4 : '>{&.>/(<"0|.>x),<y'

(<i=:      <:s-?+:s) ({ -: fr) ?s$2          [ s=:2 3 4 7
(<i=:      <:s-?+:s) ({ -: fr) a.{~?s$#a.    [ s=:2 3 4 7 11
(<i=:      <:s-?+:s) ({ -: fr) adot1{~?s$#adot1    [ s=:2 3 4 7 11
(<i=:      <:s-?+:s) ({ -: fr) adot2{~?s$#adot2    [ s=:2 3 4 7 11
(<i=:      <:s-?+:s) ({ -: fr) sdot0{~?s$#sdot0    [ s=:2 3 4 7 11
(<i=:      <:s-?+:s) ({ -: fr)   _1e6+?s$2e6 [ s=:2 5 1 7 1 1
(<i=:      <:s-?+:s) ({ -: fr) o._1e6+?s$2e6 [ s=:2 1 5 1 1 7 3
(<i=:      <:s-?+:s) ({ -: fr) r._1e6+?s$2e6 [ s=:1 2 5 1 1 1 1 7
(<1 2;1 2) ({ -: }."1@}.@]) 2r5+i. 3 3  NB. failed in 32-bit because cell is 8 bytes long
(<i=:      <:s-?+:s) ({ -: fr) <"0?s$1e8     [ s=:2 3 4 7 1 1
 
(<i=:    }:<:s-?+:s) ({ -: fr) ?s$2          [ s=:2 3 4 7
(<i=:    }:<:s-?+:s) ({ -: fr) a.{~?s$#a.    [ s=:2 3 4 7 11
(<i=:    }:<:s-?+:s) ({ -: fr) adot1{~?s$#adot1    [ s=:2 3 4 7 11
(<i=:    }:<:s-?+:s) ({ -: fr) adot2{~?s$#adot2    [ s=:2 3 4 7 11
(<i=:    }:<:s-?+:s) ({ -: fr) sdot0{~?s$#sdot0    [ s=:2 3 4 7 11
(<i=:    }:<:s-?+:s) ({ -: fr)   _1e6+?s$2e6 [ s=:2 5 1 7 1 1
(<i=:    }:<:s-?+:s) ({ -: fr) o._1e6+?s$2e6 [ s=:2 1 5 1 1 7 3
(<i=:    }:<:s-?+:s) ({ -: fr) r._1e6+?s$2e6 [ s=:1 2 5 1 1 1 1 7
(<i=:    }:<:s-?+:s) ({ -: fr) <"0?s$1e8     [ s=:2 3 4 7 1 1
 
(<i=:<"0   <:s-?+:s) ({ -: fr) ?s$2          [ s=:2 3 4 7
(<i=:<"0   <:s-?+:s) ({ -: fr) a.{~?s$#a.    [ s=:2 3 4 7 11
(<i=:<"0   <:s-?+:s) ({ -: fr) adot1{~?s$#adot1    [ s=:2 3 4 7 11
(<i=:<"0   <:s-?+:s) ({ -: fr) adot2{~?s$#adot2    [ s=:2 3 4 7 11
(<i=:<"0   <:s-?+:s) ({ -: fr) sdot0{~?s$#sdot0    [ s=:2 3 4 7 11
(<i=:<"0   <:s-?+:s) ({ -: fr)   _1e6+?s$2e6 [ s=:2 5 1 7 1 1
(<i=:<"0   <:s-?+:s) ({ -: fr) o._1e6+?s$2e6 [ s=:2 1 5 1 1 7 3
(<i=:<"0   <:s-?+:s) ({ -: fr) r._1e6+?s$2e6 [ s=:1 2 5 1 1 1 1 7
(<i=:<"0   <:s-?+:s) ({ -: fr) <"0?s$1e8     [ s=:2 3 4 7 1 1
 
(<i=:<"0 }:<:s-?+:s) ({ -: fr) ?s$2          [ s=:2 3 4 7
(<i=:<"0 }:<:s-?+:s) ({ -: fr) a.{~?s$#a.    [ s=:2 3 4 7 11
(<i=:<"0 }:<:s-?+:s) ({ -: fr) adot1{~?s$#adot1    [ s=:2 3 4 7 11
(<i=:<"0 }:<:s-?+:s) ({ -: fr) adot2{~?s$#adot2    [ s=:2 3 4 7 11
(<i=:<"0 }:<:s-?+:s) ({ -: fr) sdot0{~?s$#sdot0    [ s=:2 3 4 7 11
(<i=:<"0 }:<:s-?+:s) ({ -: fr)   _1e6+?s$2e6 [ s=:2 5 1 7 1 1
(<i=:<"0 }:<:s-?+:s) ({ -: fr) o._1e6+?s$2e6 [ s=:2 1 5 1 1 7 3
(<i=:<"0 }:<:s-?+:s) ({ -: fr) r._1e6+?s$2e6 [ s=:1 2 5 1 1 1 1 7
(<i=:<"0 }:<:s-?+:s) ({ -: fr) <"0?s$1e8     [ s=:2 3 4 7 1 1

x -: (<i.&.>4{.$x){x=:?2 3 4 5$1e6 
x -: (<i.&.>3{.$x){x
x -: (<i.&.>2{.$x){x
x -: (<i.&.>1{.$x){x
x -: (<i.&.>0{.$x){x

(|.|."_1 |."_2 |."_3 x) -: (<i.&.>-4{.$x){x=:?2 3 4 5$2
(|.|."_1 |."_2       x) -: (<i.&.>-3{.$x){x
(|.|."_1             x) -: (<i.&.>-2{.$x){x
(|.                  x) -: (<i.&.>-1{.$x){x

NB. literal
jot=:<$0
x=:(?3 4 5 7$#a){a=:'supercalifragilisticexpialidocious !@#$'
((<i; j         ){x) -: i{      j{"_ _1 x [ i=:?2 3$3 [ j=:?7 1 1$4
((<i; j; <a:    ){x) -: i{      j{"_ _1 x [ i=:?2 3$3 [ j=:?7 1 1$4
((<i; j; a:;<a: ){x) -: i{      j{"_ _1 x [ i=:?2 3$3 [ j=:?7 1 1$4
((<i; a:;j      ){x) -: i{      j{"_ _2 x [ i=:?23 $3 [ j=:?1 17 $5
((<i; a:;j; <a: ){x) -: i{      j{"_ _2 x [ i=:?23 $3 [ j=:?1 17 $5
((<i; a:;a:;j   ){x) -: i{      j{"_ _3 x [ i=:?2 3$3 [ j=:?23   $7
((<a:;i; j      ){x) -: i{"_ _1 j{"_ _2 x [ i=:?2 3$4 [ j=:?17   $5
((<a:;i; j; <a: ){x) -: i{"_ _1 j{"_ _2 x [ i=:?2 3$4 [ j=:?17 2 $5
((<a:;i; a:;j   ){x) -: i{"_ _1 j{"_ _3 x [ i=:?2 3$4 [ j=:?1 7 2$7
((<a:;a:;i; j   ){x) -: i{"_ _2 j{"_ _3 x [ i=:?23 $5 [ j=:?2 11 $7

i=:?&.(+&n)2 3 $n=:0{$x
j=:?&.(+&n)57  $n=:1{$x
k=:?&.(+&n)1 11$n=:2{$x
l=:?&.(+&n)13  $n=:3{$x
((<i;j;k;l){x) -: i{j{"_ _1 k{"_ _2 l{"_ _3 x
((<i;j;k  ){x) -: i{j{"_ _1 k{"_ _2         x
((<i;j    ){x) -: i{j{"_ _1                 x
((<<i     ){x) -: i{                        x

((<0 1)|:x) -: (,&.>~i.#x){x=:?15 15$10000

NB. literal2
jot=:<$0
x=:(?3 4 5 7$#a){a=:u:'supercalifragilisticexpialidocious !@#$'
((<i; j         ){x) -: i{      j{"_ _1 x [ i=:?2 3$3 [ j=:?7 1 1$4
((<i; j; <a:    ){x) -: i{      j{"_ _1 x [ i=:?2 3$3 [ j=:?7 1 1$4
((<i; j; a:;<a: ){x) -: i{      j{"_ _1 x [ i=:?2 3$3 [ j=:?7 1 1$4
((<i; a:;j      ){x) -: i{      j{"_ _2 x [ i=:?23 $3 [ j=:?1 17 $5
((<i; a:;j; <a: ){x) -: i{      j{"_ _2 x [ i=:?23 $3 [ j=:?1 17 $5
((<i; a:;a:;j   ){x) -: i{      j{"_ _3 x [ i=:?2 3$3 [ j=:?23   $7
((<a:;i; j      ){x) -: i{"_ _1 j{"_ _2 x [ i=:?2 3$4 [ j=:?17   $5
((<a:;i; j; <a: ){x) -: i{"_ _1 j{"_ _2 x [ i=:?2 3$4 [ j=:?17 2 $5
((<a:;i; a:;j   ){x) -: i{"_ _1 j{"_ _3 x [ i=:?2 3$4 [ j=:?1 7 2$7
((<a:;a:;i; j   ){x) -: i{"_ _2 j{"_ _3 x [ i=:?23 $5 [ j=:?2 11 $7

i=:?&.(+&n)2 3 $n=:0{$x
j=:?&.(+&n)57  $n=:1{$x
k=:?&.(+&n)1 11$n=:2{$x
l=:?&.(+&n)13  $n=:3{$x
((<i;j;k;l){x) -: i{j{"_ _1 k{"_ _2 l{"_ _3 x
((<i;j;k  ){x) -: i{j{"_ _1 k{"_ _2         x
((<i;j    ){x) -: i{j{"_ _1                 x
((<<i     ){x) -: i{                        x

((<0 1)|:x) -: (,&.>~i.#x){x=:?15 15$10000

NB. literal4
jot=:<$0
x=:(?3 4 5 7$#a){a=:10&u:'supercalifragilisticexpialidocious !@#$'
((<i; j         ){x) -: i{      j{"_ _1 x [ i=:?2 3$3 [ j=:?7 1 1$4
((<i; j; <a:    ){x) -: i{      j{"_ _1 x [ i=:?2 3$3 [ j=:?7 1 1$4
((<i; j; a:;<a: ){x) -: i{      j{"_ _1 x [ i=:?2 3$3 [ j=:?7 1 1$4
((<i; a:;j      ){x) -: i{      j{"_ _2 x [ i=:?23 $3 [ j=:?1 17 $5
((<i; a:;j; <a: ){x) -: i{      j{"_ _2 x [ i=:?23 $3 [ j=:?1 17 $5
((<i; a:;a:;j   ){x) -: i{      j{"_ _3 x [ i=:?2 3$3 [ j=:?23   $7
((<a:;i; j      ){x) -: i{"_ _1 j{"_ _2 x [ i=:?2 3$4 [ j=:?17   $5
((<a:;i; j; <a: ){x) -: i{"_ _1 j{"_ _2 x [ i=:?2 3$4 [ j=:?17 2 $5
((<a:;i; a:;j   ){x) -: i{"_ _1 j{"_ _3 x [ i=:?2 3$4 [ j=:?1 7 2$7
((<a:;a:;i; j   ){x) -: i{"_ _2 j{"_ _3 x [ i=:?23 $5 [ j=:?2 11 $7

i=:?&.(+&n)2 3 $n=:0{$x
j=:?&.(+&n)57  $n=:1{$x
k=:?&.(+&n)1 11$n=:2{$x
l=:?&.(+&n)13  $n=:3{$x
((<i;j;k;l){x) -: i{j{"_ _1 k{"_ _2 l{"_ _3 x
((<i;j;k  ){x) -: i{j{"_ _1 k{"_ _2         x
((<i;j    ){x) -: i{j{"_ _1                 x
((<<i     ){x) -: i{                        x

((<0 1)|:x) -: (,&.>~i.#x){x=:?15 15$10000

NB. symbol
jot=:<$0
x=:(?3 4 5 7$#a){a=:s:@<"0 'supercalifragilisticexpialidocious !@#$'
((<i; j         ){x) -: i{      j{"_ _1 x [ i=:?2 3$3 [ j=:?7 1 1$4
((<i; j; <a:    ){x) -: i{      j{"_ _1 x [ i=:?2 3$3 [ j=:?7 1 1$4
((<i; j; a:;<a: ){x) -: i{      j{"_ _1 x [ i=:?2 3$3 [ j=:?7 1 1$4
((<i; a:;j      ){x) -: i{      j{"_ _2 x [ i=:?23 $3 [ j=:?1 17 $5
((<i; a:;j; <a: ){x) -: i{      j{"_ _2 x [ i=:?23 $3 [ j=:?1 17 $5
((<i; a:;a:;j   ){x) -: i{      j{"_ _3 x [ i=:?2 3$3 [ j=:?23   $7
((<a:;i; j      ){x) -: i{"_ _1 j{"_ _2 x [ i=:?2 3$4 [ j=:?17   $5
((<a:;i; j; <a: ){x) -: i{"_ _1 j{"_ _2 x [ i=:?2 3$4 [ j=:?17 2 $5
((<a:;i; a:;j   ){x) -: i{"_ _1 j{"_ _3 x [ i=:?2 3$4 [ j=:?1 7 2$7
((<a:;a:;i; j   ){x) -: i{"_ _2 j{"_ _3 x [ i=:?23 $5 [ j=:?2 11 $7

i=:?&.(+&n)2 3 $n=:0{$x
j=:?&.(+&n)57  $n=:1{$x
k=:?&.(+&n)1 11$n=:2{$x
l=:?&.(+&n)13  $n=:3{$x
((<i;j;k;l){x) -: i{j{"_ _1 k{"_ _2 l{"_ _3 x
((<i;j;k  ){x) -: i{j{"_ _1 k{"_ _2         x
((<i;j    ){x) -: i{j{"_ _1                 x
((<<i     ){x) -: i{                        x

((<0 1)|:x) -: (,&.>~i.#x){x=:?15 15$10000


NB. i{y integer indices -------------------------------------------------

fr =: 4 : '((x**/s)+/i.s=.}.$y){,y'

i -: (i=:?2 3 4$1000) {  y=:i.1000
i -: (i=:?2 3 4$1000) fr y=:i.1000

(?100  $#y) ({ -: fr) y=:?200   $2
(?100  $#y) ({ -: fr) y=:?200  3$2
(?100  $#y) ({ -: fr) y=:?200 10$2
(?100  $#y) ({ -: fr) y=:?200 21$2
(?100 8$#y) ({ -: fr) y=:?200   $2
(?100 8$#y) ({ -: fr) y=:?200  3$2
(?100 8$#y) ({ -: fr) y=:?200 10$2
(?100 8$#y) ({ -: fr) y=:?200 21$2

(?100  $#y) ({ -: fr) y=:(?20   $256){a.
(?100  $#y) ({ -: fr) y=:(?20  3$256){a.
(?100  $#y) ({ -: fr) y=:(?20 10$256){a.
(?100  $#y) ({ -: fr) y=:(?20 21$256){a.
(?100 9$#y) ({ -: fr) y=:(?20   $256){a.
(?100 9$#y) ({ -: fr) y=:(?20  3$256){a.
(?100 9$#y) ({ -: fr) y=:(?20 10$256){a.
(?100 9$#y) ({ -: fr) y=:(?20 21$256){a.

(?100  $#y) ({ -: fr) y=:(?20   $(#adot1)){adot1
(?100  $#y) ({ -: fr) y=:(?20  3$(#adot1)){adot1
(?100  $#y) ({ -: fr) y=:(?20 10$(#adot1)){adot1
(?100  $#y) ({ -: fr) y=:(?20 21$(#adot1)){adot1
(?100 9$#y) ({ -: fr) y=:(?20   $(#adot1)){adot1
(?100 9$#y) ({ -: fr) y=:(?20  3$(#adot1)){adot1
(?100 9$#y) ({ -: fr) y=:(?20 10$(#adot1)){adot1
(?100 9$#y) ({ -: fr) y=:(?20 21$(#adot1)){adot1

(?100  $#y) ({ -: fr) y=:(?20   $(#adot2)){adot2
(?100  $#y) ({ -: fr) y=:(?20  3$(#adot2)){adot2
(?100  $#y) ({ -: fr) y=:(?20 10$(#adot2)){adot2
(?100  $#y) ({ -: fr) y=:(?20 21$(#adot2)){adot2
(?100 9$#y) ({ -: fr) y=:(?20   $(#adot2)){adot2
(?100 9$#y) ({ -: fr) y=:(?20  3$(#adot2)){adot2
(?100 9$#y) ({ -: fr) y=:(?20 10$(#adot2)){adot2
(?100 9$#y) ({ -: fr) y=:(?20 21$(#adot2)){adot2

(?100  $#y) ({ -: fr) y=:(?20   $(#sdot0)){sdot0
(?100  $#y) ({ -: fr) y=:(?20  3$(#sdot0)){sdot0
(?100  $#y) ({ -: fr) y=:(?20 10$(#sdot0)){sdot0
(?100  $#y) ({ -: fr) y=:(?20 21$(#sdot0)){sdot0
(?100 9$#y) ({ -: fr) y=:(?20   $(#sdot0)){sdot0
(?100 9$#y) ({ -: fr) y=:(?20  3$(#sdot0)){sdot0
(?100 9$#y) ({ -: fr) y=:(?20 10$(#sdot0)){sdot0
(?100 9$#y) ({ -: fr) y=:(?20 21$(#sdot0)){sdot0

(?101  $#y) ({ -: fr) y=:?20   $29999
(?101  $#y) ({ -: fr) y=:?20  3$29999
(?101  $#y) ({ -: fr) y=:?20 10$29999
(?101  $#y) ({ -: fr) y=:?20 21$29999
(?101 7$#y) ({ -: fr) y=:?20   $29999
(?101 7$#y) ({ -: fr) y=:?20  3$29999
(?101 7$#y) ({ -: fr) y=:?20 10$29999
(?101 7$#y) ({ -: fr) y=:?20 21$29999
                                  
(?101  $#y) ({ -: fr) y=:o.?20   $29999
(?101  $#y) ({ -: fr) y=:o.?20  2$29999
(?101  $#y) ({ -: fr) y=:o.?20  5$29999
(?101  $#y) ({ -: fr) y=:o.?20 11$29999
(?101 7$#y) ({ -: fr) y=:o.?20   $29999
(?101 7$#y) ({ -: fr) y=:o.?20  2$29999
(?101 7$#y) ({ -: fr) y=:o.?20  5$29999
(?101 7$#y) ({ -: fr) y=:o.?20 11$29999

(?101  $#y) ({ -: fr) y=:r.?25   $29999
(?101  $#y) ({ -: fr) y=:r.?25  2$29999
(?101  $#y) ({ -: fr) y=:r.?25  5$29999
(?101  $#y) ({ -: fr) y=:r.?25  7$29999
(?101 7$#y) ({ -: fr) y=:r.?25   $29999
(?101 7$#y) ({ -: fr) y=:r.?25  2$29999
(?101 7$#y) ({ -: fr) y=:r.?25  5$29999
(?101 7$#y) ({ -: fr) y=:r.?25  7$29999
                                 
(?100  $#y) ({ -: fr) y=:(?23   $25){25$;:'opposable thumbs!'
(?100  $#y) ({ -: fr) y=:(?23   $25){25$(u:&.>) ;:'opposable thumbs!'
(?100  $#y) ({ -: fr) y=:(?23   $25){25$(10&u:&.>) ;:'opposable thumbs!'
(?100  $#y) ({ -: fr) y=:(?23   $25){25$s:@<"0&.> ;:'opposable thumbs!'
(?100  $#y) ({ -: fr) y=:(?23   $25){25$<"0@s: ;:'opposable thumbs!'
(?100  $#y) ({ -: fr) y=:(?23  3$25){25$;:'+/i.1 2$a.'
(?100  $#y) ({ -: fr) y=:(?23  3$25){25$(u:&.>) ;:'+/i.1 2$a.'
(?100  $#y) ({ -: fr) y=:(?23  3$25){25$(10&u:&.>) ;:'+/i.1 2$a.'
(?100  $#y) ({ -: fr) y=:(?23  3$25){25$s:@<"0&.> ;:'+/i.1 2$a.'
(?100  $#y) ({ -: fr) y=:(?23  3$25){25$<"0@s: ;:'+/i.1 2$a.'
(?100  $#y) ({ -: fr) y=:(?23 10$25){<"0?25$11234
(?100  $#y) ({ -: fr) y=:(?23 21$25){;/?25$12355
(?100 9$#y) ({ -: fr) y=:(?23   $25){;/o.?25$12345
(?100 9$#y) ({ -: fr) y=:(?23  3$25){;/r.?25$12355
(?100 9$#y) ({ -: fr) y=:(?23 10$25){;/j.?25$10000
(?100 9$#y) ({ -: fr) y=:(?23 21$25){;/o.?25$23145

'index error' -: (2-2){   etx i.0
'index error' -: (2-2){   etx ''
'index error' -: (2-2){   etx u:''
'index error' -: (2-2){   etx 10&u:''
'index error' -: (2-2){   etx s:''
'index error' -: (2-2){   etx 0 2 3$a:
'index error' -: (2-2){"1 etx     i.4 0
'index error' -: (2-2){"1 etx a.{~i.4 0

NB. for '' { i. 0 3 bug fix (,0) -: $ '' { i. 0 3
NB. for '' { i. 0 3 bug fix (,0) -: $ (0$0) { i. 0 3
NB. for '' { i. 0 3 bug fix (,0) -: $ (0$4) { i. 0 3

NB. x{"r y --------------------------------------------------------------

from =: 4 : 'x{y'

(?100$5) ({"1 -: from"1) ?67 5$2
(?100$5) ({"1 -: from"1) (?67 5$#x){x=:'sesquipedalian milquetoast'
(?100$5) ({"1 -: from"1) (?67 5$#x){x=:u:'sesquipedalian milquetoast'
(?100$5) ({"1 -: from"1) (?67 5$#x){x=:10&u:'sesquipedalian milquetoast'
(?100$5) ({"1 -: from"1) (?67 5$#x){x=:s:@<"0 'sesquipedalian milquetoast'
(?100$5) ({"1 -: from"1) _1e6+?67 5$2e6
(?100$5) ({"1 -: from"1) o._1e6+?67 5$2e6
(?100$5) ({"1 -: from"1) r._1e6+?67 5$2e6
(?100$5) ({"1 -: from"1) (?67 5$#x){x=:1;2;3;4;;:'quidnunc quinquagenarian 2e6'
(?100$5) ({"1 -: from"1) (?67 5$#x){x=:1;2;3;4;(u:&.>) ;:'quidnunc quinquagenarian 2e6'
(?100$5) ({"1 -: from"1) (?67 5$#x){x=:1;2;3;4;(10&u:&.>) ;:'quidnunc quinquagenarian 2e6'
(?100$5) ({"1 -: from"1) (?67 5$#x){x=:1;2;3;4;s:@<"0&.> (10&u:&.>) ;:'quidnunc quinquagenarian 2e6'
(?100$5) ({"1 -: from"1) (?67 5$#x){x=:1;2;3;4;<"0@s: (10&u:&.>) ;:'quidnunc quinquagenarian 2e6'

(_5+?100$10) ({"1 -: from"1) ?67 5$2
(_5+?100$10) ({"1 -: from"1) (?67 5$#x){x=:'boustrophedonic'
(_5+?100$10) ({"1 -: from"1) (?67 5$#x){x=:u:'boustrophedonic'
(_5+?100$10) ({"1 -: from"1) (?67 5$#x){x=:10&u:'boustrophedonic'
(_5+?100$10) ({"1 -: from"1) (?67 5$#x){x=:s:@<"0 'boustrophedonic'
(_5+?100$10) ({"1 -: from"1) _1e6+?67 5$2e6
(_5+?100$10) ({"1 -: from"1) o._1e6+?67 5$2e6
(_5+?100$10) ({"1 -: from"1) r._1e6+?67 5$2e6
(_5+?100$10) ({"1 -: from"1) (?67 5$#x){x=:1;2;3;4;;:'miasma eleemosynary gruntlement'
(_5+?100$10) ({"1 -: from"1) (?67 5$#x){x=:1;2;3;4;(u:&.>) ;:'miasma eleemosynary gruntlement'
(_5+?100$10) ({"1 -: from"1) (?67 5$#x){x=:1;2;3;4;(10&u:&.>) ;:'miasma eleemosynary gruntlement'
(_5+?100$10) ({"1 -: from"1) (?67 5$#x){x=:1;2;3;4;s:@<"0&.> ;:'miasma eleemosynary gruntlement'
(_5+?100$10) ({"1 -: from"1) (?67 5$#x){x=:1;2;3;4;<"0@s: ;:'miasma eleemosynary gruntlement'

(_5+?100$10) ({"1 -: from"1) ?3 67 5$2
(_5+?100$10) ({"1 -: from"1) (?3 67 5$#x){x=:'onomatopoeia'
(_5+?100$10) ({"1 -: from"1) (?3 67 5$#x){x=:u:'onomatopoeia'
(_5+?100$10) ({"1 -: from"1) (?3 67 5$#x){x=:10&u:'onomatopoeia'
(_5+?100$10) ({"1 -: from"1) (?3 67 5$#x){x=:s:@<"0 'onomatopoeia'
(_5+?100$10) ({"1 -: from"1) _1e6+?3 67 5$2e6
(_5+?100$10) ({"1 -: from"1) o._1e6+?3 67 5$2e6
(_5+?100$10) ({"1 -: from"1) r._1e6+?3  7 5$2e6
(_5+?100$10) ({"1 -: from"1) (?3 67 5$#x){x=:[&.>'supercalifragilisticexpialidocious'
(_5+?100$10) ({"1 -: from"1) (?3 67 5$#x){x=:[&.>u:'supercalifragilisticexpialidocious'
(_5+?100$10) ({"1 -: from"1) (?3 67 5$#x){x=:[&.>10&u:'supercalifragilisticexpialidocious'
(_5+?100$10) ({"1 -: from"1) (?3 67 5$#x){x=:[&.>s:@<"0 'supercalifragilisticexpialidocious'

(_67+?100$134) ({"2 -: from"2) ?3 67 5$2
(_67+?100$134) ({"2 -: from"2) (?3 67 5$#x){x=:'quotidian'
(_67+?100$134) ({"2 -: from"2) (?3 67 5$#x){x=:u:'quotidian'
(_67+?100$134) ({"2 -: from"2) (?3 67 5$#x){x=:10&u:'quotidian'
(_67+?100$134) ({"2 -: from"2) (?3 67 5$#x){x=:s:@<"0 'quotidian'
(_67+?100$134) ({"2 -: from"2) _1e6+?3 67 5$2e6
(_67+?100$134) ({"2 -: from"2) o._1e6+?3 67 5$2e6
(_7 +?100$ 14) ({"2 -: from"2) r._1e6+?3  7 5$2e6
(_67+?100$134) ({"2 -: from"2) <"0?3 67 5$3e6

(_5+?7 11$10) ({"_ 1 -: from"_ 1) ?67 5$2
(_5+?7 11$10) ({"_ 1 -: from"_ 1) (?67 5$#x){x=:'rhematic hoplite'
(_5+?7 11$10) ({"_ 1 -: from"_ 1) (?67 5$#x){x=:u:'rhematic hoplite'
(_5+?7 11$10) ({"_ 1 -: from"_ 1) (?67 5$#x){x=:10&u:'rhematic hoplite'
(_5+?7 11$10) ({"_ 1 -: from"_ 1) (?67 5$#x){x=:s:@<"0 'rhematic hoplite'
(_5+?7 11$10) ({"_ 1 -: from"_ 1) _1e6+?67 5$2e6
(_5+?7 11$10) ({"_ 1 -: from"_ 1) o._1e6+?67 5$2e6
(_5+?7 11$10) ({"_ 1 -: from"_ 1) r._1e6+? 7 5$2e6
(_5+?7 11$10) ({"_ 1 -: from"_ 1) (?67 5$#x){x=:;:'Cogito, ergo sum.'
(_5+?7 11$10) ({"_ 1 -: from"_ 1) (?67 5$#x){x=:(u:&.>) ;:'Cogito, ergo sum.'
(_5+?7 11$10) ({"_ 1 -: from"_ 1) (?67 5$#x){x=:(10&u:&.>) ;:'Cogito, ergo sum.'
(_5+?7 11$10) ({"_ 1 -: from"_ 1) (?67 5$#x){x=:s:@<"0&.> ;:'Cogito, ergo sum.'
(_5+?7 11$10) ({"_ 1 -: from"_ 1) (?67 5$#x){x=:<"0@s: ;:'Cogito, ergo sum.'

(_5+?67$10) ({"_1 -: from"_1) ?67 5$2
(_5+?67$10) ({"_1 -: from"_1) (?67 5$#x){x=:'tetragrammaton'
(_5+?67$10) ({"_1 -: from"_1) (?67 5$#x){x=:u:'tetragrammaton'
(_5+?67$10) ({"_1 -: from"_1) (?67 5$#x){x=:10&u:'tetragrammaton'
(_5+?67$10) ({"_1 -: from"_1) (?67 5$#x){x=:s:@<"0 'tetragrammaton'
(_5+?67$10) ({"_1 -: from"_1) _1e6+?67 5$2e6
(_5+?67$10) ({"_1 -: from"_1) o._1e6+?67 5$2e6
(_5+? 7$10) ({"_1 -: from"_1) r._1e6+? 7 5$2e6
(_5+?67$10) ({"_1 -: from"_1) (?67 5$#x){x=:1;2;3;;:'4 chthonic thalassic amanuensis'
(_5+?67$10) ({"_1 -: from"_1) (?67 5$#x){x=:1;2;3;(u:&.>) ;:'4 chthonic thalassic amanuensis'
(_5+?67$10) ({"_1 -: from"_1) (?67 5$#x){x=:1;2;3;(10&u:&.>) ;:'4 chthonic thalassic amanuensis'
(_5+?67$10) ({"_1 -: from"_1) (?67 5$#x){x=:1;2;3;s:@<"0&.> ;:'4 chthonic thalassic amanuensis'
(_5+?67$10) ({"_1 -: from"_1) (?67 5$#x){x=:1;2;3;<"0@s: ;:'4 chthonic thalassic amanuensis'

(<2) ({"1 -: from"1) x=:?4 5$2
(<2) ({"1 -: from"1) x=:a.{~?4 5$#a.
(<2) ({"1 -: from"1) x=:adot1{~?4 5$#adot1
(<2) ({"1 -: from"1) x=:adot1{~?4 5$#adot1
(<2) ({"1 -: from"1) x=:sdot0{~?4 5$#sdot0
(<2) ({"1 -: from"1) x=:?4 5$100
(<2) ({"1 -: from"1) x=:o.?4 5$100
(<2) ({"1 -: from"1) x=:j./?2 4 5$100

(<2) ({"2 -: from"2) x=:?3 4 5$2
(<2) ({"2 -: from"2) x=:a.{~?3 4 5$#a.
(<2) ({"2 -: from"2) x=:adot1{~?3 4 5$#adot1
(<2) ({"2 -: from"2) x=:adot2{~?3 4 5$#adot2
(<2) ({"2 -: from"2) x=:sdot0{~?3 4 5$#sdot0
(<2) ({"2 -: from"2) x=:?3 4 5$100
(<2) ({"2 -: from"2) x=:o.?3 4 5$100
(<2) ({"2 -: from"2) x=:j./?2 3 4 5$100

(<2 1) ({"2 -: from"2) x=:?3 4 5$2
(<2 1) ({"2 -: from"2) x=:a.{~?3 4 5$#a.
(<2 1) ({"2 -: from"2) x=:adot1{~?3 4 5$#adot1
(<2 1) ({"2 -: from"2) x=:adot2{~?3 4 5$#adot2
(<2 1) ({"2 -: from"2) x=:sdot0{~?3 4 5$#sdot0
(<2 1) ({"2 -: from"2) x=:?3 4 5$1000
(<2 1) ({"2 -: from"2) x=:o.?3 4 5$1000
(<2 1) ({"2 -: from"2) x=:j./?2 3 4 5$1000

(<<<2 1) ({"1 -: from"1) x=:?4 5$2
(<<<2 1) ({"1 -: from"1) x=:a.{~?4 5$#a.
(<<<2 1) ({"1 -: from"1) x=:adot1{~?4 5$#adot1
(<<<2 1) ({"1 -: from"1) x=:adot2{~?4 5$#adot2
(<<<2 1) ({"1 -: from"1) x=:sdot0{~?4 5$#sdot0
(<<<2 1) ({"1 -: from"1) x=:?4 5$1000
(<<<2 1) ({"1 -: from"1) x=:o.?4 5$1000
(<<<2 1) ({"1 -: from"1) x=:j./?2 4 5$1000

(6$&><"0 x) -: (6$0){"_ 0 x=:?4 5$2
(6$&><"0 x) -: (6$0){"_ 0 x=:(?4 5$#x){x=:'archipelago'
(6$&><"0 x) -: (6$0){"_ 0 x=:(?4 5$#x){x=:u:'archipelago'
(6$&><"0 x) -: (6$0){"_ 0 x=:(?4 5$#x){x=:10&u:'archipelago'
(6$&><"0 x) -: (6$0){"_ 0 x=:(?4 5$#x){x=:s:@<"0 'archipelago'
(6$&><"0 x) -: (6$0){"_ 0 x=:?4 5$1000
(6$&><"0 x) -: (6$0){"_ 0 x=:o.?4 5$1000
(6$&><"0 x) -: (6$0){"_ 0 x=:r.?4 5$1000
(6$&><"0 x) -: (6$0){"_ 0 x=:<"0?4 5$1000

(1 2;2 1)          ({"2 -: from"2) x=:?3 4 5$1000
(<1 2)             ({"2 -: from"2) x
(<"1 ?3   6 2$4 5) ({"2 -: from"2) x
(<"1 ?3   6 1$4  ) ({"2 -: from"2) x
(<"1 ?3 7 6 2$4 5) ({"2 -: from"2) x
(<"1 ?3 7 6 1$4  ) ({"2 -: from"2) x

NB. different langths of {"1
(100?@$75) (?@$&100@[ ({"1 -: from"1) ])"0 _ o._1e6+?12 100$2e6
(100?@$75) ((_10 + ?@$&100@[) ({"1 -: from"1) ])"0 _ o._1e6+?12 100$2e6

(0 4$'') -: (i.0 4){"1 'abc'

NB. for '' { i. 0 3 bug fix (,3) -: $ '' {"2 i. 3 0 3
NB. for '' { i. 0 3 bug fix (,3) -: $ (0$0) { i. 3 0 3
NB. for '' { i. 0 3 bug fix (,3) -: $ (0$4) { i. 3 0 3
NB. for '' { i. 0 3 bug fix (3 2 0) -: $ (2 0$' ') {"2 i. 3 0 3
NB. for '' { i. 0 3 bug fix (3 2 0) -: $ (2 0$0) {"2 i. 3 0 3
NB. for '' { i. 0 3 bug fix (3 2 0) -: $ (2 0$4) {"2 i. 3 0 3



'domain error' -: 'abc' {"1 etx i.3 4
'domain error' -: (u:'abc') {"1 etx i.3 4
'domain error' -: (10&u:'abc') {"1 etx i.3 4
'domain error' -: (s:@<"0 'abc') {"1 etx i.3 4
'domain error' -: 2.3   {"1 etx i.3 4
'domain error' -: 2j3   {"1 etx i.3 4
'domain error' -: (<'1'){"1 etx i.3 4

'length error' -: (i.7) {"0 1 etx i.8 9
'length error' -: (i.7) {"_1  etx 5 9$'asdf'
'length error' -: (i.7) {"_1  etx 5 9$u:'asdf'
'length error' -: (i.7) {"_1  etx 5 9$10&u:'asdf'
'length error' -: (i.7) {"_1  etx 5 9$s:@<"0 'asdf'
'length error' -: (<0 1){"1   etx i.3 4

'index error'  -: 5     {"1 etx ?4 5  $1234 
'index error'  -: _6    {"2 etx ?4 5 6$1234 
'index error'  -: 0     {"1 etx ?4 0  $1234 
'index error'  -: 0     {"2 etx ?4 0 5$1234 
'index error'  -: (<3)  {"1 etx ?5 2  $1234


NB. x{y complementary indexing ------------------------------------------

jot=:<$0

NB. Boolean
a =: 1=?2 3 4$2
(1{.a)       -: (<<<1){a
(1{.a)       -: (<<<1 _1){a
(1 0 1#"2 a) -: (<jot;<<1){a

NB. literal
a =: a.{~?2 3 4$256
(1{.a)       -: (<<<1){a
(1{.a)       -: (<<<1 _1){a
(1 0 1#"2 a) -: (<jot;<<_2){a

NB. literal2
a =: adot1{~?2 3 4$(#adot1)
(1{.a)       -: (<<<1){a
(1{.a)       -: (<<<1 _1){a
(1 0 1#"2 a) -: (<jot;<<_2){a

NB. literal4
a =: adot2{~?2 3 4$(#adot2)
(1{.a)       -: (<<<1){a
(1{.a)       -: (<<<1 _1){a
(1 0 1#"2 a) -: (<jot;<<_2){a

NB. symbol
a =: sdot0{~?2 3 4$(#sdot0)
(1{.a)       -: (<<<1){a
(1{.a)       -: (<<<1 _1){a
(1 0 1#"2 a) -: (<jot;<<_2){a

NB. integer
a =: ?2 3 4$256
(1{.a)       -: (<<<1){a
(1{.a)       -: (<<<1 _1){a
(1 0 1#"2 a) -: (<jot;<<1){a

NB. floating point
a =: o.?2 3 4$256
(1{.a)       -: (<<<1){a
(1{.a)       -: (<<<1 _1){a
(1 0 1#"2 a) -: (<jot;<<_2){a

NB. complex
a =: ^0j1*?2 3 4$256
(1{.a)       -: (<<<1){a
(1{.a)       -: (<<<1 _1){a
(1 0 1#"2 a) -: (<jot;<<1){a

NB. boxed
a =: 2 3 4$;:'+/..*(1 0 1#"2 a)-:(<jot;<<0){a'
(1{.a)       -: (<<<1){a
(1{.a)       -: (<<<1 _1){a
(1 0 1#"2 a) -: (<jot;<<_2){a

'domain error' -: (<<<'a')   { etx i.12
'domain error' -: (<<<3.5)   { etx i.12

'length error' -: (<0;<<_2)  { etx i.12

'index error'  -: (<<<2)     { etx a=:1=?2 3 4$2
'index error'  -: (<0;<<_4 2){ etx a
'index error'  -: (<<<2)     { etx a=:(?2 3 4$#a.){a.
'index error'  -: (<0;<<_4 2){ etx a
'index error'  -: (<<<2)     { etx a=:?2 3 4$1234
'index error'  -: (<0;<<_4 2){ etx a
'index error'  -: (<<<2)     { etx a=:o.?2 3 4$124
'index error'  -: (<0;<<_4 2){ etx a
'index error'  -: (<<<2)     { etx a=:r.?2 3 4$124
'index error'  -: (<0;<<_4 2){ etx a
'index error'  -: (<<<2)     { etx a=:2 3 4$'Mary';4
'index error'  -: (<0;<<_4 2){ etx a


NB. (<"1 x){y -----------------------------------------------------------

y=: ?(QKTEST{::7 11 13 17;11 13 17 19)$1e6
x=: ?(#$y)$$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y

y=: ?(QKTEST{::7 11 13 17;11 13 17 19)$1e6
x=: ?(0,#$y)$$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y

y=: ?(QKTEST{::7 11 13 17;11 13 17 19)$1e6
x=: ?(2 3 5 7 11,#$y)$$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y
NB. Test special cases: rank 2, rank 3, non-INT x
y=: ?17 19$1e6
x=: ?(2 3 5 7 11,0)$0{.$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y
x=: ?(2 3 5 7 11,1)$1{.$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y
x=: ?(2 3 5 7 11,2)$2{.$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y

y=: 0.5 + ?(QKTEST{::13 17 19;11 13 17)$1e6
x=: ?(2 3 5 7 11,0)$0{.$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y
x=: ?(2 3 5 7 11,1)$1{.$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y
x=: ?(2 3 5 7 11,2)$2{.$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y
x=: ?(2 3 5 7 11,3)$3{.$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y

y=: 1r2 + ?3 7 3 5 5$1e6
x=: ?(2 3 5 7 11,0)$0{.$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y
x=: ?(2 3 5 7 11,1)$1{.$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y
x=: ?(2 3 5 7 11,2)$2{.$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y
x=: ?(2 3 5 7 11,3)$3{.$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y
x=: ?(2 3 5 7 11,4)$4{.$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y
x=: ?(2 3 5 7 11,5)$5{.$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y


y=: ?2 2 2$1e6
x=: ?(2 3 5 7 11,#$y)$$y
((<"1     x){y) -: x      (<"1@[ { ]) y
((<"1    -x){y) -: (-x)   (<"1@[ { ]) y
((<"1 <"0 x){y) -: (<"0 x)(<"1@[ { ]) y



'domain error' -: 'abc' (<"1@[ { ]) etx y
'domain error' -: (u:'abc') (<"1@[ { ]) etx y
'domain error' -: (10&u:'abc') (<"1@[ { ]) etx y
'domain error' -: (s:@<"0 'abc') (<"1@[ { ]) etx y
'domain error' -: 3.5   (<"1@[ { ]) etx y

'index error'  -: 999   (<"1@[ { ]) etx y


NB. x{y leading indices are numeric singletons --------------------------

f=: 4 : 0
 (;$&.>>x)$ ,: > {&.>/ (a:($,)&.>|.>x),<y
)

s=: 11 7 5 3 2 13 7
x=: ?s$1e9

(i=: <?&.>1{.s) ({ -: f) x
(i=: <0:&.>1{.s) ({ -: f) x
(i=: <(0. + ?)&.>2{.s) ({ -: f) x
(i=: <((0 j. 0) + ?)&.>3{.s) ({ -: f) x
(i=: <(0x + ?)&.>4{.s) ({ -: f) x
(i=: <(0r3 + ?)&.>5{.s) ({ -: f) x
(i=: <?&.>6{.s) ({ -: f) x
(i=: <?&.>7{.s) ({ -: f) x

(i=: <((?1$5){.&.><7$1)$&.>?&.>1{.s) ({ -: f) x
(i=: <((?1$5){.&.><7$1)$&.>0:&.>1{.s) ({ -: f) x
(i=: <((?2$5){.&.><7$1)$&.>(0. + ?)&.>2{.s) ({ -: f) x
(i=: <((?3$5){.&.><7$1)$&.>((0 j. 0) + ?)&.>3{.s) ({ -: f) x
(i=: <((?4$5){.&.><7$1)$&.>(0x + ?)&.>4{.s) ({ -: f) x
(i=: <((?5$5){.&.><7$1)$&.>(0r3 + ?)&.>5{.s) ({ -: f) x
(i=: <((?6$5){.&.><7$1)$&.>?&.>6{.s) ({ -: f) x
(i=: <((?7$5){.&.><7$1)$&.>?&.>7{.s) ({ -: f) x

NB. test long names
abcdefghijabcdefghijabcdefghij0 =. 1
abcdefghijabcdefghijabcdefghij1 =. 2
abcdefghijabcdefghijabcdefghij00 =. 3
abcdefghijabcdefghijabcdefghij01 =. 4
abcdefghijabcdefghijabcdefghij000 =. 5
abcdefghijabcdefghijabcdefghij001 =. 6
abcdefghijabcdefghijabcdefghij0000 =. 7
abcdefghijabcdefghijabcdefghij0001 =. 8
abcdefghijabcdefghijabcdefghij0 -: 1
abcdefghijabcdefghijabcdefghij1 -: 2
abcdefghijabcdefghijabcdefghij00 -: 3
abcdefghijabcdefghijabcdefghij01 -: 4
abcdefghijabcdefghijabcdefghij000 -: 5
abcdefghijabcdefghijabcdefghij001 -: 6
abcdefghijabcdefghijabcdefghij0000 -: 7
abcdefghijabcdefghijabcdefghij0001 -: 8



 
4!:55 ;:'a adot1 adot2 sdot0 b catalog copy count f fr from i j '
4!:55 ;:'jot k l n p prod q r s v x y '
4!:55 <'abcdefghijabcdefghijabcdefghij0'
4!:55 <'abcdefghijabcdefghijabcdefghij1'
4!:55 <'abcdefghijabcdefghijabcdefghij00'
4!:55 <'abcdefghijabcdefghijabcdefghij01'
4!:55 <'abcdefghijabcdefghijabcdefghij000'
4!:55 <'abcdefghijabcdefghijabcdefghij001'
4!:55 <'abcdefghijabcdefghijabcdefghij0000'
4!:55 <'abcdefghijabcdefghijabcdefghij0001'
randfini''


epilog''

