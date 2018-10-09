%{
#include "y.tab.h"
#include <stdio.h>
%}

DIGIT [0-9]
NONZERODIG [1-9]
IDENT_ND [A-Za-z_]
IDENT ({IDENT_ND}({IDENT_ND}|{DIGIT})*)
WHITESPACE [ \n\t]
SIGN [+-]
DIGIT_SEQ {DIGIT}+
EXPONENT_PART ([eE]{SIGN}?{DIGIT_SEQ})
ZERO "0"
INT_CONST (({NONZERODIG}({DIGIT}*))|{ZERO}+)
DOT "."
FRACT_CONST (({DIGIT_SEQ}?{DOT}{DIGIT_SEQ})|({DIGIT_SEQ}{DOT}))
FLOAT_CONST (({FRACT_CONST}{EXPONENT_PART}?)|({DIGIT_SEQ}{EXPONENT_PART}))
ENUM_CONST {IDENT}
ESC_SEQ ([\\][\'\"\?\\abfnrtv])
C_CHAR [^\'\\\n]|{ESC_SEQ}
C_CHAR_SEQ {C_CHAR}+
C_CHAR_CONST (\'{C_CHAR_SEQ}\')
CONST ({INT_CONST}|{FLOAT_CONST}|{ENUM_CONST}|{C_CHAR_CONST})
S_CHAR [^\"\\\n]|{ESC_SEQ}
S_CHAR_SEQ {S_CHAR}+
STRING_LITERAL (\"{S_CHAR_SEQ}*\")
SINGLE_COMMENT [/][/].*
MULTI_END [\*]+[/]
MULTI_START [/][\*]+
NON_STAR (([^\*]).*)
NON_FS ([^/].*)
AVOID_MULTI_END (NON_STAR|([\*]{NON_FS}))
MULTI_COMMENT ({MULTI_START}(([^\*])|((\*)+[^/\*]))*{MULTI_END})
COMMENT {SINGLE_COMMENT}|{MULTI_COMMENT}

%%

"auto"              {return AUTO;}
"enum"              {return ENUM;}
"restrict"          {return RESTRICT;} 
"unsigned"          {return UNSIGNED;}
"break"             {return BREAK;}
"extern"            {return EXTERN;}
"return"            {return RETURN;}
"void"              {return VOID;}
"char"              {return CHAR;}
"for"              	{return FOR;}
"signed"            {return SIGNED;}
"while"             {return WHILE;}
"const"             {return CONST;}
"goto"              {return GOTO;}
"sizeof"            {return SIZEOF;}
"case"              {return CASE;}
"float"             {return FLOAT;}
"short"             {return SHORT;}
"volatile"          {return VOLATILE;}
"_Bool"             {return BOOL;}
"continue"          {return CONTINUE;}
"if"                {return IF;}
"static"            {return STATIC;}
"_Complex"          {return COMPLEX;}
"default"           {return DEFAULT;}
"inline"            {return INLINE;}
"struct"            {return STRUCT;}
"_Imaginary"        {return IMAGINARY;}
"do"                {return DO;}
"int"               {return INT;}
"switch"            {return SWITCH;}
"double"            {return DOUBLE;}
"long"              {return LONG;}
"typedef"           {return TYPEDEF;}
"else"              {return ELSE;}
"register"          {return REGISTER;}
"union"             {return UNION;}


"["                 {return '[';  }
"]"                 { return ']'; }
"("                 { return '('; }
")"                 { return ')'; }
"{"                 { return '{'; }
"}"                 { return '}'; }
"."                 { return '.'; }
"->"                { return PTR_OP; }
"++"                { return INC_OP; }
"--"                { return DEC_OP; }
"&"                 { return '&'; }
"*"                 { return '*'; }
"+"                 { return '+'; }
"-"                 { return '-'; }
"~"                 { return '~'; }
"!"                 { return '!'; }
"/"                 { return '/'; }
"%"                 { return '%'; }
"<<"                { return LEFT_OP; }
">>"                { return RIGHT_OP; }
"<"                 { return '<'; }
">"                 { return '>'; }
"<="                { return LE_OP; }
">="                { return GE_OP; }
"=="                { return EQ_OP; }
"!="                { return NE_OP; }
"^"                 { return '^'; }
"|"                 { return '|'; }
"&&"                { return AND_OP; }
"||"                { return OR_OP; }
"?"                 { return '?'; }
":"                 { return ':'; }
";"                 { return ';'; }
"..."               { return ELLIPSIS; }
"="                 { return '='; }
"*="                { return MUL_ASSIGN; }
"/="                { return DIV_ASSIGN; }
"%="                { return MOD_ASSIGN; }
"+="                { return ADD_ASSIGN; }
"-="                { return SUB_ASSIGN; }
"<<="               { return LEFT_ASSIGN; }
">>="               { return RIGHT_ASSIGN; }
"&="                { return AND_ASSIGN; }
"^="                { return XOR_ASSIGN; }
"|="                { return OR_ASSIGN; }
","                 { return ','; }
"#"                 { return '#'; }

{COMMENT}           {printf("< Comment, %s >\n",yytext);}

{IDENT}             { return IDENTIFIER;}
{CONST}             { return CONSTANT;}
{STRING_LITERAL}    { return STRING_LITERAL;}


{WHITESPACE}        {;}

%%
