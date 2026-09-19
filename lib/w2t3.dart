
double transfer({
    required String name,
    required double currentBalance,
    double? amount,
    int? pinCode
  })
{ if(amount == null){
  amount = 0;
  }
  int actpin = pinCode ?? 0000;
  if(actpin != 1234 ){
    print('error message');
    return currentBalance;
  }
  if(amount > currentBalance){
    print('Error:insufficient funds');
    return currentBalance;
  }
  currentBalance -= amount;
  return currentBalance;
}
void main(){
  double balance = 100000000.0;

  
  balance = transfer(
    name: 'Shahkruz',
    currentBalance: balance,
    amount: 1000.0,
    pinCode: 1234,
  );
  

  print('Updated balance in main: $balance');
}