import 'dart:io';
void main(){
   print("input your text");
   String? text= stdin.readLineSync();
   int a = 0;
   for(int i = 0; i < text!.length; i++){
     if(text[i]=='a' || text[i]=='e' || text[i]=='i' || text[i]=='o' || text[i]=='u'){
       a++;
    }
  }
   print("the number of vowels in the text is $a");
 }