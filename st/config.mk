# st version
VERSION = 0.7

# Customize below to fit your system

# paths
PREFIX = /opt/local
MANPREFIX = ${PREFIX}/share/man

X11INC = /opt/X11/include
X11LIB = /opt/X11/lib

# includes and libs
INCS = -I. -I/opt/local/include -I${X11INC} \
       `pkg-config --cflags fontconfig` \
       `pkg-config --cflags freetype2`
LIBS = -L/opt/local/lib -lc -L${X11LIB} -lm -lX11 -lutil -lXft \
       `pkg-config --libs fontconfig`  \
       `pkg-config --libs freetype2`

# flags
CPPFLAGS = -DVERSION=\"${VERSION}\" -D_XOPEN_SOURCE=600
CFLAGS += -g -std=c99 -pedantic -Wall -Wvariadic-macros -Os ${INCS} ${CPPFLAGS}
LDFLAGS += -g ${LIBS}

# compiler and linker
# CC = cc

