/* -*-c++-*- OpenSceneGraph - Copyright (C) 1998-2006 Robert Osfield
 *
 * This library is open source and may be redistributed and/or modified under
 * the terms of the OpenSceneGraph Public License (OSGPL) version 0.0 or
 * (at your option) any later version.  The full license is in LICENSE file
 * included with this distribution, and on the openscenegraph.org website.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * OpenSceneGraph Public License for more details.
*/

#ifndef IGCOREUTILS_EXPORT_H
#define IGCOREUTILS_EXPORT_H

#if defined(OPENIG_SDK)
	#include <OpenIG-Utils/Config.h>
#else
	#include <Core-Utils/Config.h>
#endif

// disable VisualStudio warnings
#if defined(_MSC_VER)
    #pragma warning( disable : 4244 )
    #pragma warning( disable : 4251 )
    #pragma warning( disable : 4275 )
    #pragma warning( disable : 4512 )
    #pragma warning( disable : 4267 )
    #pragma warning( disable : 4702 )
    #pragma warning( disable : 4511 )
#endif

#if defined(_MSC_VER) || defined(__CYGWIN__) || defined(__MINGW32__) || defined( __BCPLUSPLUS__)  || defined( __MWERKS__)
    #  if defined( IGCOREUTILS_LIBRARY_STATIC )
    #    define IGCOREUTILS_EXPORT
    #  elif defined( IGCOREUTILS_LIBRARY )
    #    define IGCOREUTILS_EXPORT   __declspec(dllexport)
    #  else
    #    define IGCOREUTILS_EXPORT   __declspec(dllimport)
    #  endif
#else
    #  define IGCOREUTILS_EXPORT
#endif

// set up define for whether member templates are supported by VisualStudio compilers.
#ifdef _MSC_VER
# if (_MSC_VER >= 1300)
#  define __STL_MEMBER_TEMPLATES
# endif
#endif

/* Define NULL pointer value */

#ifndef NULL
    #ifdef  __cplusplus
        #define NULL    0
    #else
        #define NULL    ((void *)0)
    #endif
#endif

#endif // IGCOREUTILS_EXPORT_H