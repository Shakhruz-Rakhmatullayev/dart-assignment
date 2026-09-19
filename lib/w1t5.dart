 import 'dart:io';
 void main(){
   print("Enter a number:");
   int number = int.parse(stdin.readLineSync()!);
   bool isPrime = true;
   if (number <= 1) {
     isPrime = false;
   } 
   if (number <=3) {
     isPrime = true;
   }
   for (int i=2;i<=number;i++){
     if (number % i == 0){
       isPrime = false;
       break;
     }
   }
   if (isPrime){
     print("$number is a prime number");
   } else {
     print("$number is not a prime number");
   }
 }