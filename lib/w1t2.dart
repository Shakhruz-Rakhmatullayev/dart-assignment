import 'dart:io';

void main() {
  stdout.write("Enter date: ");
  String? input = stdin.readLineSync();
  List<String> date = input?.split('.') ?? [];

  if (date.length < 3) {
    print('invalid value');
    return;
  }

  int day = int.parse(date[0]);
  int month = int.parse(date[1]);
  int year = int.parse(date[2]);
  int leap = 1;

  if (year % 100 == 0 && year % 400 != 0) {
    leap = 0;
  } else if (year % 400 == 0) {
    leap = 1;
  } else if (year % 4 == 0) {
    leap = 1;
  } else {
    leap = 0;
  }

  if ((day > 28 && leap == 0 && month == 2) || month > 12) {
    print('invalid value');
  } 
  else if (month == 1) {
    if (day > 31) {
      print('invalid value');
    } 
    else {
      day++;
      if (day > 31) {
        print("1.02.$year");
      }
      else {
        print("$day.$month.$year");
      }
    }
  } 
  else if (month == 2) {
    if (day > 29) {
      print('invalid value');
    } 
    else {
      day++;
      if ((leap == 1 && day > 29) || (leap == 0 && day > 28)) {
        print("1.03.$year");
      } 
      else {
        print("$day.$month.$year");
      }
    }
  } 
  else if (month == 3) {
    if (day > 31) {
      print('invalid value');
    } 
    else {
      day++;
      if (day > 31) {
        print("1.04.$year");
      } 
      else {
        print("$day.$month.$year");
      }
    }
  } 
  else if (month == 4) {
    if (day > 30) {
      print('invalid value');
    }
    else {
      day++;
      if (day > 30) {
        print("1.05.$year");
      } 
      else {
        print("$day.$month.$year");
      }
    }
  } 
  else if (month == 5) {
    if (day > 31) {
      print('invalid value');
    } 
    else {
      day++;
      if (day > 31) {
        print("1.06.$year");
      } 
      else {
        print("$day.$month.$year");
      }
    }
  } 
  else if (month == 6) {
    if (day > 30) {
      print('invalid value');
    } 
    else {
      day++;
      if (day > 30) {
        print("1.07.$year");
      } 
      else {
        print("$day.$month.$year");
      }
    }
  } 
  else if (month == 7) {
    if (day > 31) {
      print('invalid value');
    } 
    else {
      day++;
      if (day > 31) {
        print("1.08.$year");
      }
      else {
        print("$day.$month.$year");
      }
    }
  } 
  else if (month == 8) {
    if (day > 31) {
      print('invalid value');
    } 
    else {
      day++;
      if (day > 31) {
        print("1.09.$year");
      }
      else {
        print("$day.$month.$year");
      }
    }
  } 
  else if (month == 9) {
    if (day > 30) {
      print('invalid value');
    } 
    else {
      day++;
      if (day > 30) {
        print("1.10.$year");
      } 
      else {
        print("$day.$month.$year");
      }
    }
  } 
  else if (month == 10) {
    if (day > 31) {
      print('invalid value');
    } 
    else {
      day++;
      if (day > 31) {
        print("1.11.$year");
      } 
      else {
        print("$day.$month.$year");
      }
    }
  } 
  else if (month == 11) {
    if (day > 30) {
      print('invalid value');
    } 
    else {
      day++;
      if (day > 30) {
        print("1.12.$year");
      } 
      else {
        print("$day.$month.$year");
      }
    }
  } 
  else if (month == 12) {
    if (day > 31) {
      print('invalid value');
    } 
    else {
      day++;
      if (day > 31) {
        year++;
        print("1.01.$year");
      } else {
        print("$day.$month.$year");
      }
    }
  }
}