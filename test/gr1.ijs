1:@:(dbr bind Debug)@:(9!:19)2^_44[(prolog [ echo^:ECHOFILENAME) './gr1.ijs'
NB. 2r3 -----------------------------------------------------------------

rat =: 128&=@type
intx=:  64&=@type
int =:   4&=@type
fl  =:   8&=@type
cmpx=:  16&=@type

5r2  -: 10r4
5r2  -: _5r_2
_5r2 -: 5r_2
0r1 -: 0r7 
0r1 -: 0r_7
0r1 -: 0r12345678901234567890
0r1 -: 0r_12345678901234567890
 
0r1 -: 0r0
0r1 -: 0r9
0r1 -: 0r_9

(fl   x) *. 1 2 3.2      -: x=: 1 4r2 3.2
(fl   x) *. 1 2 0.03     -: x=: 1 4r2 3e_2
(int  x) *. 1 2 300      -: x=: 1 4r2 3e2
(fl   x) *. 1 2 3e20     -: x=: 1 4r2 3e20
(cmpx x) *. 1 2 3j2      -: x=: 1 4r2 3j2
(rat x) *. 1r1 2r1 _3r1 -: x=: 1 2r1 _3x
(intx x) *. 1r1 2r1 _3r1 -: x=: 1 2x _3x

(rat x) *. 1 0.5 _       -: x=: 1 1r2 _
(rat x) *. 1 0.5 __      -: x=: 1 1r2 __ 
(rat x) *. 1 0.5 _  1.25 -: x=: 1 1r2 _  5r4
(rat x) *. 1 0.5 __ 1.25 -: x=: 1 1r2 __ 5r4
(rat x) *. _  1.25 1 0.5 -: x=: _  5r4 1 1r2 
(rat x) *. __ 1.25 1 0.5 -: x=: __ 5r4 1 1r2 

(fl  x) *. 1 0.5 _.      -:&(3!:1) x=: 1 1r2 _. 
(fl  x) *. 1 0.5 _. 1.25 -:&(3!:1) x=: 1 1r2 _. 5r4
(fl  x) *. _. 1.25 1 0.5 -:&(3!:1) x=: _. 5r4 1 1r2 

(rat x) *. 0.5 _  -: x=: 1r2  3r0
(rat x) *. 0.5 __ -: x=: 1r2 _3r0


4!:55 ;:'cmpx fl int intx rat x'



echo^:ECHOFILENAME 'memory used: ',":7!:1''

