%{ /* C Declarations and Definitions */
#include <string>
#include <iostream>
using namespace std;
extern int yylex();
void yyerror(string s);
%}
%union {
int intval;
}
%token <intval> KEYWORD
%token <intval> IDENTIFIER
%token <intval> CONSTANT
%token <intval> STRING_LITERAL
%token <intval> PUNCTUATOR

%%

statement   :|KEYWORD|IDENTIFIER|CONSTANT|STRING_LITERAL|PUNCTUATOR
%%
void yyerror(string s) {
std::cout << s << std::endl;
}

