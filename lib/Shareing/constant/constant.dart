//https://newsapi.org/v2/top-headlines?country=eg&category=health&apiKey=API_KEY
//base url=https://newsapi.org/
//method=v2/top-headlines?
//query=country=eg&category=health&apiKey=a9aa6d86b9574b08958d4f4be9e90659
//https://newsapi.org/v2/top-headlines?country=eg&category=health&apiKey=a9aa6d86b9574b08958d4f4be9e90659
//https://newsapi.org/v2/everything?q=tesla&from=2022-09-10&sortBy=publishedAt&apiKey=a9aa6d86b9574b08958d4f4be9e90659


import 'package:ShopApp/moduls/Login/Login_Screen.dart';
import 'package:ShopApp/moduls/OnBoarding.dart';
import 'package:ShopApp/network/network.local.dart';

void signOut(context){
  CashHelper.sharedPreferences!.remove('token')
      .then((value) {
    if(value==true){
      navigatAndfinshed(context, LoginScreen());
    }
  });
}
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
dynamic token='';
dynamic uid='';