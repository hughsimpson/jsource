prolog './g13x.ijs'
NB. 13!: ----------------------------------------------------------------


original=: 9!:6''
boxdraw_j_ 1

goo =: 3 : 0
y =. 1 + y
goo1 y
3 + y
)

goo1 =: 3 : 0
3 goo2 y
1 + y
4 goo2 y
y
)

goo2 =: 4 : 0
y return.
x return.
x + y
)

foo =: 0$0  NB. will accumulate results executed during suspension
13!:0 ] 0
13!:3 'goo 0'
13!:0 ] 129   NB. Take suspension input from script
h =: # 13!:13 ''  NB. in case we are in debug, get initial stack size to ignore later
10 = goo 6   NB. suspends
13!:4 ''  NB. leaves suspension, finishes suspended sentence, tests result
9 = goo 6
13!:5 ''
100 = goo 6
13!:6 ] 100  NB. exit with value
13!:3 'goo2 :0'
6 = 10 goo2 6
13!:7 ] 0
10 = 10 goo2 6
13!:7 ] 1
16 = 10 goo2 6
13!:7 ] 2
13!:3 'goo 0'
10 = goo 6
foo =: foo , (];._2 (0 : 0)) -: ": a: 5}"1 h }. (13!:13)''
+---+--+-+-+-------------------------------++---+-----+-+
|goo|18|0|3|3 : 0 y =. 1 + y goo1 y 3 + y )||+-+|+-+-+|*|
|   |  | | |                               |||6|||y|6|| |
|   |  | | |                               ||+-+|+-+-+| |
+---+--+-+-+-------------------------------++---+-----+-+
)
13!:21''  NB. Into on line with no call
foo =: foo , (];._2 (0 : 0)) -: ": a: 5}"1 h }. (13!:13)''
+---+--+-+-+-------------------------------++---+-----+-+
|goo|18|1|3|3 : 0 y =. 1 + y goo1 y 3 + y )||+-+|+-+-+|*|
|   |  | | |                               |||6|||y|7|| |
|   |  | | |                               ||+-+|+-+-+| |
+---+--+-+-+-------------------------------++---+-----+-+
)
13!:21''  NB. Into a function
foo =: foo , (];._2 (0 : 0)) -: ": a: 5}"1 h }. (13!:13)''
+----+--+-+-+---------------------------------++---+-----+-+
|goo1|18|0|3|3 : 0 3 goo2 y 1 + y 4 goo2 y y )||+-+|+-+-+|*|
|    |  | | |                                 |||7|||y|7|| |
|    |  | | |                                 ||+-+|+-+-+| |
+----+--+-+-+---------------------------------++---+-----+-+
|goo |0 |1|3|3 : 0 y =. 1 + y goo1 y 3 + y )  ||+-+|+-+-+|*|
|    |  | | |                                 |||6|||y|7|| |
|    |  | | |                                 ||+-+|+-+-+| |
+----+--+-+-+---------------------------------++---+-----+-+
)
13!:20''  NB. Over a function
foo =: foo , (];._2 (0 : 0)) -: ": a: 5}"1 h }. (13!:13)''
+----+--+-+-+---------------------------------++---+-----+-+
|goo1|18|1|3|3 : 0 3 goo2 y 1 + y 4 goo2 y y )||+-+|+-+-+|*|
|    |  | | |                                 |||7|||y|7|| |
|    |  | | |                                 ||+-+|+-+-+| |
+----+--+-+-+---------------------------------++---+-----+-+
|goo |0 |1|3|3 : 0 y =. 1 + y goo1 y 3 + y )  ||+-+|+-+-+|*|
|    |  | | |                                 |||6|||y|7|| |
|    |  | | |                                 ||+-+|+-+-+| |
+----+--+-+-+---------------------------------++---+-----+-+
)
13!:22''  NB. Out from the middle of a function
foo =: foo , (];._2 (0 : 0)) -: ": a: 5}"1 h }. (13!:13)''
+---+--+-+-+-------------------------------++---+-----+-+
|goo|18|2|3|3 : 0 y =. 1 + y goo1 y 3 + y )||+-+|+-+-+|*|
|   |  | | |                               |||6|||y|7|| |
|   |  | | |                               ||+-+|+-+-+| |
+---+--+-+-+-------------------------------++---+-----+-+
)
13!:4''  NB. Finishes original sentence, ends suspension
13!:3 'goo1 3'  NB. Stop at last sentence
10 = goo 6
foo =: foo , (];._2 (0 : 0)) -: ": a: 5}"1 h }. (13!:13)''
+----+--+-+-+---------------------------------++---+-----+-+
|goo1|18|3|3|3 : 0 3 goo2 y 1 + y 4 goo2 y y )||+-+|+-+-+|*|
|    |  | | |                                 |||7|||y|7|| |
|    |  | | |                                 ||+-+|+-+-+| |
+----+--+-+-+---------------------------------++---+-----+-+
|goo |0 |1|3|3 : 0 y =. 1 + y goo1 y 3 + y )  ||+-+|+-+-+| |
|    |  | | |                                 |||6|||y|7|| |
|    |  | | |                                 ||+-+|+-+-+| |
+----+--+-+-+---------------------------------++---+-----+-+
)
13!:20''   NB. Step over last sentence back to caller
foo =: foo , (];._2 (0 : 0)) -: ": a: 5}"1 h }. (13!:13)''
+---+--+-+-+-------------------------------++---+-----+-+
|goo|18|2|3|3 : 0 y =. 1 + y goo1 y 3 + y )||+-+|+-+-+|*|
|   |  | | |                               |||6|||y|7|| |
|   |  | | |                               ||+-+|+-+-+| |
+---+--+-+-+-------------------------------++---+-----+-+
)
13!:4 ''
10 = goo 6
13!:21''   NB. Step into last sentence back to caller
foo =: foo , (];._2 (0 : 0)) -: ": a: 5}"1 h }. (13!:13)''
+---+--+-+-+-------------------------------++---+-----+-+
|goo|18|2|3|3 : 0 y =. 1 + y goo1 y 3 + y )||+-+|+-+-+|*|
|   |  | | |                               |||6|||y|7|| |
|   |  | | |                               ||+-+|+-+-+| |
+---+--+-+-+-------------------------------++---+-----+-+
)
13!:4 ''
10 = goo 6
13!:22''   NB. Step outa last sentence back to caller
foo =: foo , (];._2 (0 : 0)) -: ": a: 5}"1 h }. (13!:13)''
+---+--+-+-+-------------------------------++---+-----+-+
|goo|18|2|3|3 : 0 y =. 1 + y goo1 y 3 + y )||+-+|+-+-+|*|
|   |  | | |                               |||6|||y|7|| |
|   |  | | |                               ||+-+|+-+-+| |
+---+--+-+-+-------------------------------++---+-----+-+
)
13!:4 ''
10 = goo 6
13!:19''   NB. Cut stack back to goo
foo =: foo , (];._2 (0 : 0)) -: ": a: 5}"1 h }. (13!:13)''
+---+--+-+-+-------------------------------++---+-----+-+
|goo|18|1|3|3 : 0 y =. 1 + y goo1 y 3 + y )||+-+|+-+-+|*|
|   |  | | |                               |||6|||y|7|| |
|   |  | | |                               ||+-+|+-+-+| |
+---+--+-+-+-------------------------------++---+-----+-+
)
13!:3''  NB. clear stops
13!:4''  NB. get out of suspension
NB. Redefine goo* to test cut-back with error
goo =: 3 : 0
goo2 =: 5
goo2 =: goo1 y
goo2
)
goo1 =: 3 : 0
y + 1
)


7 -: goo 6
goo2 -: 7

5 -: goo 'a'
foo =: foo , goo2 -: 5   NB. In suspension, must add results to foo
foo =: foo , (];._2 (0 : 0)) -: ": a: 5}"1 h }. (13!:13)''
+----+-+-+-+-------------------------------------++---+-----+-+
|goo1|3|0|3|3 : 'y + 1'                          ||+-+|+-+-+|*|
|    | | | |                                     |||a|||y|a|| |
|    | | | |                                     ||+-+|+-+-+| |
+----+-+-+-+-------------------------------------++---+-----+-+
|goo |0|1|3|3 : 0 goo2 =: 5 goo2 =: goo1 y goo2 )||+-+|+-+-+| |
|    | | | |                                     |||a|||y|a|| |
|    | | | |                                     ||+-+|+-+-+| |
+----+-+-+-+-------------------------------------++---+-----+-+
)
13!:19''  NB. Cut back from error: resumes sentence with error, not with i. 0 0
foo =: foo , (];._2 (0 : 0)) -: ": a: 5}"1 h }. (13!:13)''
+---+--+-+-+-------------------------------------++---+-----+-+
|goo|18|1|3|3 : 0 goo2 =: 5 goo2 =: goo1 y goo2 )||+-+|+-+-+|*|
|   |  | | |                                     |||a|||y|a|| |
|   |  | | |                                     ||+-+|+-+-+| |
+---+--+-+-+-------------------------------------++---+-----+-+
)
13!:4 ''   NB. finish sentences, test result
foo =: foo , goo2 -: 5  NB. the sentence is aborted before assignment
13!:0 ] 0
13!:0 [1
i. 0 0 [ 9!:7 original
foo   NB. Test results of stack/result checks

foo       =: foo_loc1_
foo_loc1_ =: foo_loc2_ /
foo_loc2_ =: foo_loc3_ ~
foo_loc3_ =: +

commute =: ~

goo =: 4 : 0
 p=.2*x
 q=.p goo1 commute y
 q*q
)

goo1 =: goo2
goo2 =: goo3
goo3 =: +

fac =: 3 : 0
 if.     2>y do. 1 
 elseif. 2=y do. %'abc'
 elseif. 1   do. y*fac y-1 
 end.
)

conj =: 2 : 0
 if. 1=u do. v=.*:@v else. v=.%:@v end.
 %glob
 v/
)

h  =: 3 : 'y h1 2'
h1 =: 4 : 'x+y'

f1 =: 3 : '+/'
f2 =: 3 : '('

13!:0 [1
'domain error' -:   f =: (3 : '%y' ) etx 'asdf'
'domain error' -: % (1 : 'u y') etx 'asdf'
13!:0 [0

f =: % 1 : 'u y'
'domain error' -: f etx 'asdf'

f=: 3 : 'try. 13!:8 y catch. 13!:11 $0 end.'

254 -: f 254
255 -: f 255
10  -: f 256
3  -: f 0

13!:8 :: 1: x=: (- e.&35 15) >: ?255  NB. Make sure we don't try to create EVTHROW (35) or EVEXIT (15), which do not honor adverse
x -: 13!:11 ''

'length error' -: 13!:11 etx 'junkfoo'
'length error' -: 13!:12 etx 'junkfoo'


NB. stops ---------------------------------------------------------------

'' -: 13!:2 ''
1 [ 13!:3 'sum *'
'sum *' -: 13!:2 ''
1 [ 13!:3 ''


NB. error text ----------------------------------------------------------

sum=: +/
f=: 3 : '2 3+g y'
g=: 3 : 'if. y do. y else. + end.'
h=: 2 3&+@sum

'value error: junkfoo' -: fex 'junkfoo'

'domain error: fex'    -: fex '+/1;2 3'
'domain error: sum'    -: fex 'sum ''asdf'''
'noun result was required: g'      -: fex 'f 0'
'domain error: sum'    -: fex 'h ''asdf'''

f=: 3 : 0
 abc=. 'abc'
 ".&([ 9!:59@0) :: 0: 'abc,',y  NB. We want to see the full message
 13!:12 ''
)

' ...' -: _4{. }: f 204 $'123 '
' ...' -: _4{. }: f 204 $'1.3 '
' ...' -: _4{. }: f 204 $'1j3 '
' ...' -: _4{. }: f 221 $(16$'123'),'x '
' ...' -: _4{. }: f 221 $' 1r',14$'1123'

18!:55 ;:'loc1 loc2 loc3'


NB. 13!:13  -------------------------------------------------------------

mean=: sum % #
sum =: [: +/ ".@('t=:13!:13 $0'&[) ] ]

13!:0 ]1
1: mean x=: ?4 5$100
13!:0 ]0

($t) -: 2 9
(0{"1 t) -: 'sum';'mean'          NB. name
(1{"1 t) -: 0;0                   NB. error number
(2{"1 t) -: 0;0                   NB. line number
(3{"1 t) -: 3;3                   NB. name class
((<1 4){t) -: <'sum % #'          NB. definition
(_8{.&.>5{"1 t) -: 2$<'g13x.ijs'  NB. defining scripts
(6{"1 t) -: (<,<x),<,<x           NB. boxed argument(s)
(7{"1 t) -: 2$<0 2$0              NB. locals
(8{"1 t) e. ' ';'*'               NB. * if begins suspension

13!:0 ]1
1: mean"1 x
13!:0 ]0

($t) -: 2 9
(0{"1 t) -: 'sum';'mean'          NB. name
(1{"1 t) -: 0;0                   NB. error number
(2{"1 t) -: 0;0                   NB. line number
(3{"1 t) -: 3;3                   NB. name class
((<1 4){t) -: <'sum % #'          NB. definition
(_8{.&.>5{"1 t) -: 2$<'g13x.ijs'  NB. defining scripts
(6{"1 t) -: (<,<{:x),<,<{:x       NB. boxed argument(s)
(7{"1 t) -: 2$<0 2$a:             NB. locals
(8{"1 t) e. ' ';'*'               NB. * if begins suspension

sum=: 3 : ('z=.+/y';'t=: 13!:13 $0';'z')

13!:0 ]1
1: mean"1 x
13!:0 ]0

($t) -: 2 9
(0{"1 t) -: 'sum';'mean'          NB. name
(1{"1 t) -: 0;0                   NB. error number
(2{"1 t) -: 1;0                   NB. line number
(3{"1 t) -: 3;3                   NB. name class
((<1 4){t) -: <'sum % #'          NB. definition
(_8{.&.>5{"1 t) -: 2$<'g13x.ijs'  NB. defining scripts
(6{"1 t) -: (<,<{:x),<,<{:x       NB. boxed argument(s)
NB. (7{"1 t) -: (('y.';{:x),:(,'z');+/{:x);<0 2$a:  NB. locals
(>(<0 7){t) e. ('y.';{:x), ((,'y');{:x),:(,'z');+/{:x  NB. locals
(8{"1 t) e. ' ';'*'               NB. * if begins suspension



NB. 13!:18  -------------------------------------------------------------

mean=: sum % #
sum=: 3 : ('z=.+/y';'t=: 13!:18 $0';'z')

13!:0 ]1
1: mean i.12
NB. (2{.t) -: (2,{:$t){.];.1 '|sum[1]|mean[0] !'

expa =: 1 : 'u y'
fexpa =: 0: expa f.
'0: (1 : ''u y'')' -: 5!:5 <'fexpa'


13!:0 ]1

f=: 2 : 0
(m g n) : (m g n)
)

g=: 2 : 0
m;n;y
'g1'
:
m;n;x;y
'g2'
)

'g2' -: 0 (0 f 0) 0
'g1' -: (0 f 0) 0

13!:0 ]0

NB. ------------ eformat ---------------------------------------------------

1 e. '(0)' E. 4 {{y*"(0) 0 0 1,:_ _,7)];.0 x}} eftx 5 6 7  NB. verify error disp puts () around PPPP noun

f =: 1:`(-: ". eftx)@.(3 = 4!:0 <'eformat_j_')  NB. check verbose msgs only if defined

'|length error in f executing +|shapes 2 and 3 do not conform|   2 3    +4 5 6'    f '2 3+4 5 6'
'|length error in f executing +"1|shapes 2 3 and 4 5 6 do not conform|   (i.2 3)    +"1 i.4 5 6'    f '(i. 2 3)+"1 i.4 5 6'
'|length error in f executing +"1 1|<frames> do not conform in shapes 2<3> and 2 3<6>|   (i.2 3)    +"1 i.2 3 6'    f '(i. 2 3)+"1 i.2 3 6'

'|length error in f executing $| extending an empty array requires fill|   2 3    $$0' f '2 3 $ $0'
'|domain error in f executing $| x has nonintegral value (2.5) at position 0|   2.5 3    $$0' f '2.5 3 $ $0'
'|domain error in f executing $| x has invalid value (_1) at position 1|   2 _1    $$0' f '2 _1 $ $0'

g =: {{ y + 5 }}
'|valence error in g|explicit definition has no dyadic valence|   2     g 3' f '2 g 3'
g =: {{ y + x }}
'|valence error in g|explicit definition has no monadic valence|       g 3' f 'g 3'
'|valence error in f|[: must be part of a capped fork|   5.7    ([:;]<@(+/\);.2)i.5' f '5.7 ([:;]<@(+/\);.2) i. 5'

4!:55 ;:'commute conj f f1 f2 fac foo expa fexpa '
4!:55 ;:'g goo goo1 goo2 goo3 h h1 mean sum t x original '



epilog''

