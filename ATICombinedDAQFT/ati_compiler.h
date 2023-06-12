/*
 *	Compiler-Dependent switches
 *
 *	Base environment for this module is Visual Studio/C++
 *	The following macros adjust for conditional compilation in Cygwin/G++
 */
// (define CYGWIN symbol in command line call to compiler)


#ifdef CYGWIN

#include "basetyps.h"

// suppress tags
#define __gc
#define __nogc
#define __value

// Metadata specifier - suppressed in Cygwin
#define ati_CLS_COMPLIANT_FALSE	

// Disappearing dimension specifier for managed matrices
#define ati_ARRAY_DEC1(n)		(n)
#define ati_ARRAY_DEC2(n,m)		(n)][(m)
#define ati_ARRAY_REF(i,j)		(i)][(j)
#define ati_ARRAY_DEF(name)		* name

// Cygwin namespace hierarchy uses default
#define ati_SYSTEM_NAMESPACE	std

// Cygwin has no Diagnostics class
#define ati_DIAGNOSTICS_DEBUG_WRITELINE(s)

// Cygwin does not use "public" at an attribute
#define ati_PUBLIC

// String class redefined for Cygwin

namespace ati_SYSTEM_NAMESPACE {

class String
{
public:

	int Length;

public:
	String(const char^);

	int get_Length();
	int get_Chars();
	int get_Chars(int&);

	static String* ati_SYSTEM_NAMESPACE::String::Copy(String*&);
};	// class String

}	// namespace ati_SYSTEM_NAMESPACE

#else	// CYGWIN not defined
// Define options for Visual Studio, C++ Managed code

// Alternative namespace
#using <mscorlib.dll>

// Highest-level namespace
#define ati_SYSTEM_NAMESPACE	System

// Disappearing dimension specifier for managed matrices
#define ati_ARRAY_DEC1(n)
#define ati_ARRAY_DEC2(n,m)		,
#define ati_ARRAY_REF(i,j)		(i),(j)
#define ati_ARRAY_DEF(name)		name __gc []

// Metadata specifier
#define ati_CLS_COMPLIANT_FALSE	[CLSCompliant(false)]

// VStudio classes
#define ati_DIAGNOSTICS_DEBUG_WRITELINE(s)	Diagnostics::Debug::WriteLine(s)
#define ati_SYSTEM_STRING_COPY	System::String::Copy

// define "public" symbol for VStudio

#define ati_PUBLIC	public 

#endif
