1:@:(dbr bind Debug)@:(9!:19)2^_44[(prolog [ echo^:ECHOFILENAME) './gpco.ijs'
NB. p: ------------------------------------------------------------------

pt =. 1&< *. *./@(0&~:)@(2&}.@i.@>:@<.@%: |/ ]) 

(p: i.25) -: (pt"0 # ]) i.100
(p: i.25) -: p:"0 i.25
1 = #@q: p:i.5 20

v =.p:i.2000
({&v -: p:) ?2   $2000
({&v -: p:) ?20  $2000
({&v -: p:) ?200 $2000
({&v -: p:) ?2000$2000

2147483629  -: p: 105097563
2147483647  -: p: 105097564
(<._1+2^31) -: p: 105097564

NB. LeVeque, Fundamentals of Number Theory, Addison-Wesley, 1977, p. 5.

0 1 -: 1e1 < p: _1 0+ 4
0 1 -: 1e2 < p: _1 0+ 25
0 1 -: 1e3 < p: _1 0+ 168
0 1 -: 1e4 < p: _1 0+ 1229
0 1 -: 1e5 < p: _1 0+ 9592
0 1 -: 1e6 < p: _1 0+ 78498
0 1 -: 1e7 < p: _1 0+ 664579
0 1 -: 1e8 < p: _1 0+ 5761455
0 1 -: 1e9 < p: _1 0+ 50847534

4  = 3!:0 p: 100
4  = 3!:0 p: {.100 4.5
64 = 3!:0 p: 100x
64 = 3!:0 p: 100r1

'domain error' -: p: etx _1
'domain error' -: p: etx <.-2^31
'domain error' -: p: etx '5'
'domain error' -: p: etx <12
'domain error' -: p: etx 3.4
'domain error' -: p: etx 3j4

'limit error'  -: p: etx 1e30
'limit error'  -: p: etx 10^30x

P100   =: 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97
plt100 =: P100&< # P100"_

0 0 0 0 0 -: p:^:_1 ] _1 _2 0 1 2
(p:^:_1 t) -: p:^:_1 >. t=: o. 3 4?@$ 20

mask   =: [ $&> ($ - {. 1:)&.>@]
sieve  =: ] , [: }. -.@(+./)@mask # >:@i.@[
plt    =: plt100 ` (sieve $:@>:@<.@%:) @. (100&<)

(plt -: i.&.(p:^:_1))"0      i.5 20
(plt -: i.&.(p:^:_1))"0 ]100*i.5 20

plt1=: 3 : 0
 m=. y-1
 z=. m (>: # ]) 2 3 5
 if. 5>:y do. return. end.
 b=. 1 0:}m $ 0 1 1 1 1 1 0 1 1 1 0 1 0 1 1 1 0 1 0 1 1 1 0 1 1 1 1 1 0 1
 r=. <.%:m
 while. r>:j=.1+b i. 0 do.
  z=. z,j
  b=. b +. m$(-j){.1
 end.
 z=. z,1+(-.b)#i.m
)

(plt1 -: i.&.(p:^:_1))"0      i.5 20
(plt1 -: i.&.(p:^:_1))"0 ]100*i.5 20


NB. p: Goldbach's conjecture --------------------------------------------

Goldbach=: 3 : 0
 j =. }. i.<:-:y
 z =. (1+#j)$2
 p =. i.&.(p:^:_1) y
 pt=. 1 p}y$0
 i =. 1
 whilst. #j=. (-.c)#j do. 
  c=. pt {~ (4++:j)-i{p
  z=. (i{p) (c#j)}z
  i=. >:i
 end.
 (4+i.@<:&.-:y) (,. ,. -) z
)

t=: Goldbach n=: 4+2*?1e5
($t) -: (<:-:n),3
({."1 t) -: 4+i.@<:&.-: n
({."1 t) -: +/"1 }."1 t
*./ , (}."1 t) e. i.&.(p:^:_1) n


4!:55 ;:'Goldbach mask n P100 plt plt1 plt100 pt sieve t v'



echo^:ECHOFILENAME 'memory used: ',":7!:1''

