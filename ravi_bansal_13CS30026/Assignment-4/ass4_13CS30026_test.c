/**
Name-: Ravi Bansal
Roll No- 13CS30026
**/


enum{
	SUN=0,
	MON,
	TUE,
	WED,
	THU,
	FRI,
	SAT
};

inline void option(int weekday)
{
	switch(weekday)
	{
	case 0:
		printf("SUNDAY\n");
		break;
	case 1:
		printf("MONDAY\n");
		break;
	case 2:
		printf("TUESDAY\n");
		break;
	case 3:
		printf("WEDNESDAY\n");
		break;
	case 4:
		printf("THURSDAY\n");
		break;
	case 5:
		printf("FRIDAY\n");
		break;
	case 6:
		printf("SATURDAY\n");
		break;
	default:
		printf("Default\n");
	}
}
int main()
{
	int x=4,y=5;
	int z=x+y;
	printf("Adding two integers: %d + %d = %d\n",x,y,z);
	double a = 2e+4;
	double b = -4E+1;
	double c = a+b;
	printf("Adding two doubles: %lf +%lf = %lf\n",a,b,c);

	int i=0;
	long long int longans=1;
	printf("Long int: %lld\n",longans);
	int m=2;
	int n = WED;
	m=n%m;
	printf("m = %d\n",m);
	m ^= n;
	int k=3<<2;
	printf("3<<2 = %d\n",k);
	int l=4;
	int r=1;
	if(l&&r)
	{
		printf("4&&1 is true\n");
	}
	else
		printf("4&&1 is false\n");
	int mo=4;
	option(4);
	mo+=4;
	mo-=4;
	mo/=2;
	mo*=3;
	int op[2];
	op[1]=mo;
	int *op1=&op[0];
	op1++;
	(*op)--;
	int arr[3]={0,1,-1};
	int sum=0;
	for(i=0;arr[i]!=-1;i++)
		sum+=arr[i];
	return 0;
}


