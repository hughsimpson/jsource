prolog './g1x7.ijs'
NB. 1!:7 ----------------------------------------------------------------

write =: 1!:2
mkdir =: 1!:5
perm  =: 1!:7
open  =: 1!:21
close =: 1!:22
erase =: 1!:55

unix  =: (9!:12 '') e. 5 7
nn    =: unix{3 9

test  =: 3 : ('((,nn)-:$y) *. *./y e."_1 nn$''rwx'',.''-''')

erase ::1: ('brandnew/'&,)&.> {."1[ 1!:0<'brandnew/*'
erase ::1: <'brandnew'
d =. <'brandnew'
mkdir d
test perm d
erase d

f =. <jpath (UNAME-:'Android'){::'~temp/foogoo5.x';'~bin/foogoo5.x'
'foo upon thee' write f
test perm f

(nn$'r--') perm f
(nn$'r--') = perm f
(nn$'rw-') perm f
(nn$'rw-') = perm f
h =. open f
(nn$'rw-') = perm h
close h

h =. open f
(perm h) -: perm f
(perm h) -: perm <h
close h

erase f


NB. 1!:7 ----------------------------------------------------------------

perm =: 1!:7

'domain error'      -: perm etx 'a'
'domain error'      -: perm etx 'abc'
'domain error'      -: perm etx 3.45
'domain error'      -: perm etx 3j4
'domain error'      -: perm etx <3.45
'domain error'      -: perm etx <3j4
'domain error'      -: perm etx <<'abc'

'rank error'        -: perm etx <0 1 0
'rank error'        -: perm etx <,4
'rank error'        -: perm etx <1 3$'abc'

'length error'      -: perm etx <''

'file name error'   -: perm etx <'1234skidoo'
'file name error'   -: perm etx <'does/not/exist'

'file number error' -: perm etx 0
'file number error' -: perm etx 1
'file number error' -: perm etx 2
'file number error' -: perm etx 12345 12346

'domain error'      -: 0 1 0 perm etx <jpath '~temp/foo.x'
'domain error'      -: 3 1   perm etx <jpath '~temp/foo.x'
'domain error'      -: 3.5   perm etx <jpath '~temp/foo.x'
'domain error'      -: 3j4   perm etx <jpath '~temp/foo.x'
'domain error'      -: (<'r')perm etx <jpath '~temp/foo.x'
'domain error'      -: (nn$'abc') perm etx <jpath '~temp/foo.x'
'domain error'      -: (nn$'a--') perm etx <jpath '~temp/foo.x'
'domain error'      -: (nn$'-a-') perm etx <jpath '~temp/foo.x'
'domain error'      -: (nn$'--a') perm etx <jpath '~temp/foo.x'

'length error'      -: 'wx'  perm etx <jpath '~temp/foo.x'

4!:55 ;:'close d erase f h mkdir nn open perm test unix write '



epilog''

