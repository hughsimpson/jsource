1:@:(dbr bind Debug)@:(9!:19)2^_44[(prolog [ echo^:ECHOFILENAME) './g130p.ijs'
NB. %/\ B ---------------------------------------------------------------

(0 0 1 1 ,: 0 0 _ 1) -: %/\ 0 0 1 1 ,: 0 1 0 1
(20$1)  -: %/\20$1
x -: %/\x=:0 0 0
x -: %/\x=:0 0 0 0

div=: 4 : 'x%y'

(%/\   -: div/\  ) x=:     13$1
(%/\   -: div/\  ) x=: 0,  12$1
(%/\   -: div/\  ) x=:   7 13$1
(%/\   -: div/\  ) x=: 0,6 13$1
(%/\"1 -: div/\"1) x
(%/\   -: div/\  ) x=: 3 5 13$1
(%/\"1 -: div/\"1) x
(%/\"2 -: div/\"2) x
(%/\   -: div/\  ) x=:    12$1
(%/\   -: div/\  ) x=:4   12$1
(%/\"1 -: div/\"1) x
(%/\   -: div/\  ) x=:4 8 12$1
(%/\"1 -: div/\"1) x
(%/\"2 -: div/\"2) x


NB. %/\ I ---------------------------------------------------------------

div=: 4 : 'x%y'

x -: %/\x=: [&.>: 0 0 0
x -: %/\x=: [&.>: 0 0 0 0

(%/\ -: div/\) x=:1 2 3 1e9 2e9
(%/\ -: div/\) |.x

(%/\   -: div/\  ) x=: x+0=x=:_1e2+?    13$2e2
(%/\   -: div/\  ) x=: x+0=x=:_1e2+?4   13$2e2
(%/\"1 -: div/\"1) x
(%/\   -: div/\  ) x=: x+0=x=:_1e2+?3 5 13$2e2
(%/\"1 -: div/\"1) x
(%/\"2 -: div/\"2) x

(%/\   -: div/\  ) x=: x+0=x=:_1e9+?    13$2e9
(%/\   -: div/\  ) x=: x+0=x=:_1e9+?4   13$2e9
(%/\"1 -: div/\"1) x
(%/\   -: div/\  ) x=: x+0=x=:_1e9+?3 5 13$2e9
(%/\"1 -: div/\"1) x
(%/\"2 -: div/\"2) x


NB. %/\ D ---------------------------------------------------------------

div=: 4 : 'x%y'

x -: %/\x=: [&.o. 0 0 0
x -: %/\x=: [&.o. 0 0 0 0

(%/\   -: div/\  ) x=: x+0=x=:0.01*_1e4+?    13$2e4
(%/\   -: div/\  ) x=: x+0=x=:0.01*_1e4+?4   13$2e4
(%/\"1 -: div/\"1) x
(%/\   -: div/\  ) x=: x+0=x=:0.01*_1e4+?3 5 13$2e4
(%/\"1 -: div/\"1) x
(%/\"2 -: div/\"2) x


NB. %/\ Z ---------------------------------------------------------------

div=: 4 : 'x%y'

x -: %/\x=: [&.j. 0 0 0
x -: %/\x=: [&.j. 0 0 0 0

(%/\   -: div/\  ) x=: x+0=x=:j./0.1*_1e2+?2     13$2e2
(%/\   -: div/\  ) x=: x+0=x=:j./0.1*_1e2+?2 4   13$2e2
(%/\"1 -: div/\"1) x
(%/\   -: div/\  ) x=: x+0=x=:j./0.1*_1e2+?2 3 5 13$2e2
(%/\"1 -: div/\"1) x
(%/\"2 -: div/\"2) x

(,'j')    -: %/\'j'
(,<'ace') -: %/\<'ace'
(,'j')    -: %/\u:'j'
(,<'ace') -: %/\<u:'ace'
(,'j')    -: %/\10&u:'j'
(,<'ace') -: %/\<10&u:'ace'
(,s:@<"0 'j')    -: %/\s:@<"0 'j'
(,s:@<"0&.> <'ace') -: %/\s:@<"0&.> <'ace'
(,<"0@s: <'ace') -: %/\<"0@s: <'ace'

'domain error' -: %/\ etx 'deipnosophist'
'domain error' -: %/\ etx ;:'peace in our time'
'domain error' -: %/\ etx u:'deipnosophist'
'domain error' -: %/\ etx u:&.> ;:'peace in our time'
'domain error' -: %/\ etx 10&u:'deipnosophist'
'domain error' -: %/\ etx 10&u:&.> ;:'peace in our time'
'domain error' -: %/\ etx s:@<"0 'deipnosophist'
'domain error' -: %/\ etx s:@<"0&.> ;:'peace in our time'
'domain error' -: %/\ etx <"0@s: ;:'peace in our time'

4!:55 ;:'div x'



echo^:ECHOFILENAME 'memory used: ',":7!:1''

