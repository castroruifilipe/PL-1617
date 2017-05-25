/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.3"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     MAIN = 258,
     IF = 259,
     ELSE = 260,
     WHILE = 261,
     READ = 262,
     PRINT = 263,
     RETURN = 264,
     FUNCAO = 265,
     INT = 266,
     VALOR = 267,
     DESIGNACAO = 268,
     STRING = 269
   };
#endif
/* Tokens.  */
#define MAIN 258
#define IF 259
#define ELSE 260
#define WHILE 261
#define READ 262
#define PRINT 263
#define RETURN 264
#define FUNCAO 265
#define INT 266
#define VALOR 267
#define DESIGNACAO 268
#define STRING 269




/* Copy the first part of user declarations.  */
#line 1 "compilador.y"

	#include <stdio.h>
	#include <unistd.h>
	#include <string.h>
	#include <glib.h>
	#include <stdlib.h>

	typedef struct infovar {
		char *instrucoes;
		char *atribuicoes;
		char *prep_atribuicoes;
	} InfoVar;

	typedef struct endereco {
		int indice;
		int colunas;
	} *Endereco;

	GTree *designacoes;
	char *erro;
	Endereco aux = NULL;
	Endereco e;
	int count = 1;
	int local = 0;

	int countCond = 0;



/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 30 "compilador.y"
{
	char *valString;
	int valInt;
	InfoVar infoV;
}
/* Line 193 of yacc.c.  */
#line 159 "y.tab.c"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 172 "y.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int i)
#else
static int
YYID (i)
    int i;
#endif
{
  return i;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   166

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  34
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  18
/* YYNRULES -- Number of rules.  */
#define YYNRULES  50
/* YYNRULES -- Number of states.  */
#define YYNSTATES  121

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   269

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    26,     2,     2,     2,    32,    33,     2,
      15,    16,    30,    27,    20,    28,     2,    31,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,    19,
      25,    23,    24,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    21,     2,    22,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    17,    29,    18,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,     6,     9,    10,    20,    24,    30,    33,
      34,    38,    40,    44,    47,    52,    60,    63,    64,    67,
      68,    73,    81,    93,   101,   105,   109,   113,   118,   123,
     128,   133,   138,   142,   146,   148,   150,   154,   158,   162,
     164,   168,   172,   176,   180,   182,   184,   188,   192,   194,
     199
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      35,     0,    -1,    36,    39,    -1,    36,    37,    -1,    -1,
      10,    13,    15,    16,    17,    40,    45,    38,    18,    -1,
       9,    48,    19,    -1,     3,    17,    40,    45,    18,    -1,
      40,    41,    -1,    -1,    11,    42,    19,    -1,    43,    -1,
      43,    20,    42,    -1,    13,    44,    -1,    13,    21,    12,
      22,    -1,    13,    21,    12,    22,    21,    12,    22,    -1,
      23,    48,    -1,    -1,    45,    46,    -1,    -1,    51,    23,
      48,    19,    -1,     4,    15,    47,    16,    17,    45,    18,
      -1,     4,    15,    47,    16,    17,    45,    18,     5,    17,
      45,    18,    -1,     6,    15,    47,    16,    17,    45,    18,
      -1,     8,    48,    19,    -1,     8,    14,    19,    -1,     7,
      51,    19,    -1,    13,    15,    16,    19,    -1,    48,    24,
      23,    48,    -1,    48,    25,    23,    48,    -1,    48,    23,
      23,    48,    -1,    48,    26,    23,    48,    -1,    48,    25,
      48,    -1,    48,    24,    48,    -1,    48,    -1,    49,    -1,
      48,    27,    49,    -1,    48,    28,    49,    -1,    48,    29,
      49,    -1,    50,    -1,    49,    30,    50,    -1,    49,    31,
      50,    -1,    49,    32,    50,    -1,    49,    33,    50,    -1,
      12,    -1,    51,    -1,    15,    47,    16,    -1,    13,    15,
      16,    -1,    13,    -1,    13,    21,    48,    22,    -1,    13,
      21,    48,    22,    21,    48,    22,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint8 yyrline[] =
{
       0,    43,    43,    48,    49,    52,    56,    60,    68,    69,
      72,    75,    76,    79,    91,   108,   127,   128,   132,   133,
     136,   137,   143,   152,   160,   163,   166,   171,   174,   175,
     176,   177,   178,   179,   180,   183,   184,   185,   186,   189,
     190,   191,   192,   193,   196,   197,   198,   199,   202,   215,
     235
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "MAIN", "IF", "ELSE", "WHILE", "READ",
  "PRINT", "RETURN", "FUNCAO", "INT", "VALOR", "DESIGNACAO", "STRING",
  "'('", "')'", "'{'", "'}'", "';'", "','", "'['", "']'", "'='", "'>'",
  "'<'", "'!'", "'+'", "'-'", "'|'", "'*'", "'/'", "'%'", "'&'", "$accept",
  "Programa", "Funcoes", "Funcao", "Return", "MainFunc", "Decls", "Decl",
  "DeclsVar", "DeclVar", "Init", "Instrucoes", "Instrucao", "Cond", "Expr",
  "Termo", "Fator", "Var", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,    40,    41,   123,   125,    59,
      44,    91,    93,    61,    62,    60,    33,    43,    45,   124,
      42,    47,    37,    38
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    34,    35,    36,    36,    37,    38,    39,    40,    40,
      41,    42,    42,    43,    43,    43,    44,    44,    45,    45,
      46,    46,    46,    46,    46,    46,    46,    46,    47,    47,
      47,    47,    47,    47,    47,    48,    48,    48,    48,    49,
      49,    49,    49,    49,    50,    50,    50,    50,    51,    51,
      51
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     2,     2,     0,     9,     3,     5,     2,     0,
       3,     1,     3,     2,     4,     7,     2,     0,     2,     0,
       4,     7,    11,     7,     3,     3,     3,     4,     4,     4,
       4,     4,     3,     3,     1,     1,     3,     3,     3,     1,
       3,     3,     3,     3,     1,     1,     3,     3,     1,     4,
       7
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       4,     0,     0,     1,     0,     0,     3,     2,     9,     0,
      19,     0,     0,     8,     0,     0,    17,     0,    11,     0,
       0,     0,     0,    48,     7,    18,     0,     9,     0,     0,
      13,    10,     0,     0,     0,    48,     0,    44,    48,     0,
       0,     0,    35,    39,    45,     0,     0,     0,    19,     0,
      16,    12,     0,    34,     0,    26,     0,    25,     0,    24,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,    14,     0,     0,     0,     0,     0,     0,    47,    46,
      36,    37,    38,    40,    41,    42,    43,    27,    49,    20,
       0,     0,     0,    19,     0,     0,    33,     0,    32,     0,
      19,     0,     0,     5,     0,     0,    30,    28,    29,    31,
       0,     0,     6,    15,    21,    23,    50,     0,    19,     0,
      22
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     1,     2,     6,    91,     7,    10,    13,    17,    18,
      30,    14,    25,    52,    53,    42,    43,    44
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -44
static const yytype_int16 yypact[] =
{
     -44,     2,    30,   -44,     3,     6,   -44,   -44,   -44,    27,
      40,    43,    57,   -44,     5,    62,    45,    52,    75,    66,
      67,    94,   101,    13,   -44,   -44,    98,   -44,   120,    96,
     -44,   -44,    57,    96,    96,   112,   115,   -44,    89,   116,
      96,    36,    87,   -44,   -44,   121,    96,    96,    40,   114,
      99,   -44,   122,    74,   123,   -44,   124,   -44,   125,   -44,
      96,    96,    96,    96,    96,    96,    96,   126,   -12,    58,
      39,   127,   129,   119,    -9,     9,   128,   130,   -44,   -44,
      87,    87,    87,   -44,   -44,   -44,   -44,   -44,   131,   -44,
      96,   132,   137,   -44,    96,    96,    99,    96,    99,    96,
     -44,    96,    65,   -44,   133,    23,    99,    99,    99,    99,
      31,    61,   -44,   -44,   138,   -44,   -44,   136,   -44,    54,
     -44
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -44,   -44,   -44,   -44,   -44,   -44,   117,   -44,   134,   -44,
     -44,   -43,   -44,    72,   -21,    69,    59,   -14
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const yytype_uint8 yytable[] =
{
      26,    41,     3,    37,    38,    70,    40,    36,    50,    19,
      88,    20,    21,    22,    95,    60,    61,    62,    23,     9,
       8,    37,    38,    24,    40,    68,    69,    19,    45,    20,
      21,    22,    97,     4,    46,    19,    23,    20,    21,    22,
       5,   114,    11,    19,    23,    20,    21,    22,    90,   115,
     105,    12,    23,    96,    98,    59,    26,   110,    19,    15,
      20,    21,    22,    60,    61,    62,    28,    23,    29,   102,
      16,    31,   120,   106,   107,   119,   108,    89,   109,    27,
     111,    33,    34,   116,   112,    60,    61,    62,    60,    61,
      62,    26,    60,    61,    62,    32,    26,    73,    74,    75,
      76,    60,    61,    62,    56,    26,    54,    35,    37,    38,
      46,    40,    58,    37,    38,    39,    40,    63,    64,    65,
      66,    47,    83,    84,    85,    86,    60,    61,    62,    80,
      81,    82,    49,    46,    55,    57,    71,    67,    72,    77,
      78,    79,    94,   117,    48,    87,    93,   100,    92,   104,
     103,    99,   101,   118,     0,   113,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    51
};

static const yytype_int8 yycheck[] =
{
      14,    22,     0,    12,    13,    48,    15,    21,    29,     4,
      22,     6,     7,     8,    23,    27,    28,    29,    13,    13,
      17,    12,    13,    18,    15,    46,    47,     4,    15,     6,
       7,     8,    23,     3,    21,     4,    13,     6,     7,     8,
      10,    18,    15,     4,    13,     6,     7,     8,     9,    18,
      93,    11,    13,    74,    75,    19,    70,   100,     4,    16,
       6,     7,     8,    27,    28,    29,    21,    13,    23,    90,
      13,    19,    18,    94,    95,   118,    97,    19,    99,    17,
     101,    15,    15,    22,    19,    27,    28,    29,    27,    28,
      29,   105,    27,    28,    29,    20,   110,    23,    24,    25,
      26,    27,    28,    29,    15,   119,    34,    13,    12,    13,
      21,    15,    40,    12,    13,    14,    15,    30,    31,    32,
      33,    23,    63,    64,    65,    66,    27,    28,    29,    60,
      61,    62,    12,    21,    19,    19,    22,    16,    16,    16,
      16,    16,    23,     5,    27,    19,    17,    17,    21,    12,
      18,    23,    21,    17,    -1,    22,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    32
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    35,    36,     0,     3,    10,    37,    39,    17,    13,
      40,    15,    11,    41,    45,    16,    13,    42,    43,     4,
       6,     7,     8,    13,    18,    46,    51,    17,    21,    23,
      44,    19,    20,    15,    15,    13,    51,    12,    13,    14,
      15,    48,    49,    50,    51,    15,    21,    23,    40,    12,
      48,    42,    47,    48,    47,    19,    15,    19,    47,    19,
      27,    28,    29,    30,    31,    32,    33,    16,    48,    48,
      45,    22,    16,    23,    24,    25,    26,    16,    16,    16,
      49,    49,    49,    50,    50,    50,    50,    19,    22,    19,
       9,    38,    21,    17,    23,    23,    48,    23,    48,    23,
      17,    21,    48,    18,    12,    45,    48,    48,    48,    48,
      45,    48,    19,    22,    18,    18,    22,     5,    17,    45,
      18
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
#else
static void
yy_stack_print (bottom, top)
    yytype_int16 *bottom;
    yytype_int16 *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      fprintf (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      fprintf (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  int yystate;
  int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Look-ahead token as an internal (translated) token number.  */
  int yytoken = 0;
#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  yytype_int16 yyssa[YYINITDEPTH];
  yytype_int16 *yyss = yyssa;
  yytype_int16 *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  YYSTYPE *yyvsp;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     look-ahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to look-ahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 43 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%s", (yyvsp[(2) - (2)].valString), (yyvsp[(1) - (2)].valString));
											printf("%s", (yyval.valString));			 	}
    break;

  case 4:
#line 49 "compilador.y"
    {	(yyval.valString) = "";	}
    break;

  case 7:
#line 60 "compilador.y"
    {	asprintf(&(yyval.valString), "pushi 0\n"
																  "%s"
																  "start\n"
																  "%s"
																  "stop\n", (yyvsp[(3) - (5)].valString), (yyvsp[(4) - (5)].valString));	}
    break;

  case 8:
#line 68 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%s", (yyvsp[(1) - (2)].valString), (yyvsp[(2) - (2)].valString));	}
    break;

  case 9:
#line 69 "compilador.y"
    {	(yyval.valString) = "";	}
    break;

  case 10:
#line 72 "compilador.y"
    {	(yyval.valString) = (yyvsp[(2) - (3)].valString);	}
    break;

  case 11:
#line 75 "compilador.y"
    {	(yyval.valString) = (yyvsp[(1) - (1)].valString);	}
    break;

  case 12:
#line 76 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%s", (yyvsp[(1) - (3)].valString), (yyvsp[(3) - (3)].valString));	}
    break;

  case 13:
#line 79 "compilador.y"
    {	if (g_tree_lookup(designacoes, (yyvsp[(1) - (2)].valString)) != NULL) {
																asprintf(&erro, "Variável %s já declarada", (yyvsp[(1) - (2)].valString));
																yyerror(erro);
															} else {
																e = (Endereco)malloc(sizeof(struct endereco));
																e -> indice = count;
																e -> colunas = 0;
																g_tree_insert(designacoes, (yyvsp[(1) - (2)].valString), e);
																count++;
																asprintf(&(yyval.valString), "%s", (yyvsp[(2) - (2)].valString));
															}
														}
    break;

  case 14:
#line 91 "compilador.y"
    {	if (g_tree_lookup(designacoes, (yyvsp[(1) - (4)].valString)) != NULL) {
																asprintf(&erro, "Variável %s já declarada", (yyvsp[(1) - (4)].valString));
																yyerror(erro);
															} else {
																if (atoi((yyvsp[(3) - (4)].valString)) < 1) {
																	asprintf(&erro, "Dimensão %s do array %s inválida", (yyvsp[(3) - (4)].valString), (yyvsp[(1) - (4)].valString));
																	yyerror(erro);
																} else {
																	e = (Endereco)malloc(sizeof(struct endereco));
																	e -> indice = count;
																	e -> colunas = 0;
																	g_tree_insert(designacoes, (yyvsp[(1) - (4)].valString), e);
																	count += atoi((yyvsp[(3) - (4)].valString));
																	asprintf(&(yyval.valString), "pushn %s\n", (yyvsp[(3) - (4)].valString));
																}
															}
														}
    break;

  case 15:
#line 108 "compilador.y"
    {	if (g_tree_lookup(designacoes, (yyvsp[(1) - (7)].valString)) != NULL) {
																asprintf(&erro, "Variável %s já declarada", (yyvsp[(1) - (7)].valString));
																yyerror(erro);
															} else {
																if (atoi((yyvsp[(3) - (7)].valString)) < 1 || atoi((yyvsp[(6) - (7)].valString)) < 1) {
																	asprintf(&erro, "Dimensões do array bidimensional %s inválidas", (yyvsp[(1) - (7)].valString));
																	yyerror(erro);
																} else {
																	e = (Endereco)malloc(sizeof(struct endereco));
																	e -> indice = count;
																	e -> colunas =  atoi((yyvsp[(6) - (7)].valString));
																	g_tree_insert(designacoes, (yyvsp[(1) - (7)].valString), e);
																	count += (atoi((yyvsp[(3) - (7)].valString)) * atoi((yyvsp[(6) - (7)].valString)));
																	asprintf(&(yyval.valString), "pushn %d\n", atoi((yyvsp[(3) - (7)].valString)) * atoi((yyvsp[(6) - (7)].valString)));
																}
															}
														}
    break;

  case 16:
#line 127 "compilador.y"
    {	(yyval.valString) = (yyvsp[(2) - (2)].valString);	}
    break;

  case 17:
#line 128 "compilador.y"
    {	(yyval.valString) = "pushi 0\n";	}
    break;

  case 18:
#line 132 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%s", (yyvsp[(1) - (2)].valString), (yyvsp[(2) - (2)].valString));	}
    break;

  case 19:
#line 133 "compilador.y"
    {	(yyval.valString) = "";	}
    break;

  case 20:
#line 136 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%s%s", (yyvsp[(1) - (4)].infoV).prep_atribuicoes, (yyvsp[(3) - (4)].valString), (yyvsp[(1) - (4)].infoV).atribuicoes);	}
    break;

  case 21:
#line 137 "compilador.y"
    {	asprintf(&(yyval.valString), "%s"
		  																					  "jz fim_if_%d\n"
																							  "%s"
																							  "fim_if_%d: \n", (yyvsp[(3) - (7)].valString), countCond, (yyvsp[(6) - (7)].valString), countCond);
																				countCond++;
																			}
    break;

  case 22:
#line 143 "compilador.y"
    {	asprintf(&(yyval.valString), "%s"
		  																					  "jz else_%d\n"
																							  "%s"
																							  "jz fim_if_%d: \n"
																							  "else_%d:\n"
																							  "%s"
																							  "fim_if_%d: \n", (yyvsp[(3) - (11)].valString), countCond, (yyvsp[(6) - (11)].valString), countCond, countCond, (yyvsp[(10) - (11)].valString), countCond);
																				countCond++;
																			}
    break;

  case 23:
#line 152 "compilador.y"
    {	asprintf(&(yyval.valString), "while_%d: \n"
		  																					  "%s"
																							  "jz fim_while_%d\n"
		  																					  "%s"
																							  "jump while_%d\n"
																							  "fim_while_%d: \n", countCond, (yyvsp[(3) - (7)].valString), countCond, (yyvsp[(6) - (7)].valString), countCond, countCond);
																				countCond++;
																			}
    break;

  case 24:
#line 160 "compilador.y"
    {	asprintf(&(yyval.valString), "%s"
		  																					  "writei\n", (yyvsp[(2) - (3)].valString));
																			}
    break;

  case 25:
#line 163 "compilador.y"
    {	asprintf(&(yyval.valString), "pushs %s\n"
		  																					  "writes\n", (yyvsp[(2) - (3)].valString));
																			}
    break;

  case 26:
#line 166 "compilador.y"
    {	asprintf(&(yyval.valString), "%s"
		  																					  "read\n"
																							  "atoi\n"
																							  "%s", (yyvsp[(2) - (3)].infoV).prep_atribuicoes, (yyvsp[(2) - (3)].infoV).atribuicoes);
																			}
    break;

  case 28:
#line 174 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%ssupeq\n", (yyvsp[(1) - (4)].valString), (yyvsp[(4) - (4)].valString));	}
    break;

  case 29:
#line 175 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%sinfeq\n", (yyvsp[(1) - (4)].valString), (yyvsp[(4) - (4)].valString));	}
    break;

  case 30:
#line 176 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%sequal\n", (yyvsp[(1) - (4)].valString), (yyvsp[(4) - (4)].valString));	}
    break;

  case 31:
#line 177 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%sequal\nnot\n", (yyvsp[(1) - (4)].valString), (yyvsp[(4) - (4)].valString));	}
    break;

  case 32:
#line 178 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%sinf\n", (yyvsp[(1) - (3)].valString), (yyvsp[(3) - (3)].valString));	}
    break;

  case 33:
#line 179 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%ssup\n", (yyvsp[(1) - (3)].valString), (yyvsp[(3) - (3)].valString));	}
    break;

  case 35:
#line 183 "compilador.y"
    {	(yyval.valString) = (yyvsp[(1) - (1)].valString);	}
    break;

  case 36:
#line 184 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%sadd\n", (yyvsp[(1) - (3)].valString), (yyvsp[(3) - (3)].valString));	}
    break;

  case 37:
#line 185 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%ssub\n", (yyvsp[(1) - (3)].valString), (yyvsp[(3) - (3)].valString));	}
    break;

  case 38:
#line 186 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%sadd\n", (yyvsp[(1) - (3)].valString), (yyvsp[(3) - (3)].valString));	}
    break;

  case 39:
#line 189 "compilador.y"
    {	(yyval.valString) = (yyvsp[(1) - (1)].valString);	}
    break;

  case 40:
#line 190 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%smul\n", (yyvsp[(1) - (3)].valString), (yyvsp[(3) - (3)].valString));	}
    break;

  case 41:
#line 191 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%sdiv\n", (yyvsp[(1) - (3)].valString), (yyvsp[(3) - (3)].valString));	}
    break;

  case 42:
#line 192 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%smod\n", (yyvsp[(1) - (3)].valString), (yyvsp[(3) - (3)].valString));	}
    break;

  case 43:
#line 193 "compilador.y"
    {	asprintf(&(yyval.valString), "%s%smul\n", (yyvsp[(1) - (3)].valString), (yyvsp[(3) - (3)].valString));	}
    break;

  case 44:
#line 196 "compilador.y"
    {	asprintf(&(yyval.valString), "pushi %s\n", (yyvsp[(1) - (1)].valString));	}
    break;

  case 45:
#line 197 "compilador.y"
    {	(yyval.valString) = (yyvsp[(1) - (1)].infoV).instrucoes;	}
    break;

  case 46:
#line 198 "compilador.y"
    {	(yyval.valString) = (yyvsp[(2) - (3)].valString);	}
    break;

  case 48:
#line 202 "compilador.y"
    {	if ((aux = (Endereco)g_tree_lookup(designacoes, (yyvsp[(1) - (1)].valString))) != NULL) {
														if (local == 0) {
															asprintf(&(yyval.infoV).instrucoes, "pushg %d\n", aux->indice);
															asprintf(&(yyval.infoV).atribuicoes, "storeg %d\n", aux->indice);
															(yyval.infoV).prep_atribuicoes = "";
														} else {
															// ????????????????????????????????????????????????????
														}
													} else {
														asprintf(&erro, "Variável %s não declarada", (yyvsp[(1) - (1)].valString));
														yyerror(erro);
													}
												}
    break;

  case 49:
#line 215 "compilador.y"
    {	if ((aux = (Endereco)g_tree_lookup(designacoes, (yyvsp[(1) - (4)].valString))) != NULL) {
														if (local == 0) {
															asprintf(&(yyval.infoV).instrucoes, "pushgp\n"
																					 "pushi %d\n"
																					 "padd\n"
																					 "%s"
																					 "loadn\n", aux->indice, (yyvsp[(3) - (4)].valString));
															asprintf(&(yyval.infoV).atribuicoes, "storen\n");
															asprintf(&(yyval.infoV).prep_atribuicoes, "pushgp\n"
																					       "pushi %d\n"
																					       "padd\n"
																					       "%s", aux->indice, (yyvsp[(3) - (4)].valString));
														} else {
															// ????????????????????????????????????????????????????
														}
													} else {
														asprintf(&erro, "Array %s não declarado", (yyvsp[(1) - (4)].valString));
														yyerror(erro);
													}
												}
    break;

  case 50:
#line 235 "compilador.y"
    {	if ((aux = (Endereco)g_tree_lookup(designacoes, (yyvsp[(1) - (7)].valString))) != NULL) {
														if (local == 0) {
															asprintf(&(yyval.infoV).instrucoes, "pushgp\n"
																					 "pushi %d\n"
																					 "padd\n"
																					 "%s"
																					 "pushi %d\n"
																					 "mul\n"
																					 "%s"
																					 "add\n"
																					 "loadn\n", aux->indice, (yyvsp[(3) - (7)].valString), aux->colunas, (yyvsp[(6) - (7)].valString));
															asprintf(&(yyval.infoV).atribuicoes, "storen\n");
															asprintf(&(yyval.infoV).prep_atribuicoes, "pushgp\n"
																					       "pushi %d\n"
																					       "padd\n"
																					       "%s"
																					       "pushi %d\n"
																					       "mul\n"
																					       "%s"
																					       "add\n", aux->indice, (yyvsp[(3) - (7)].valString), aux->colunas, (yyvsp[(6) - (7)].valString));
														} else {
															// ????????????????????????????????????????????????????
														}
													} else {
														asprintf(&erro, "Array bidimensional %s não declarado", (yyvsp[(1) - (7)].valString));
														yyerror(erro);
													}
												}
    break;


/* Line 1267 of yacc.c.  */
#line 1819 "y.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse look-ahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEOF && yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


#line 264 "compilador.y"


#include "lex.yy.c"

int yyerror (char *s) {
	fprintf(stderr,"ERRO SINTÁTICO %s (Linha %d: | yychar: %d)\n", s, yylineno, yychar);
	return 1;
}

int main() {
	designacoes = g_tree_new((GCompareFunc)strcmp);
	yyparse();
	return 0;
}
