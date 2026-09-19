
double deposit({required double currentBalance,  double? amount}){
   double amo = amount ?? 0.0;
   currentBalance += amo;
   return currentBalance;
 }
 void main(){
   print(deposit(currentBalance:1000,amount:500));
   print(deposit(currentBalance:1000));
   }