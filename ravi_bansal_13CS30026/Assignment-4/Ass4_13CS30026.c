#include<stdio.h>
#include "y.tab.h"

int main()
{
  extern int yydebug;
  yydebug=1;
  int error = yyparse();
  if(error)
    printf("Failure\n");
  else
    printf("Success\n");
}
