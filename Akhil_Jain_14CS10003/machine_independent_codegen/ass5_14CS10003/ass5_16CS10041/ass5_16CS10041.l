%{
#include "ass5_16CS10041_translator.h"
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
//extern void yyerror(const char *);
//static void comment(void);
%}

/**
 * Regular Expression Definitions
 * COMMENTS
 */
SINGLE_COMMENT 				[/][/].*
MULTI_END 				[\*]+[/]
MULTI_START 				[/][\*]+
MULTI_COMMENT 				({MULTI_START}(([^\*])|((\*)+[^/\*]))*{MULTI_END})
COMMENT 				{SINGLE_COMMENT}|{MULTI_COMMENT}

/**
 * keywords
 */
KEYWORD					"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"inline"|"int"|"long"|"register"|"restrict"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"|"_Bool"|"_Complex"|"_Imaginary"

/**
 * Identifiers
 */
DIGIT 					[0-9]
IDENT_ND 				[A-Za-z]|"_"
IDENT 					({IDENT_ND}({IDENT_ND}|{DIGIT})*)

/**
 * Constants
 */
NONZERODIG 				[1-9]
INT_CONST 				(({NONZERODIG}({DIGIT}*))|{ZERO}+)
CONST 					({INT_CONST}|{FLOAT_CONST}|{ENUM_CONST}|{C_CHAR_CONST})

DIGIT_SEQ 				{DIGIT}+
SIGN 					[+-]
EXPONENT_PART 				([eE]{SIGN}?{DIGIT_SEQ})
FRACT_CONST 				(({DIGIT_SEQ}?{DOT}{DIGIT_SEQ})|({DIGIT_SEQ}{DOT}))
FLOAT_CONST 				(({FRACT_CONST}{EXPONENT_PART}?)|({DIGIT_SEQ}{EXPONENT_PART}))

ENUM_CONST 				{IDENT}

ESC_SEQ 				([\\][\'\"\?\\abfnrtv])
C_CHAR 					[^\'\\\n]|{ESC_SEQ}
C_CHAR_SEQ 				{C_CHAR}+
C_CHAR_CONST 				(\'{C_CHAR_SEQ}\')

/**
 * String Literals
 */ 
S_CHAR 					[^\"\\\n]|{ESC_SEQ}
S_CHAR_SEQ 				{S_CHAR}+
STRING_LITERAL 				(\"{S_CHAR_SEQ}*\")


WHITESPACE [ \n\t]
ZERO "0"
DOT "."
NON_STAR (([^\*]).*)
NON_FS ([^/].*)
AVOID_MULTI_END (NON_STAR|([\*]{NON_FS}))

%%
{KEYWORD}		{
if(strcmp(yytext,"auto")==0)			{ return AUTO; }
if(strcmp(yytext,"enum")==0)			{ return ENUM; }
if(strcmp(yytext,"restrict")==0)		{ return RESTRICT; } 
if(strcmp(yytext,"unsigned")==0)		{ return UNSIGNED; }
if(strcmp(yytext,"break")==0)			{ return BREAK; }
if(strcmp(yytext,"extern")==0)			{ return EXTERN; }
if(strcmp(yytext,"return")==0)			{ return RETURN; }
if(strcmp(yytext,"void")==0)			{ return VOID; }
if(strcmp(yytext,"case")==0)			{ return CASE; }
if(strcmp(yytext,"float")==0)			{ return FLOAT; }
if(strcmp(yytext,"short")==0)			{ return SHORT; }
if(strcmp(yytext,"volatile")==0)		{ return VOLATILE; }
if(strcmp(yytext,"char")==0)		  	{ return CHAR; }
if(strcmp(yytext,"for")==0)			{ return FOR; }
if(strcmp(yytext,"signed")==0)		  	{ return SIGNED; }
if(strcmp(yytext,"while")==0)			{ return WHILE; }
if(strcmp(yytext,"const")==0)			{ return CONST; }
if(strcmp(yytext,"goto")==0)			{ return GOTO; }
if(strcmp(yytext,"sizeof")==0)			{ return SIZEOF; }
if(strcmp(yytext,"_Bool")==0)			{ return BOOL; }
if(strcmp(yytext,"continue")==0)		{ return CONTINUE; }
if(strcmp(yytext,"if")==0)			{ return IF; }
if(strcmp(yytext,"static")==0)			{ return STATIC; }
if(strcmp(yytext,"_Complex")==0)		{ return COMPLEX; }
if(strcmp(yytext,"default")==0)			{ return DEFAULT; }
if(strcmp(yytext,"inline")==0)			{ return INLINE; }
if(strcmp(yytext,"struct")==0)			{ return STRUCT; }
if(strcmp(yytext,"_Imaginary")==0)		{ return IMAGINARY; }
if(strcmp(yytext,"do")==0)			{ return DO; }
if(strcmp(yytext,"int")==0)			{ return INT; }
if(strcmp(yytext,"switch")==0)			{ return SWITCH; }
if(strcmp(yytext,"double")==0)			{ return DOUBLE; }
if(strcmp(yytext,"long")==0)			{ return LONG; }
if(strcmp(yytext,"typedef")==0)			{ return TYPEDEF; }
if(strcmp(yytext,"else")==0)			{ return ELSE; }
if(strcmp(yytext,"register")==0)		{ return REGISTER; }
if(strcmp(yytext,"union")==0)			{ return UNION; }
}

{IDENT}             { 
	yylval.idl.name=new string(yytext);
	return IDENTIFIER;
}

{INT_CONST}         { 
	yylval.intval=atoi(yytext); 
	return INTEGER_CONSTANT;
}

{FLOAT_CONST}		{ 
	yylval.floatval=atof(yytext); 
	return FLOATING_CONSTANT;
}

{C_CHAR_CONST}		{ 
	yylval.charval=yytext[1]; 
	return CHAR_CONST;
}

{STRING_LITERAL}    { 
	return STRING_LITERAL;
}

{ENUM_CONST}		{ return(ENUMERATION_CONSTANT);}

"["                 {return '[';  }
"]"                 { return ']'; }
"("                 { return '('; }
")"                 { return ')'; }
"{"                 { return '{'; }
"}"                 { return '}'; }
"."                 { return '.'; }
"->"                { return (POINTER); }
"++"                { return (INCREMENT); }
"--"                { return (DECREMENT); }
"&"                 { return '&'; }
"*"                 { return '*'; }
"+"                 { return '+'; }
"-"                 { return '-'; }
"~"                 { return '~'; }
"!"                 { return '!'; }
"/"                 { return '/'; }
"%"                 { return '%'; }
"<<"                { return (LEFT_SHIFT); }
">>"                { return (RIGHT_SHIFT); }
"<"                 { return '<'; }
">"                 { return '>'; }
"<="                { return (LESS_EQUALS); }
">="                { return (GREATER_EQUALS); }
"=="                { return (EQUALS); }
"!="                { return (NOT_EQUALS); }
"^"                 { return '^'; }
"|"                 { return '|'; }
"&&"                { return (AND); }
"||"                { return (OR); }
"?"                 { return '?'; }
":"                 { return ':'; }
";"                 { return ';'; }
"..."               { return (ELLIPSIS); }
"="                 { return '='; }
"*="                { return MULTIPLY_ASSIGN; }
"/="                { return DIVIDE_ASSIGN; }
"%="                { return MODULO_ASSIGN; }
"+="                { return ADD_ASSIGN; }
"-="                { return SUBTRACT_ASSIGN; }
"<<="               { return LEFT_SHIFT_ASSIGN; }
">>="               { return RIGHT_SHIFT_ASSIGN; }
"&="                { return AND_ASSIGN; }
"^="                { return XOR_ASSIGN; }
"|="                { return OR_ASSIGN; }
","                 { return ','; }
"#"                 { return '#'; }

{COMMENT}           {;}
{WHITESPACE}        {;}

%%
