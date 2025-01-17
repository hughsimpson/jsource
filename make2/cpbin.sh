#!/bin/sh

_DEBUG="${_DEBUG:=0}"
if [ $_DEBUG -eq 1 ] ; then
DEBUGDIR="-debug"
else
DEBUGDIR=
fi

# copy binaries in bin/ to jlibrary/bin

cop(){
# $1 src
# $2 srclib
# $3 dest
# $4 destlib
# MUST rename/remove object first; overwrite cause cache error
if [ -f "../bin/${jplatform}/$1$DEBUGDIR/$2" ]; then
if [ -f "../jlibrary/$3/$4" ]; then
mv -f "../jlibrary/$3/$4" "/tmp/$4.old.$$"
fi
echo \# cp "../bin/${jplatform}/$1$DEBUGDIR/$2" "../jlibrary/$3/$4"
cp "../bin/${jplatform}/$1$DEBUGDIR/$2" "../jlibrary/$3/$4"
fi
}

cd "`dirname "$0"`"

if [ "`uname -m`" = "armv6l" ] || [ "`uname -m`" = "aarch64" ] || [ "$RASPI" = 1 ]; then
jplatform="${jplatform:=raspberry}"
elif [ "`uname`" = "Darwin" ]; then
jplatform="${jplatform:=darwin}"
else
jplatform="${jplatform:=linux}"
fi

echo \# jplatform $jplatform

if [ $jplatform = "darwin" ]; then

# macos 64-bit
if [ -f "../bin/${jplatform}/j64$DEBUGDIR/jconsole" ] && [ -f "../bin/${jplatform}/j64arm$DEBUGDIR/jconsole" ]; then
# fat binary
if [ -f "../jlibrary/bin/jconsole" ]; then
mv -f "../jlibrary/bin/jconsole" "/tmp/jconsole.old.$$"
fi
echo \# lipo "../bin/${jplatform}/j64$DEBUGDIR/jconsole" "../bin/${jplatform}/j64arm$DEBUGDIR/jconsole" -create -output "../jlibrary/bin/jconsole-mac"
lipo "../bin/${jplatform}/j64$DEBUGDIR/jconsole" "../bin/${jplatform}/j64arm$DEBUGDIR/jconsole" -create -output "../jlibrary/bin/jconsole-mac"
cp ../jlibrary/bin/jconsole-mac ../jlibrary/bin/jconsole
elif [ -f "../bin/${jplatform}/j64$DEBUGDIR/jconsole" ]; then
cop j64 jconsole bin jconsole-mac
cp ../jlibrary/bin/jconsole-mac ../jlibrary/bin/jconsole
elif [ -f "../bin/${jplatform}/j64arm$DEBUGDIR/jconsole" ]; then
cop j64arm jconsole bin jconsole-mac
cp ../jlibrary/bin/jconsole-mac ../jlibrary/bin/jconsole
fi

if [ -f "../bin/${jplatform}/j64$DEBUGDIR/libtsdll.dylib" ] && [ -f "../bin/${jplatform}/j64arm$DEBUGDIR/libtsdll.dylib" ]; then
# fat binary
if [ -f "../jlibrary/bin/libtsdll.dylib" ]; then
mv -f "../jlibrary/bin/libtsdll.dylib" "/tmp/libtsdll.dylib.old.$$"
fi
echo \# lipo "../bin/${jplatform}/j64$DEBUGDIR/libtsdll.dylib" "../bin/${jplatform}/j64arm$DEBUGDIR/libtsdll.dylib" -create -output "../jlibrary/bin/libtsdll.dylib"
lipo "../bin/${jplatform}/j64$DEBUGDIR/libtsdll.dylib" "../bin/${jplatform}/j64arm$DEBUGDIR/libtsdll.dylib" -create -output "../jlibrary/bin/libtsdll.dylib"
elif [ -f "../bin/${jplatform}/j64$DEBUGDIR/libtsdll.dylib" ]; then
cop j64 libtsdll.dylib bin libtsdll.dylib
elif [ -f "../bin/${jplatform}/j64arm$DEBUGDIR/libtsdll.dylib" ]; then
cop j64arm libtsdll.dylib bin libtsdll.dylib
fi

if [ -f "../bin/${jplatform}/j64$DEBUGDIR/libj.dylib" ] && [ -f "../bin/${jplatform}/j64arm$DEBUGDIR/libj.dylib" ]; then
# fat binary
if [ -f "../jlibrary/bin/libj.dylib" ]; then
mv -f "../jlibrary/bin/libj.dylib" "/tmp/libj.dylib.old.$$"
fi
echo \# lipo "../bin/${jplatform}/j64$DEBUGDIR/libj.dylib" "../bin/${jplatform}/j64arm$DEBUGDIR/libj.dylib" -create -output "../jlibrary/bin/libj.dylib"
lipo "../bin/${jplatform}/j64$DEBUGDIR/libj.dylib" "../bin/${jplatform}/j64arm$DEBUGDIR/libj.dylib" -create -output "../jlibrary/bin/libj.dylib"
elif [ -f "../bin/${jplatform}/j64$DEBUGDIR/libj.dylib" ]; then
cop j64 libj.dylib bin libj.dylib
elif [ -f "../bin/${jplatform}/j64arm$DEBUGDIR/libj.dylib" ]; then
cop j64arm libj.dylib bin libj.dylib
fi

cop j64avx libj.dylib bin libjavx.dylib
cop j64avx2 libj.dylib bin libjavx2.dylib
cop j64avx512 libj.dylib bin libjavx512.dylib

else

# linux/raspberry 64-bit
cop j64 jconsole bin jconsole
cop j64 jconsole bin jconsole-lx
cop j64 libtsdll.so bin libtsdll.so
cop j64 libj.so bin libj.so
cop j64avx libj.so bin libjavx.so
cop j64avx2 libj.so bin libjavx2.so
cop j64avx512 libj.so bin libjavx512.so

# linux/raspberry 32-bit
cop j32 jconsole bin32 jconsole
cop j32 libtsdll.so bin32 libtsdll.so
cop j32 libj.so bin32 libj.so

fi

