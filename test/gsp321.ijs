1:@:(dbr bind Debug)@:(9!:19)2^_44[(prolog [ echo^:ECHOFILENAME) './gsp321.ijs'
NB. ,. -------------------------------------------------------------------

f=: 4 : '(*./ scheck t) *. (,."x d) -: t=: ,."x s=:(2;y)$.d'
d=: (?5 7$2) * ?5 7 3 2$4

(i.>:r) f&>/ c=: ; (i.1+r) <"1@comb&.>r=:#$d

s=: 1 $. 2e9 3 4;0;0
s=: (?7 3 4$4) (?7$2e9)}s
scheck s
scheck ,."2 s

'limit error' -: ,.   etx 1 $.(4$2e9);0 1 2;0
'limit error' -: ,."3 etx 1 $.(>IF64{2 1 4 2e9;2 1 1e10 2e9);0 1 2;0

f=: 4 : '(a ,."r        b) -: (s=: (2;x)$.a) ,."r        t=: (2;y)$.b'
h=: 4 : '(a ,."r&(97&+) b) -: (s=: (2;y)$.a) ,."r&(97&+) t=: (2;y)$.b'

c=: ; (i.1+r) <"1@comb&.>r=:#$a=: (?2 5 3$2) * ?2 5 3 4$5
d=: ; (i.1+r) <"1@comb&.>r=:#$b=: (?2 5 3$2) * ?2 5 3 4$5

c f&>/d [ r=: 0
c f&>/d [ r=: 1
c f&>/d [ r=: 2
c f&>/d [ r=: 3
c f&>/d [ r=: 4

c h&>/d [ r=: 0
c h&>/d [ r=: 1
c h&>/d [ r=: 2
c h&>/d [ r=: 3
c h&>/d [ r=: 4


4!:55 ;:'a b c d f g h r s t'



echo^:ECHOFILENAME 'memory used: ',":7!:1''

