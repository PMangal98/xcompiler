/**
Name-: Ravi Bansal
Roll No- 13CS30026
**/
#include <stdio.h>


typedef long long ll;

enum{
	ZERO = 0,
	ONE,
	TWO,
	THREE
};

typedef struct node{
	int x;
}node;
int main()
{
	int x=4;
	int y=5;
	int z=x+y;
	printf("Adding two integers: %d + %d = %d\n",x,y,z);
	double a = 2e+4;
	double b = -4E+1;
	double c = a+b;
	printf("Adding two doubles: %lf +%lf = %lf\n",a,b,c);

	int i=0;
	ll longans=1;
	for(i=0;i<100;i++)
		longans*=1000000000;
	printf("Long int: %lld\n",longans);
	int m=2;
	int n = THREE;
	m=n%m;
	printf("m = %d\n",m);
	int k=3<<2;
	printf("3<<2 = %d\n",k);
	int l=4;
	int r=1;
	if(l&&r)
	{
		printf("4&&1 is true");
	}
	else
		printf("4&&1 is false");
	return 0;
}
