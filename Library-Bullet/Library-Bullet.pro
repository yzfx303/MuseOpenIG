#-------------------------------------------------
#
# Project created by QtCreator 2015-03-29T20:22:26
#
#-------------------------------------------------

QT       -= core gui

CONFIG += silent warn_off

TARGET = OpenIG-Bullet
TEMPLATE = lib

DEFINES += IGLIBBULLET_LIBRARY

SOURCES +=  BulletManager.cpp \
            Vehicle.cpp \
            ConfigReader.cpp

HEADERS +=  Export.h \
            BulletManager.h \
            Vehicle.h \
            ConfigReader.h

LIBS += -losg -losgDB -losgViewer -lOpenThreads -losgShadow -losgAnimation -lOpenIG-Base

INCLUDEPATH += ../
DEPENDPATH += ../

OTHER_FILES += CMakeLists.txt
DISTFILES += CMakeLists.txt

unix {
    !mac:contains(QMAKE_HOST.arch, x86_64):{
        DESTDIR = /usr/local/lib64
        LIBS+=-L/usr/local/lib64
        target.path = /usr/local/lib64
    } else {
        DESTDIR = /usr/local/lib
        LIBS+=-L/usr/local/lib
        target.path = /usr/local/lib
    }
    message($$TARGET Lib will be installed into $$DESTDIR)

    INSTALLS += target

    INCLUDEPATH += /usr/local/include
    DEPENDPATH += /usr/local/include

    INCLUDEPATH += /usr/local/include/bullet
    DEPENDPATH += /usr/local/include/bullet

    INCLUDEPATH += /usr/local/lib64
    DEPENDPATH += /usr/local/lib64

    LIBS += -lLinearMath -lBulletCollision -lBulletDynamics -losgbCollision -losgbDynamics
    #
    # Allow alternate boost library path to be set via ENV variable
    #
    BOOSTROOT = $$(BOOST_ROOT)
    isEmpty(BOOSTROOT) {
        message($$TARGET --  -- \"BOOST_ROOT env var\" not set...using system default paths to look for boost )
        LIBS +=  -lboost_system -lboost_filesystem
    }
    else {
        message($$TARGET --  -- \"BOOST_ROOT env var\" detected - set to: \"$$BOOSTROOT\")
        LIBS += -L$$BOOSTROOT/stage/lib \
                -lboost_system -lboost_filesystem
        INCLUDEPATH += $$BOOSTROOT
        DEPENDPATH  += $$BOOSTROOT
    }

    HFILES   = $$files($${PWD}/*.h)
    HDESTDIR = /usr/local/include/$$TARGET

#   Get the filename(only) list for distclean to remove only the files added from this plugin
    for(var,HFILES) {
        distfiles += $$HDESTDIR/$$basename(var)
    }
    QMAKE_DISTCLEAN += $$distfiles

    QMAKE_POST_LINK  = test -d $$quote($$HDESTDIR) || $$QMAKE_MKDIR $$quote($$HDESTDIR) $$escape_expand(\\n\\t)
    QMAKE_POST_LINK += $$QMAKE_COPY $$quote($$HFILES) $$quote($$HDESTDIR) $$escape_expand(\\n\\t)

    # library version number files
    exists( "../openig_version.pri" ) {

    include( "../openig_version.pri" )
        isEmpty( VERSION ){ error( "$$TARGET -- bad or undefined VERSION variable inside file openig_version.pri" )
    } else {
        message( "$$TARGET -- Set version info to: $$VERSION" )
    }

    }
    else { error( "$$TARGET -- could not find pri library version file openig_version.pri" ) }

    # end of library version number files
}


win32-g++:QMAKE_CXXFLAGS += -fpermissive -shared-libgcc -D_GLIBCXX_DLL

win32 {

    OSGROOT = $$(OSG_ROOT)
    isEmpty(OSGROOT) {
        message($$TARGET -- \"OpenSceneGraph\" not detected...)
    }
    else {
        message($$TARGET -- \"OpenSceneGraph\" detected in \"$$OSGROOT\")
        INCLUDEPATH += $$OSGROOT/include
        LIBS += -L$$OSGROOT/lib
    }
    OSGBUILD = $$(OSG_BUILD)
    isEmpty(OSGBUILD) {
        message($$TARGET -- \"OpenSceneGraph build\" not detected...)
    }
    else {
        message($$TARGET -- \"OpenSceneGraph build\" detected in \"$$OSGBUILD\")
        DEPENDPATH += $$OSGBUILD/lib
        INCLUDEPATH += $$OSGBUILD/include
        LIBS += -L$$OSGBUILD/lib
    }

    exists( C:/Program Files/osgBullet ) {
        OSGBULLETSROOT="C:\Program Files\osgBullet"
    }
    isEmpty(OSGBULLETSROOT) {
        message($$TARGET -- \"osgBullets\" not detected...)
    }
    else {
        message(\"osgBullets\" detected in \"$$OSGBULLETSROOT\")
        DEPENDPATH += $$OSGBULLETSROOT
        INCLUDEPATH += $$OSGBULLETSROOT\include
        LIBS += -L$$OSGBULLETSROOT
        LIBS += -L$$OSGBULLETSROOT\lib
        LIBS += -losgbCollision -losgbDynamics
    }

    BULLETSBUILD = $$(BULLETS_BUILD)
    isEmpty(BULLETSBUILD) {
        message($$TARGET -- \"Bullets build\" not detected...)
    }
    else {
        message($$TARGET -- \"Bullets build\" detected in \"$$BULLETSBUILD\")
        DEPENDPATBulletLibH += $$BULLETSBUILD
        INCLUDEPATH += $$BULLETSBUILD\src
        LIBS += -L$$BULLETSBUILD\BUILD\lib\release
        LIBS += -lLinearMath -lBulletCollision -lBulletDynamics
    }

    BOOSTROOT = $$(BOOST_ROOT)
    isEmpty(BOOSTROOT) {
        message($$TARGET -- \"boost\" not detected...)
    }
    else {
        INCLUDEPATH += $$BOOSTROOT
        win32-g++ {
            message($$TARGET -- win32-g++ --\"boost\" detected in \"$$BOOSTROOT\")
            LIBS += -L$$BOOSTROOT\stage\lib -llibboost_filesystem
        } else {
            message($$TARGET -- win32 -- \"boost\" detected in \"$$BOOSTROOT\")
            LIBS += -L$$BOOSTROOT\stage\lib
            CONFIG( debug,debug|release ){
                message($$TARGET -- Boost using debug version of libraries )
                LIBS += -llibboost_filesystem-vc120-mt-gd-1_58
            }else{
                message($$TARGET -- Boost using release version of libraries )
                LIBS += -llibboost_filesystem-vc120-mt-1_58
            }
        }
    }

    OPENIGBUILD = $$(OPENIG_BUILD)
    isEmpty (OPENIGBUILD) {
        OPENIGBUILD = $$IN_PWD/..
    }
    DESTDIR = $$OPENIGBUILD/lib
    DLLDESTDIR = $$OPENIGBUILD/bin

    LIBS += -L$$OPENIGBUILD/lib

    HFILES   = $$files($${PWD}/*.h)
    HDESTDIR = $$OPENIGBUILD/include/$$TARGET
    HFILES  ~= s,/,\\,g
    HDESTDIR  ~= s,/,\\,g

#   Get the filename(only) list for distclean to remove only the files added from this plugin
    for(var,HFILES) {
        distfiles += $$HDESTDIR\\$$basename(var)
    }
    QMAKE_DISTCLEAN += $$distfiles

    PDIR =  $$PWD
    PDIR  ~= s,/,\\,g

    QMAKE_POST_LINK  = test -d $$quote($$HDESTDIR) || $$QMAKE_MKDIR $$quote($$HDESTDIR) $$escape_expand(\\n\\t)
    QMAKE_POST_LINK += $$QMAKE_COPY $$PDIR\*.h $$quote($$HDESTDIR) $$escape_expand(\\n\\t)
}

