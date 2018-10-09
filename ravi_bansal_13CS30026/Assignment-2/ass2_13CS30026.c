
#include "myl.h"
#define BUFF 50 

int printi(int n){
    char arr[BUFF],zero='0';
    int i=0,j,k,count_bytes;
    if(n==0)
      {
        arr[i]=zero;
        i++;
      }
    else{
       if(n<0){
          arr[i]='-';// if the number is negative
          n=-n;
          i++;
        }
       while(n){
          int dig=n%10;
          arr[i]=(char)(zero+dig); // for storing the number in reverse order
          n/=10;
          i++;
       }
       if(arr[0]=='-')
        {
          j=1;
        }
       else j=0;
       k=i-1;
       while(j<k)// reversing the number to get the original one
       {
          char temp=arr[j];
          arr[j]=arr[k];
          arr[k]=temp;
          j++;
          k--;
       }
    }
    count_bytes=i;
    __asm__ __volatile__ (
          "movl $1, %%eax \n\t"
          "movq $1, %%rdi \n\t"
          "syscall \n\t"
          :
          :"S"(arr), "d"(count_bytes)
    ) ;  
    return count_bytes;
}

int prints(char *s){
	int i=0;
	while(s[i]!='\0')// to count the length of the array
  {
    i++;
  }

	__asm__ __volatile__ (
          "movl $1, %%eax \n\t"
          "movq $1, %%rdi \n\t"
          "syscall \n\t"
          :
          :"S"(s), "d"(i)
    ) ; 
    return i;
}

int printd(float f){
	char arr[BUFF],zero='0';
  int i=0;
  if(f<0)
  {
    arr[i]='-';// for the negative number
    f=(-1.0)*f;
    i++;
  }
	int a=(int)f,j,k,count_bytes;
	float b=f-a;// to take the decimal part out of the number
    if(a==0)
    {
      arr[i]=zero;// if there is zero only
      i++;
    }
    else
    {
       while(a!=0)
       {
          int dig=a%10;
          arr[i]=(char)(zero+dig);//to creat the number before decimal part in reverse
          a/=10;
          i++;
       }
       if(arr[0]=='-')
       {
          j=1;
       }
       else j=0;
       k=i-1;
       while(j<k) // to reverse the number so that we can get the right one
       {
          char temp=arr[j];
          arr[j]=arr[k];
          arr[k]=temp;
          j++;
          k--;
       }
    }
    if(b!=0) // for the decimal part
    {
    	arr[i]='.';
      i++;
    	int p=0;
    	while(p<7){// we are taking upto 6 precision and one more more accuracy
    	b=b*10;
    	int dig=(int)b;
    	arr[i]=(char)(zero+dig);
      i++;
    	b=b-dig;
    	p++;
    }
	}
    count_bytes=i;
    __asm__ __volatile__ (
          "movl $1, %%eax \n\t"
          "movq $1, %%rdi \n\t"
          "syscall \n\t"
          :
          :"S"(arr), "d"(count_bytes)
    ) ;  
    return count_bytes;
}

int readi(int *ep){
  char arr[BUFF];
  int i=0,k,count_bytes=20,n=0;
  __asm__ __volatile__ (
          "movl $0, %%eax \n\t"
          "movq $1, %%rdi \n\t"
          "syscall \n\t"
          :
          :"S"(arr), "d"(count_bytes)
    ) ;
  *ep=0;// initialize it with ok
  if(arr[i]=='-')
    {
      k=-1;
      i++;
    }
  else k=1;
  while(arr[i]!='\n'){
    if(arr[i]<48||arr[i]>57)// to check for error
    {
	*ep=1; // if it is error
	return 0;
    }
    n=n*10;
    n=n+(arr[i]-'0');
    i++;
  }
  n=n*k;
  return n;
}

int readf(float *f)
{
  char arr[BUFF];
  int i=0,k,count_bytes=50;
  __asm__ __volatile__ (
          "movl $0, %%eax \n\t"
          "movq $1, %%rdi \n\t"
          "syscall \n\t"
          :
          :"S"(arr), "d"(count_bytes)
    ) ;  
  if(arr[i]=='-')
  {
      k=-1;
      i++;
  }
  else k=1;
  int flag=0;
  int x=0;
  long long int temp1=0;
  long long int temp2=0;
  long long int dec=0;
  while(arr[i]!='\n')
  {
    if(arr[i]==46&&flag==0)//to check for the decimal point
    {
      flag=1;           // to know that we have to take after decimal point
      i++;
      continue;
    }
    if(arr[i]<48||arr[i]>57)// to check whether the digit lies between 0 and 9
      return ERR;
    if(flag==0)// to store the value before decimal point
    {
      temp1*=10;
      temp1+=(arr[i]-'0');
      i++;
    }
    if(flag==1){
      dec=dec*10+(arr[i]-'0');
      i++;
      x++;
    }
  }
  long long int count=1;
  if(x>6) // to make it to upto 6 precision digits
  {
    x=x-6;
    while(x!=0)
    {
      count*=10;
      x--;
    }
    temp2=dec/count;
  }
  else if(x<=6)
  {
    while(x!=6)
    {
      dec=dec*10;
      x++;
    }
    temp2=dec;
  }
  temp1=temp1*1000000+temp2;
  (*f)=((float)temp1)/(1000000.0);//finally converting it into float
  if(k==-1)// if the number is negative
  {
    (*f)*=-1.0;
  }
  return OK;
}
