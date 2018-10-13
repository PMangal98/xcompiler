int main()
{
	//testing common expressions that are commonly found
	int a,b=3; //int declaration
	a = b + 7; //Addition
	a = b - 2; //Subtraction
	a = b * 1; //multiplication
	a = b / 2; //division
	b = a%b;   //modulus
	
	double db1,db2=8.9;  //double declaration
	db1 = 2.0 + db2;          //double addition
	db1 = db2 - 1.0;          //double subtraction
	db1 = db2 * 8.0;          //double multiplication
	db1 = db2 / 20.0;         //double division
	
	int *p = &a;             //pointer and ampersand operator 
	if(*p==a){               //if-else
		b=a*2;
	}else{
		b=a*3;
	}
	
	int leftsh = b<<2;           //shift operator
	a++;                         //increment
	a *= 2;
	b /= 3;
	
}

