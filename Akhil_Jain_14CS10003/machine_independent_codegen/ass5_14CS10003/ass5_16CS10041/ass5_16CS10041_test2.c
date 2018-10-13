int main() //Selection Sort
{
	int a[5];
	int temp;
	a[0] = 1;
	a[1] = 0;
	a[2] = 8;
	a[3] = 3;
	a[4] = 7;
	
	for(int i=0;i<5;i++){
		for(int j=0;j<i;j++){
			if(a[i] > a[i]){
				temp =  a[i];
				a[i] = a[j];
				a[j] = temp;
			}
		}
	}
}
