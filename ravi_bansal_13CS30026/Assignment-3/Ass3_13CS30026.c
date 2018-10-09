#include "y.tab.h"
#include <cstdio>
extern int yylex();
extern char* yytext;
int main() {
    int token = 1;
	while(token)
    {
       token = yylex();
       switch (token) 
       {

        case KEYWORD: printf("< KEYWORD, %d, %s >\n",
        token, yytext); break;
        case IDENTIFIER: printf("< IDENTIFIER, %d, %s >\n",
        token, yytext); break;
        case PUNCTUATOR: printf("< PUNCTUATOR, %d, %s >\n",
        token, yytext); break;
        case STRING_LITERAL: printf("< STRING_LITERAL, %d, %s >\n",
        token, yytext); break;
        case CONSTANT: printf("< CONSTANT, %d, %s >\n",
        token, yytext); break;
        }

    }
	return 0;
}
