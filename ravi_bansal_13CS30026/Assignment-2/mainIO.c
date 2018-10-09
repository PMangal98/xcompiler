/* 
 * main_print_int.c 
 * A system call to print an integer 
 */
#include "myl.h"
int main()
{ 
    int n,err,len;         
    float f;
    err=OK;
    prints("DISCLAIMER: No STL  Libraries were included by the programmer");                 
    prints("\nEnter an integer\n");	   //Print string  using my library
    n=readi(&err);     			   //Read integer using my library
    if(!err){
        len=printi(n);                     //Print integer using my library
        prints("\nDigits:");
        printi(len);
    }
    else
        prints("Error reading integer");
    prints("\nEnter a floating point number\n");      	
    err=readf(&f);                  //Read floating point using my library
    if(!err){
        len=printd(f);                     //Print floating point using my library
        prints("\nDigits+Decimal_Point:");
        printi(len);
    }
    else
        prints("Error reading float");
    prints("\n");
    return 0;
}
/*

    the float print and read are not compatible with eachother
    however when coupled with STL printf and scanf gives good results
*/