1:@:(dbr bind Debug)@:(9!:19)2^_44[(prolog [ echo^:ECHOFILENAME) './g130a.ijs'
NB. B % B ---------------------------------------------------------------

x=: ?100$2
y=: ?100$2
(x%y) -: (#.x,.y){0 0 _ 1
(x%y) -: (z+x)%z+y   [ z=:{.0 4.5
(x%y) -: (z*x)%z*y   [ z=:{.1 4j5
(z%y) -: (($y)$z)%y  [ z=:?2
(x%z) -: x%($x)$z    [ z=:?2

(x%y) -: (40$"0 x)%y [ x=: ?10$2    [ y=: ?10 40$2
(x%y) -: x%40$"0 y   [ x=: ?10 40$2 [ y=: ?10$2

0 0 _ 1 -: 0 0 1 1 % 0 1 0 1


NB. B % I ---------------------------------------------------------------

x=: ?100$2
y=: _1e5+?100$2e5
(x%y) -: (z+x)%z+y   [ z=:{.0 4.5
(x%y) -: (z*x)%z*y   [ z=:{.1 4j5
(z%y) -: (($y)$z)%y  [ z=:?2
(x%z) -: x%($x)$z    [ z=:_1e5+?2e5

(x%y) -: (40$"0 x)%y [ x=: ?10$2    [ y=: _1e5+?10 40$2e5
(x%y) -: x%40$"0 y   [ x=: ?10 40$2 [ y=: _1e5+?10$2e5

0 0 0 0.25 _0.33333333333333 -: 0 0 0 1 1 % 0 _4 3 4 _3


NB. B % D ---------------------------------------------------------------

x=: ?100$2
y=: o._1e5+?100$2e5
(x%y) -: (z+x)%z+y   [ z=:{.0 4.5
(x%y) -: (z*x)%z*y   [ z=:{.1 4j5
(z%y) -: (($y)$z)%y  [ z=:?2
(x%z) -: x%($x)$z    [ z=:o._1e5+?2e5

(x%y) -: (40$"0 x)%y [ x=: ?10$2    [ y=: o._1e5+?10 40$2e5
(x%y) -: x%40$"0 y   [ x=: ?10 40$2 [ y=: o._1e5+?10$2e5

0 0 0 _0.2 0.25 -: 0 0 0 1 1 % 0 _5 1.2 _5 4


NB. I % B ---------------------------------------------------------------

x=: _1e5+?100$2e5
y=: ?100$2
(x%y) -: (z+x)%z+y   [ z=:{.0 4.5
(x%y) -: (z*x)%z*y   [ z=:{.1 4j5
(z%y) -: (($y)$z)%y  [ z=:_1e5+?2e5
(x%z) -: x%($x)$z    [ z=:?2

(x%y) -: (40$"0 x)%y [ x=: _1e5+?10$2e5    [ y=: ?10 40$2
(x%y) -: x%40$"0 y   [ x=: _1e5+?10 40$2e5 [ y=: ?10$2

__ _5 _ 4 -: _5 _5 4 4 % 0 1 0 1


NB. I % I ---------------------------------------------------------------

x=: _1e5+?100$2e5
y=: _1e5+?100$2e5
(x%y) -: (z+x)%z+y   [ z=:{.0 4.5
(x%y) -: (z*x)%z*y   [ z=:{.1 4j5
(z%y) -: (($y)$z)%y  [ z=:?2e6
(x%z) -: x%($x)$z    [ z=:_1e5+?2e5

(x%y) -: (40$"0 x)%y [ x=: _1e5+?10$2e5    [ y=: _1e5+?10 40$2e5
(x%y) -: x%40$"0 y   [ x=: _1e5+?10 40$2e5 [ y=: _1e5+?10$2e5

_1.5 _4 _ 6 3.5 -: 3 4 5 6 7 % _2 _1 0 1 2



NB. I % D ---------------------------------------------------------------

x=: _1e5+?100$2e5
y=: o._1e5+?100$2e5
(x%y) -: (z+x)%z+y   [ z=:{.0 4.5
(x%y) -: (z*x)%z*y   [ z=:{.1 4j5
(z%y) -: (($y)$z)%y  [ z=:?2e6
(x%z) -: x%($x)$z    [ z=:o._1e5+?2e5

(x%y) -: (40$"0 x)%y [ x=: _1e5+?10$2e5    [ y=: o._1e5+?10 40$2e5
(x%y) -: x%40$"0 y   [ x=: _1e5+?10 40$2e5 [ y=: o._1e5+?10$2e5

_2 0 2 -: _1 0 1%0.5


NB. D % B ---------------------------------------------------------------

x=: o._1e5+?100$2e5
y=: ?100$2
(x%y) -: (z+x)%z+y   [ z=:{.0 4.5
(x%y) -: (z*x)%z*y   [ z=:{.1 4j5
(z%y) -: (($y)$z)%y  [ z=:o._1e5+?2e5
(x%z) -: x%($x)$z    [ z=:?2

(x%y) -: (40$"0 x)%y [ x=: o._1e5+?10$2e5    [ y=: ?10 40$2
(x%y) -: x%40$"0 y   [ x=: o._1e5+?10 40$2e5 [ y=: ?10$2

 0.25 _  -:  0.25 % 1 0
_0.25 __ -: _0.25 % 1 0


NB. D % I ---------------------------------------------------------------

x=: o._1e5+?100$2e5
y=: _1e5+?100$2e5
(x%y) -: (z+x)%z+y   [ z=:{.0 4.5
(x%y) -: (z*x)%z*y   [ z=:{.1 4j5
(z%y) -: (($y)$z)%y  [ z=:o._1e5+?2e5
(x%z) -: x%($x)$z    [ z=:_1e5+?2e5

(x%y) -: (40$"0 x)%y [ x=: o._1e5+?10$2e5    [ y=: _1e5+?10 40$2e5
(x%y) -: x%40$"0 y   [ x=: o._1e5+?10 40$2e5 [ y=: _1e5+?10$2e5

_0.25  _0.5 _   0.5  0.25 -:  0.5 % _2 _1 0 1 2
 0.25   0.5 __ _0.5 _0.25 -: _0.5 % _2 _1 0 1 2


NB. D % D ---------------------------------------------------------------

x=: o._1e5+?100$2e5
y=: o._1e5+?100$2e5
(x%y) -: (z+x)%z+y   [ z=:{.0 4.5
(x%y) -: (z*x)%z*y   [ z=:{.1 4j5
(z%y) -: (($y)$z)%y  [ z=:o._1e5+?2e5
(x%z) -: x%($x)$z    [ z=:o._1e5+?2e5

(x%y) -: (40$"0 x)%y [ x=: o._1e5+?10$2e5    [ y=: o._1e5+?10 40$2e5
(x%y) -: x%40$"0 y   [ x=: o._1e5+?10 40$2e5 [ y=: o._1e5+?10$2e5

_4 _0.25 -: _2 0.5 % 0.5 _2

4!:55 ;:'x y z'



echo^:ECHOFILENAME 'memory used: ',":7!:1''

