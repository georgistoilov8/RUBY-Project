#include<iostream>
using namespace std;
int factorial(int i){
	int result=i;
	for( ;i>1;i--){
		result*=i;
	}
	return result;
}
int main(){
	int MAX_FACT=100;
	for(int i=0;i<MAX_FACT;i++){
		int fact=factorial(i);
		cout<<"factorial "<<i<<" = "<<fact<<endl;
	}
	return 0;
}
