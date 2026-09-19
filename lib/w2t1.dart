
void checkBalance({ required String name, required double balance}) => print ('$name your current balance is $balance');
void main(){
   checkBalance(name: 'John', balance: 1000.0);
   checkBalance(name: 'Alice', balance: 2000.0);
 }