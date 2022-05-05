1:@:(dbr bind Debug)@:(9!:19)2^_44[(prolog [ echo^:ECHOFILENAME) './g402.ijs'
NB. #:y -----------------------------------------------------------------

max    =: >./@:|@,
bits   =: ] (1 >. ] + [ >: 2x&^@]) <.@(2&^.)@(1&>.)
abase1 =: #:~ $&2@bits@max

NB. Boolean
(#: -: abase1) x=:?2 3 4$2
(#: -: abase1) x=: 0
(#: -: abase1) x=: 1

NB. integer
(#: -: abase1) x=:_6000+?2 3 4$12345
(#: -: abase1) x=:_500+?1000
(#: -: abase1) x=:_1e8+?100$2e8
(#: -: abase1) x=:_2147483648
(#: -: abase1) x=: 2147483647
(#: -: abase1) x=:_2147483648 25 9 2147483647
(#: -: abase1) imin
(#: -: abase1) imax
(#: -: abase1) x=: imax,imin,_5e8+10 ?@$ 1e9

NB. floating point
(#: -: abase1) x=:o._5000+?2 3 4$10000
(#: -: abase1)"0 x=:o. i: 500
1 0 -: #: -2.1-0.1
0 1 1.5 -: #: _4.5
0 0 0.5 -: #: _7.5

0~:{.#:(2^12)-1e_9

NB. complex
(#: -: abase1) x=:j./?2 3 4$1000
(#: -: abase1) x=:r.?12345 6789

(,0)    -: #: 0
(,1)    -: #: 1
1 0     -: #: 2
1 0 0   -: #: 4
1 0 0 0 -: #: 8
1 0 0 0 -: #: _8
1 1 0 1 -: #: 13

(70{.1) -: #: 2^69

f =: ([,-.@(0&e.))@$ $ ,
(f t) -: #:t=:?(>:?7$3)$2
(f t) -: #:t=:(?32$2)$2
(f t) -: #:t=:(?32$2)$2.4
(f t) -: #:t=:(?32$2)$2j4

'domain error' -: #: etx 'abc'
'domain error' -: #: etx u:'abc'
'domain error' -: #: etx 10&u:'abc'
'domain error' -: #: etx s:@<"0 'abc'
'domain error' -: #: etx 123;45 6


NB. x#:y ----------------------------------------------------------------

abase2 =: ([ | i.@#@$@] |: ([%~]-|)/\.@}.@,)"1 0
f =: *./@,@:(#: -: abase2)

NB. Boolean
(?4$2) f ?2 3 4$2
(?4$2) f ?2

NB. integer
(?4$100)         f _6000+?2 5$12345
(_4+?2 4$10)     f _6000+?2 1 3$12345
(?4$10)          f _500+?1000
(_40+?3 2 4$100) f _6000+?3$12345

NB. floating point
(_15+?1 2 4$30)  f o._5000+?1 2$10000
(_4+?7$9)        f o._500+?10000

NB. complex
(_15+3 4$30)     f r.?3 1 1 4$1000
(_4+?3 1 1 7$9)  f r.?3 1$12345

(?2)     (|-:#:) ?2
(?100)   (|-:#:) ?100
(o.?100) (|-:#:) o.?100
(r.?100) (|-:#:) r.?100

1 2 3 4   -: 10 10 10 10#:1234
0 0 _1 _1 -: _2 _2 _2 _2#:1

(0 ,. i: 32) f"1 0/ i:64
0 = _1 | imin   NB. used to crash
(IF64 { _357913942 4 ,: _1537228672809129302 4) -: 0 6 #: imin
(IF64 { _268435456 0 ,: _1152921504606846976 0) -: 0 8 #: imin
(IF64 { 357913941 1 ,: 1537228672809129301 1) -: 0 6 #: imax
(IF64 { 268435455 7 ,: 1152921504606846975 7) -: 0 8 #: imax
(-imax,0) -: 0 _1 #: imax
(-imin,0) -: 0 _1 #: imin
(-imin,0 0) -: 0 _1 1 #: imin


f=: #: i.@(*/)
g=: 3 : 'y#:i.*/y'

(f -: g) ?5$5
(f -: g) ?5$14
(f -: g) _7+?5$14

'domain error' -: 2 3 4#: etx 'abc'
'domain error' -: 2 3 4#: etx u:'abc'
'domain error' -: 2 3 4#: etx 10&u:'abc'
'domain error' -: 2 3 4#: etx s:@<"0 'abc'
'domain error' -: 4 3 2#: etx 123;45 6
'domain error' -: 'abc'#: etx 7
'domain error' -: (u:'abc')#: etx 7
'domain error' -: (10&u:'abc')#: etx 7
'domain error' -: (s:@<"0 'abc')#: etx 7
'domain error' -: (123;4 5 6)#: etx _12

4!:55 ;:'abase1 abase2 bits f g max t x '



echo^:ECHOFILENAME 'memory used: ',":7!:1''

