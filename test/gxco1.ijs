1:@:(dbr bind Debug)@:(9!:19)2^_44[(prolog [ echo^:ECHOFILENAME) './gxco1.ijs'
NB. extended precision integers -----------------------------------------

NB. create test data

x1=: (1-1e4)+10 11 ?@$ 2e4-1
y1=: (1-1e4)+10 11 ?@$ 2e4-1
x2=: (1-1e8)+10 11 ?@$ 2e8-1
y2=: (1-1e8)+10 11 ?@$ 2e8-1
x3=: (1-1e9)+10 11 ?@$ 2e9-1
y3=: (1-1e9)+10 11 ?@$ 2e9-1


NB. = -------------------------------------------------------------------

x1 (= -: =&.x:) y1
x1 (= -: =&.x:) y2
x1 (= -: =&.x:) y3
x2 (= -: =&.x:) y1
x2 (= -: =&.x:) y2
x2 (= -: =&.x:) y3
0  (= -: =&.x:) y1
0  (= -: =&.x:) y2
0  (= -: =&.x:) y3

x1 (= -: =&.x:) x=:x1+($x1) ?@$ 2
x2 (= -: =&.x:) x=:x2+($x2) ?@$ 2
x3 (= -: =&.x:) x=:x3+($x3) ?@$ 2

(($x3)$0) -: x3 = ($x3)$a.
(($x3)$0) -: x3 = ($x3)$a:

(= -: =@:x:) y1
(= -: =@:x:) y2
(= -: =@:x:) y3

(= -: =&.x:)~ y1
(= -: =&.x:)~ y2
(= -: =&.x:)~ y3

0 0 1 -: 3 3.4 4 = x: 4
0 0 1 -: 3 3j4 4 = x: 4
0 0 0 -: '3j4'   = x: 4
0 0 0 -: (<"0 'abc') = x: 4

(x1=y) -: (x: x1) = y=:x1+0.5*($x1)?@$2
(x2=y) -: (x: x2) = y=:x2+0.5*($x2)?@$2
(x3=y) -: (x: x3) = y=:x3+0.5*($x3)?@$2

(x1=y) -: (x: x1) = y=:x1+j./(2,$x1)?@$2
(x2=y) -: (x: x2) = y=:x2+j./(2,$x1)?@$2
(x3=y) -: (x: x3) = y=:x3+j./(2,$x1)?@$2


NB. < -------------------------------------------------------------------

x1 (< -: <&.x:) y1
x1 (< -: <&.x:) y2
x1 (< -: <&.x:) y3
x2 (< -: <&.x:) y1
x2 (< -: <&.x:) y2
x2 (< -: <&.x:) y3
0  (< -: <&.x:) y1
0  (< -: <&.x:) y2
0  (< -: <&.x:) y3

x1 (< -: <&.x:) x=:x1+($x1)?@$2
x2 (< -: <&.x:) x=:x2+($x2)?@$2
x3 (< -: <&.x:) x=:x3+($x3)?@$2

(< -: <&.x:)~ y1
(< -: <&.x:)~ y2
(< -: <&.x:)~ y3

'domain error' -: (x: x1) < etx 3j4
'domain error' -: (x: x1) < etx 'a'
'domain error' -: (x: x1) < etx <12


NB. <. ------------------------------------------------------------------

(<. -: <.&.x:) y1
(<. -: <.&.x:) y2
(<. -: <.&.x:) y3

x1 (<. -: <.&.x:) y1
x1 (<. -: <.&.x:) y2
x2 (<. -: <.&.x:) y1
x2 (<. -: <.&.x:) y2
0  (<. -: <.&.x:) y1
0  (<. -: <.&.x:) y2

'domain error' -: (x: x1) <. etx 3j4
'domain error' -: (x: x1) <. etx 'a'
'domain error' -: (x: x1) <. etx <12


NB. <: ------------------------------------------------------------------

(<: -: <:&.x:) y1
(<: -: <:&.x:) y2
(<: -: <:&.x:) y3

x1 (<: -: <:&.x:) y1
x1 (<: -: <:&.x:) y2
x2 (<: -: <:&.x:) y1
x2 (<: -: <:&.x:) y2
0  (<: -: <:&.x:) y1
0  (<: -: <:&.x:) y2

'domain error' -: (x: x1) <: etx 3j4
'domain error' -: (x: x1) <: etx 'a'
'domain error' -: (x: x1) <: etx <12


NB. > -------------------------------------------------------------------

x1 (> -: >&.x:) y1
x1 (> -: >&.x:) y2
x1 (> -: >&.x:) y3
x2 (> -: >&.x:) y1
x2 (> -: >&.x:) y2
x2 (> -: >&.x:) y3
0  (> -: >&.x:) y1
0  (> -: >&.x:) y2
0  (> -: >&.x:) y3

x1 (> -: >&.x:) x=:x1+($x1)?@$2
x2 (> -: >&.x:) x=:x2+($x2)?@$2
x3 (> -: >&.x:) x=:x3+($x3)?@$2

(> -: >&.x:)~ y1
(> -: >&.x:)~ y2
(> -: >&.x:)~ y3

(><"0 x1) -: ><"0 x: x1
(><"1 x1) -: ><"1 x: x1
(><"0 x2) -: ><"0 x: x2
(><"1 x2) -: ><"1 x: x2
(><"0 x3) -: ><"0 x: x3
(><"1 x3) -: ><"1 x: x3

(>(<"_1 x1),<"_1 y1) -: >(<"_1 x: x1),<"_1 y1

3.5 4 -: > 3.5; 4x
3j5 4 -: > 3j5; 4x

'domain error' -: (x: x1) > etx 3j4
'domain error' -: (x: x1) > etx 'a'
'domain error' -: (x: x1) > etx <12

'domain error' -: > etx 'abc';x: 4
'domain error' -: > etx (<12);x: 4


NB. >. ------------------------------------------------------------------

(>. -: >.&.x:) y1
(>. -: >.&.x:) y2
(>. -: >.&.x:) y3

x1 (>. -: >.&.x:) y1
x1 (>. -: >.&.x:) y2
x2 (>. -: >.&.x:) y1
x2 (>. -: >.&.x:) y2
0  (>. -: >.&.x:) y1
0  (>. -: >.&.x:) y2

'domain error' -: (x: x1) >. etx 3j4
'domain error' -: (x: x1) >. etx 'a'
'domain error' -: (x: x1) >. etx <12


NB. >: ------------------------------------------------------------------

x1 (>: -: >:&.x:) y1
x1 (>: -: >:&.x:) y2
x1 (>: -: >:&.x:) y3
x2 (>: -: >:&.x:) y1
x2 (>: -: >:&.x:) y2
x2 (>: -: >:&.x:) y3
0  (>: -: >:&.x:) y1
0  (>: -: >:&.x:) y2
0  (>: -: >:&.x:) y3

x1 (>: -: >:&.x:) x=:x1+($x1)?@$2
x2 (>: -: >:&.x:) x=:x2+($x2)?@$2
x3 (>: -: >:&.x:) x=:x3+($x3)?@$2

(>: -: >:&.x:)~ y1
(>: -: >:&.x:)~ y2
(>: -: >:&.x:)~ y3

'domain error' -: (x: x1) >: etx 3j4
'domain error' -: (x: x1) >: etx 'a'
'domain error' -: (x: x1) >: etx <12


NB. + -------------------------------------------------------------------

(+ -: +&.x:) y1
(+ -: +&.x:) y2
(+ -: +&.x:) y3

x1 (+ -: +&.x:) y1
x1 (+ -: +&.x:) y2
x1 (+ -: +&.x:) y3
x2 (+ -: +&.x:) y1
x2 (+ -: +&.x:) y2
x2 (+ -: +&.x:) y3
x3 (+ -: +&.x:) y1
x3 (+ -: +&.x:) y2
x3 (+ -: +&.x:) y3

(x1+3.4) -: (x: x1) + 3.4
(x1+3j4) -: (x: x1) + 3j4

'domain error' -: (x: x1) + etx 'a'
'domain error' -: (x: x1) + etx <12


NB. +. ------------------------------------------------------------------

(+. -: +.&.x:) y1
(+. -: +.&.x:) y2
(+. -: +.&.x:) y3

x1 (+. -: +.&.x:) y1
x1 (+. -: +.&.x:) y2
x1 (+. -: +.&.x:) y3
x2 (+. -: +.&.x:) y1
x2 (+. -: +.&.x:) y2
x2 (+. -: +.&.x:) y3
x3 (+. -: +.&.x:) y1
x3 (+. -: +.&.x:) y2
x3 (+. -: +.&.x:) y3

0 1 1 1 -: 0 0 1 1 +. x: 0 1 0 1

(+./~ -: +./~@:x:)      _20+i.41
(+./~ -: +./~@:x:)  1e4+_20+i.41
(+./~ -: +./~@:x:) 20e4+_20+i.41
(+./~ -: +./~@:x:) 27e4+_20+i.41

(3.5 +. 4) -: 3.5 +. 4x
(3j5 +. 4) -: 3j5 +. 4x

'domain error' -: (x: x1) +. etx 'a'
'domain error' -: (x: x1) +. etx <12


NB. +: ------------------------------------------------------------------

(+: -: +:&.x:) y1
(+: -: +:&.x:) y2
(+: -: +:&.x:) y3

0 0 1 1 (+: -: +:&.x:) 0 1 0 1

'domain error' -: (x: 1 2 3) +: etx x: 0 1 0
'domain error' -: (x: x1) +: etx 3.4
'domain error' -: (x: x1) +: etx 3j4
'domain error' -: (x: x1) +: etx 'a'
'domain error' -: (x: x1) +: etx <12


NB. * -------------------------------------------------------------------

x1=: (1-1e4)+10 11?@$2e4-1
y1=: (1-1e4)+10 11?@$2e4-1
x2=: (1-1e8)+10 11?@$2e8-1
y2=: (1-1e8)+10 11?@$2e8-1
x3=: (1-1e9)+10 11?@$2e9-1
y3=: (1-1e9)+10 11?@$2e9-1

(* -: *&.x:) y1
(* -: *&.x:) y2
(* -: *&.x:) y3

x1 (* -: *&.x:) y1
x1 (* -: *&.x:) y2
x1 (* -: *&.x:) y3
x2 (* -: *&.x:) y1
x2 (* -: *&.x:) y2
x2 (* -: *&.x:) y3
x3 (* -: *&.x:) y1
x3 (* -: *&.x:) y2
x3 (* -: *&.x:) y3

x=: */8192$2x
x = *~ */4096$2x
x = *~ */2048$4x
x = *~ */1024$16x
x = *~ */ 512$256x
x = *~ */ 256$65536x
x = *~ */ 128$65536x^2
x = *~ */  64$65536x^4
x = *~ */  32$65536x^8

y=: x: ?10$40
(y^n) = */@(n&$)"0 y [ n=:?4000
(y^n) = */@(n&$)"0 y [ n=:?4000
(y^n) = */@(n&$)"0 y [ n=:?4000

(3.5 * 4) -: 3.5 * 4x
(3j5 * 4) -: 3j5 * 4x

'domain error' -: (x: x1) * etx 'a'
'domain error' -: (x: x1) * etx <12


NB. *. ------------------------------------------------------------------

x1=: (1-1e4)+10 11?@$2e4-1
y1=: (1-1e4)+10 11?@$2e4-1
y2=: (1-1e8)+10 11?@$2e8-1
y3=: (1-1e9)+10 11?@$2e9-1

x1 (*. -: *.&.x:) y1
x1 (*. -: *.&.x:) y2
x1 (*. -: *.&.x:) y3

0 0 0 1 -: 0 0 1 1 *. etx x: 0 1 0 1

(3.5 *. 4) -: 3.5 *. 4x
(3j5 *. 4) -: 3j5 *. 4x

'domain error' -: (x: x1) *. etx 'a'
'domain error' -: (x: x1) *. etx <12


NB. *: ------------------------------------------------------------------

(*: -: *:&.x:) y1
(*: -: *:&.x:) y2
(*: -: *:&.x:) y3

0 0 1 1 (*: -: *:&.x:) 0 1 0 1

'domain error' -: (x: 1 2 3) *: etx x: 0 1 0
'domain error' -: (x: x1) *: etx 3.4
'domain error' -: (x: x1) *: etx 3j4
'domain error' -: (x: x1) *: etx 'a'
'domain error' -: (x: x1) *: etx <12


NB. - -------------------------------------------------------------------

(- -: -&.x:) y1
(- -: -&.x:) y2
(- -: -&.x:) y3

x1 (- -: -&.x:) y1
x1 (- -: -&.x:) y2
x1 (- -: -&.x:) y3
x2 (- -: -&.x:) y1
x2 (- -: -&.x:) y2
x2 (- -: -&.x:) y3
x3 (- -: -&.x:) y1
x3 (- -: -&.x:) y2
x3 (- -: -&.x:) y3

(x1 - 3.4) -: (x: x1) - 3.4
(x1 - 3j4) -: (x: x1) - 3j4

'domain error' -: (x: x1) - etx 'a'
'domain error' -: (x: x1) - etx <12


NB. % -------------------------------------------------------------------

(<.!.0@% -: <.@%&.x:) y1+0=y1
(<.!.0@% -: <.@%&.x:) y2+0=y2
(<.!.0@% -: <.@%&.x:) y3+0=y3

(>.!.0@% -: >.@%&.x:) y1+0=y1
(>.!.0@% -: >.@%&.x:) y2+0=y2
(>.!.0@% -: >.@%&.x:) y3+0=y3

x1 (<.!.0@% -: <.@%&.x:) y1+0=y1
x1 (<.!.0@% -: <.@%&.x:) y2+0=y2
x1 (<.!.0@% -: <.@%&.x:) y3+0=y3
x2 (<.!.0@% -: <.@%&.x:) y1+0=y1
x2 (<.!.0@% -: <.@%&.x:) y2+0=y2
x2 (<.!.0@% -: <.@%&.x:) y3+0=y3
x3 (<.!.0@% -: <.@%&.x:) y1+0=y1
x3 (<.!.0@% -: <.@%&.x:) y2+0=y2
x3 (<.!.0@% -: <.@%&.x:) y3+0=y3

x1 (>.!.0@% -: >.@%&.x:) y1+0=y1
x1 (>.!.0@% -: >.@%&.x:) y2+0=y2
x1 (>.!.0@% -: >.@%&.x:) y3+0=y3
x2 (>.!.0@% -: >.@%&.x:) y1+0=y1
x2 (>.!.0@% -: >.@%&.x:) y2+0=y2
x2 (>.!.0@% -: >.@%&.x:) y3+0=y3
x3 (>.!.0@% -: >.@%&.x:) y1+0=y1
x3 (>.!.0@% -: >.@%&.x:) y2+0=y2
x3 (>.!.0@% -: >.@%&.x:) y3+0=y3

(% -: %&.x:)~ y1
(% -: %&.x:)~ y2
(% -: %&.x:)~ y3

e=:$0
e -: 2x % ''
e -: 2x % $0
e -: 2x % 0$a:
e -: 2x <.@% ''
e -: 2x <.@% $0
e -: 2x <.@% 0$a:
e -: 2x >.@% ''
e -: 2x >.@% $0
e -: 2x >.@% 0$a:

_  -:   % x: 0
_  -: 4 % x: 0
__ -: _4 % x: 0


NB. %: ------------------------------------------------------------------

0 -: %: x: 0
5 -: %: x: 25
(%: -: %:@x:) *~i.2 10

(<.!.0@%: -: <.@%:@x:)     i.2 10
(<.!.0@%: -: <.@%:@x:) 1e3*i.2 10
(<.!.0@%: -: <.@%:@x:) 1e4*i.2 10
(<.!.0@%: -: <.@%:@x:) 1e5*i.2 10
(<.!.0@%: -: <.@%:@x:) 1e8*i.2 10
(<.!.0@%: -: <.@%:@x:) 1e9*i.2 10

(>.!.0@%: -: >.@%:@x:)     i.2 10
(>.!.0@%: -: >.@%:@x:) 1e3*i.2 10
(>.!.0@%: -: >.@%:@x:) 1e4*i.2 10
(>.!.0@%: -: >.@%:@x:) 1e5*i.2 10
(>.!.0@%: -: >.@%:@x:) 1e8*i.2 10
(>.!.0@%: -: >.@%:@x:) 1e9*i.2 10

NB. 0 1 _ -: 0x %: 0 1 2x
NB. 0 1 _ -: 0  %: 0 1 2

f=: 3 : '((*~s)<:y)*.y<:*~1+s=.<.@%: y'

f"0 !x:i.5 10
f"0 (i.2 10)**/20$x:1e4

(   %:  2) -:    %: x:  2
(<.@%: _5) -: <.@%: x: _5
(>.@%: _5) -: >.@%: x: _5

root=: 4 : 0
 r=.x
 a=.y
 f=. ([ * (a&+)@((r-1)&*)@(^&r)) <.@% r&*@(^&r)
 f^:_ [1
)


NB. ^ -------------------------------------------------------------------

x1 (^ -: ^&.x:) y=:10 11?@$100
x2 (^ -: ^&.x:) y
x3 (^ -: ^&.x:) y

1 = 1^x: _3 0 3
1 = 1^y1
1 = 1^y2
1 = 1^y3
1 = 1^x: 1e50

1 0 0 0 0 -: 0 ^ x: i.5
(0=t) -: 0^t=:|y1
(0=t) -: 0^t=:|y2
(0=t) -: 0^t=:|y3
0     -: 0^x: 1e50

x1 (^ -: ^&.x:) t=:($x1)?@$50
x2 (^ -: ^&.x:) t=:($x2)?@$50
x3 (^ -: ^&.x:) t=:($x3)?@$50

3  (<.!.0@^ -: <.@^&x:) t=:_3+i.7
_3 (<.!.0@^ -: <.@^&x:) t
3  (>.!.0@^ -: >.@^&x:) t=:_3+i.7
_3 (>.!.0@^ -: >.@^&x:) t

f=: 100&|@^
(2 f e) -: 2 f (20|e)+20*20<e=:(10^100x)+4 5?@$100
(3 f e) -: 3 f 20|e
(4 f e) -: 4 f (10|e)+10*10<e
(5 f e) -: 5 f 2<.e
(6 f e) -: 6 f ( 5|e)+ 5* 5<e
(7 f e) -: 7 f 4 |e
(8 f e) -: 8 f (20|e)+20*20<e
(9 f e) -: 9 f 10|e

_   -: 0 ^ _2x
1r9 -: 3 ^ _2x
1r9 -: 3 ^ _2x 

'limit error' -: 2 ^ etx 10^100x

e0=: 3 : 0  NB. calculate e to y decimal places
 k=: 1
 a=: b=: 1x
 d=: 10x^y
 e=: +:d
 whilst. b<e do.
  a=: >: a * k
  b=: b * k
  k=: >:k
 end.
 (a*d) <.@% b
)

e1=: 3 : 0
 (+/ , {.) */\. }. (i.y),1x
)

x=: ^/~ 10%~i:10x
y=: ^/~ 10%~i:9x
y -: 1 1}. _1 _1}.x


NB. ~. ------------------------------------------------------------------

(~.    x) -: ~.    x: x=:_1e9+?100$2e9
(~.<"0 x) -: ~.<"0 x: x

NB. *** (<"0 ~.x,y) -: ~.(<"0 x: x),<"0 y=:x+0.5*?($x)$2


NB. ~: ------------------------------------------------------------------

(x1~:y) -: (x: x1) ~: y=:x1+0.5*($x1)?@$2
(x2~:y) -: (x: x2) ~: y=:x2+0.5*($x2)?@$2
(x3~:y) -: (x: x3) ~: y=:x3+0.5*($x3)?@$2

(x1~:y) -: (x: x1) ~: y=:x1+j./(2,$x1)?@$2
(x2~:y) -: (x: x2) ~: y=:x2+j./(2,$x1)?@$2
(x3~:y) -: (x: x3) ~: y=:x3+j./(2,$x1)?@$2

1 1 0 -: 3 3.4 4 ~: x:4
1 1 0 -: 3 3j4 4 ~: x:4
1 1 1 -: '3j4' ~:x:4


NB. | -------------------------------------------------------------------

(| -: |&.x:) y1
(| -: |&.x:) y2
(| -: |&.x:) y3

x1 (| -: |&.x:) y1
x1 (| -: |&.x:) y2
x1 (| -: |&.x:) y3
x2 (| -: |&.x:) y1
x2 (| -: |&.x:) y2
x2 (| -: |&.x:) y3
x3 (| -: |&.x:) y1
x3 (| -: |&.x:) y2
x3 (| -: |&.x:) y3

0 0 0 -: (x: _123 0 1234) | 0

x=: 15 15 _15 _15
y=: 4 _4 4 _4 * x
(x|y) -: x |&.x: y

(| -: | &.x:) y1
(| -: | &.x:) y2
(| -: | &.x:) y3
(| -: | &.x:) _1e8 _1e4 0 1e4 1e8

(| -: | &.x:)~ y1
(| -: | &.x:)~ y2
(| -: | &.x:)~ y3
(| -: | &.x:)~ _1e8 _1e4 0 1e4 1e8

(|/~ -: |/~@:x:)      _20+i.41
(|/~ -: |/~@:x:)  1e4+_20+i.41
(|/~ -: |/~@:x:) 20e4+_20+i.41
(|/~ -: |/~@:x:) 27e4+_20+i.41
(|/~ -: |/~@:x:) (imin+i. 20),(imax-i. 20),((<.-:imin)+i: 20),((<.-:imax)+i: 20),i: 20

(x1 | 3.4) -: (x: x1) | etx 3.4
(x1 | 3j4) -: (x: x1) | etx 3j4

'domain error' -: (x: x1) | etx 'a'
'domain error' -: (x: x1) | etx <12


NB. . -------------------------------------------------------------------

x=: _1e6+ 5 13 ?@$ 2e6
y=: _1e6+13  7 ?@$ 2e6
x (+/ .* -: +/ .*&.x:) y
x (+/ .* -: +/ .*&.x:) 1
x (+/ .* -: +/ .*&.x:) 2
x (+/ .* -: +/@(*"1 _))&:x: y

((x: x) +/ .* 1) -: (x: x) +/ .* 13$1
((x: x) +/ .* 2) -: (x: x) +/ .* 13$2


NB. : -------------------------------------------------------------------

f=: 3 : 'if. y do. ''non-zero'' else. ''zero'' end.'

'zero'     -: f    0
'zero'     -: f x: 0

'non-zero' -: f    12
'non-zero' -: f x: 12


NB. #. ------------------------------------------------------------------

(#. -: #.&:x:) x1
(#. -: #.&:x:) x2
(#. -: #.&:x:) x3

3 (#. -: #.&:x:) x1
3 (#. -: #.&:x:) x2
3 (#. -: #.&:x:) x3


NB. #: ------------------------------------------------------------------

(!x:20) -: #. #: !x:20
(!x:40) -: #. #: !x:40
(!x:60) -: #. #: !x:60

(!x:20) -: 10 #. (90$10) #: !x:20
(!x:40) -: 10 #. (90$10) #: !x:40
(!x:60) -: 10 #. (90$10) #: !x:60


NB. ! -------------------------------------------------------------------

(!  -: !&.x:) i.10
(!@x: -: */@:>:@i.@x:"0) x=:2 10?@$150

(!/~ -: !/~@:x:) _11+i.21
(i.10) (! -: !&.x:) 2e9
   
min=: [ <. -~
arg=: |.@(] - i.@min) ,. >:@i.@min
f  =: (% +./)@:*
bc =: {. @ (f/) @ arg " 0

(x=:1+20?@$20) (! -: bc&.x:) y=:1e9*1+20?@$20

ind =: i.@(0&>.)@([ <. -~)
pf  =: -.&0 @: , @: q:
num =: pf @ (]  - ind)
den =: pf @ (1: + ind)
exp =: , +//. ,&# # 1 _1"_
bct =: num (exp */@:x:@:# ~.@,) den

x (! -: bct"0) 10+x=:i.11
(x=:1+?20$20) (bc&x: -: bct"0&x:) y=:1e6*1+20?@$20

bc2=: ((i.@[ -~ ]) %&(*/) >:@i.@[)&x:

3  (! -: bc2) 4*x:2e9
10 (! -: bc2) 8*x:2e9

(-: */x-0 1) -: 2 ! x=:*/x: 10?@$1e8


NB. 3!:x ----------------------------------------------------------------

y=: !x:2 10?@$200
y -: 3!:2 (3!:1) y


NB. /: ------------------------------------------------------------------

(/: -: /:@:       x:) y=:_100+2000?@$200
(/: -: /:@:(<"0)@:x:) y
(/: -: /:@:       x:) y=:_1e9+2000?@$2e9
(/: -: /:@:(<"0)@:x:) y

test=: 4 : '(/:(<"_1 x),<"_1 y) -: /:(<"_1 x: x),<"_1 y'

(x=:_1e9+100  ?@$2e9) test y=: o._1e9+100  ?@$2e9
(x=:_1e9+100 2?@$2e9) test y=: -:_1e9+100  ?@$2e9
(x=:_1e9+100  ?@$2e9) test y=: -:_1e9+100 2?@$2e9
(x=:_1e9+100 2?@$2e9) test y=: o._1e9+100 2?@$2e9


NB. \: ------------------------------------------------------------------

(\: -: \:@:       x:) y=:_100+2000?@$200
(\: -: \:@:(<"0)@:x:) y
(\: -: \:@:       x:) y=:_1e9+2000?@$2e9
(\: -: \:@:(<"0)@:x:) y

test=: 4 : '(\:(<"_1 x),<"_1 y) -: \:(<"_1 x: x),<"_1 y'

(x=:_1e9+100  ?@$2e9) test y=: o._1e9+100  ?@$2e9
(x=:_1e9+100 2?@$2e9) test y=: -:_1e9+100  ?@$2e9
(x=:_1e9+100  ?@$2e9) test y=: -:_1e9+100 2?@$2e9
(x=:_1e9+100 2?@$2e9) test y=: o._1e9+100 2?@$2e9


NB. ". ------------------------------------------------------------------

(x: y) -: ". ;(":&.>y),&.><'x ' [ y=: +: _1e9+200?@$2e9
(x: y) -: ". ;(":&.>y),&.><'x ' [ y=: ,y1
(x: y) -: ". ;(":&.>y),&.><'x ' [ y=: ,y2
(x: y) -: ". ;(":&.>y),&.><'x ' [ y=: ,y3

(x: 123 _99 456789) -: _99 ". '123x foo 456789'

3.4 45 -: 3.4 ". etx '123x 45'

'ill-formed number' -: ". etx '1234ex'
'ill-formed number' -: ". etx '123x _x x'
'ill-formed number' -: ". etx '3j4x'
'ill-formed number' -: ". etx '123.4 34x'


NB. extended integer comparisons ----------------------------------------

x=: 2 2.2 2.5 3 3.5 3.7 4
y=: _4 _3 _2 _1 0 1 2 3 4

x (<  -: (<  x:)) 3
x (<: -: (<: x:)) 3
x (=  -: (=  x:)) 3
x (~: -: (~: x:)) 3
x (>: -: (>: x:)) 3
x (>  -: (>  x:)) 3

(-x) (<  -: (<  x:)) _3
(-x) (<: -: (<: x:)) _3
(-x) (=  -: (=  x:)) _3
(-x) (~: -: (~: x:)) _3
(-x) (>: -: (>: x:)) _3
(-x) (>  -: (>  x:)) _3

(x,-x) (< / -: (<  x:)"0/) y
(x,-x) (<:/ -: (<: x:)"0/) y
(x,-x) (= / -: (=  x:)"0/) y
(x,-x) (~:/ -: (~: x:)"0/) y
(x,-x) (>:/ -: (>: x:)"0/) y
(x,-x) (> / -: (>  x:)"0/) y

3 (<  -: x:@[ <  ]) x
3 (<: -: x:@[ <: ]) x
3 (=  -: x:@[ =  ]) x
3 (~: -: x:@[ ~: ]) x
3 (>: -: x:@[ >: ]) x
3 (>  -: x:@[ >  ]) x

_3 (<  -: x:@[ <  ]) -x
_3 (<: -: x:@[ <: ]) -x
_3 (=  -: x:@[ =  ]) -x
_3 (~: -: x:@[ ~: ]) -x
_3 (>: -: x:@[ >: ]) -x
_3 (>  -: x:@[ >  ]) -x

y (< / -: (x:@[ <  ])"0/) x,-x
y (<:/ -: (x:@[ <: ])"0/) x,-x
y (= / -: (x:@[ =  ])"0/) x,-x
y (~:/ -: (x:@[ ~: ])"0/) x,-x
y (>:/ -: (x:@[ >: ])"0/) x,-x
y (> / -: (x:@[ >  ])"0/) x,-x

x=: 10?@$20
y=: 0.5*20?@$40
(x i. y) -: (x: x) i. y
(y i. x) -: y i. x: x


NB. A. ------------------------------------------------------------------

(<: ! x: #y) = A. |. y=:i.50

'index error' -: (   !50x) A. etx i.50
'index error' -: (->:!50x) A. etx i.50


NB. e. ------------------------------------------------------------------

x=:1000?@$500
y=:0.25 * 1200?@$2000

(x e. y) -: (x: x) e. y
(y e. x) -: y e. x: x


NB. i. ------------------------------------------------------------------

(type -: type@i.) x: 5
(type -: type@i.) x: 0
(type -: type@i.) x: 4 5
(type -: type@i.) x: _4 5
(type -: type@i.) x: 4 0

(x:@i. -: i.@:x:) 5
(x:@i. -: i.@:x:) 4 5
(x:@i. -: i.@:x:) _4 5

x=:_1e9+400?@$2e9
y=:x+0.5*($x)?@$2

(x i. y) -: (x: x) i. y
(y i. x) -: y i. x: x

(x i. x) -: (<"0 x: x) i. <"0 x
(x i. x) -: (<"0    x) i. <"0 x: x
(x i. x) -: (<"0 x: x) i. <"0 x: x

(x i. y) -: (<"0 x: x) i. <"0 y
(x i. y) -: (<"0    x) i. <"0 x: y
(x i. y) -: (<"0 x: x) i. <"0 x: y


NB. j. ------------------------------------------------------------------

(j. x: x1) -: j. x1


NB. p. ------------------------------------------------------------------

x=: _100+7?@$200
c=: _100+?   200

(c;x) (p. -: x:^:_1@(p.x:)) y1
(c;x) (p. -: x:^:_1@(p.x:)) y2
(c;x) (p. -: x:^:_1@(p.x:)) y3

x (p. -: x:^:_1@:p.&:x:) y1
x (p. -: x:^:_1@:p.&:x:) y2
x (p. -: x:^:_1@:p.&:x:) y3

(p. 1 2 3 5) -: p. x: 1 2 3 5


NB. q: ------------------------------------------------------------------

f=: 3 : 0
 x=: q: y
 (y=*/x: x) *. *./x e. p:i.>:p:^:_1 {:x
)

f !20x
f !30x
f 12345678901234567890x
 
18 8 4 2 1 1 1 1 -: _ q: !20x
(!20x) -: */ (p: i.#x)^x:x=: _ q: !20x
(!30x) -: */ (p: i.#x)^x:x=: _ q: !30x

H  =: %@>:@(+/~)@i.  NB. Hilbert matrix
det=: -/ .*

(~.@q:@%@det@H -: i.&.(p:^:_1)@+:) 5x
(~.@q:@%@det@H -: i.&.(p:^:_1)@+:) 6x
(~.@q:@%@det@H -: i.&.(p:^:_1)@+:) 7x
(~.@q:@%@det@H -: i.&.(p:^:_1)@+:) 8x
(~.@q:@%@det@H -: i.&.(p:^:_1)@+:) 9x


4!:55 ;:'arg bc bc2 bct c den det e e0 e1 exp f H ind min n'
4!:55 ;:'num pf root t test x x1 x2 x3 y y1 y2 y3'



echo^:ECHOFILENAME 'memory used: ',":7!:1''

