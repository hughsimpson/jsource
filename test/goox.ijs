1:@:(dbr bind Debug)@:(9!:19)2^_44[(prolog [ echo^:ECHOFILENAME) './goox.ijs'
NB. order of execution --------------------------------------------------

g=: 3 : 0
 y
 :
 x,y
)

f=: 3 : 0
 y   [ xx=: xx,'f',y
 :
 x,y [ xx=: xx,'f',x,y
)

h=: 3 : 0
 y   [ xx=: xx,'h',y
 :
 x,y [ xx=: xx,'h',x,y
)

'bb'   -:     (f g h) 'b' [ xx=: $0
xx -: 'hbfb'

'abab' -: 'a' (f g h) 'b' [ xx=: $0
xx -: 'habfab'

'ab' -: 'a' g&h 'b' [ xx=: $0
xx -: 'hbha'

'ab' -: 'a' g&:h 'b' [ xx=: $0
xx -: 'hbha'


4!:55 ;:'f g h xx'



echo^:ECHOFILENAME 'memory used: ',":7!:1''

