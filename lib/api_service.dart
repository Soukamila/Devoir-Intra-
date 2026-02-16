import 'package:http/http.dart' as http; 
import 'dart:convert';

class APIService{
  static Future <dynamic> get(String url) async{
  final response =await http.get(Uri.parse(url));
  if (response.statusCode ==200) {
    return jsonDecode(response.body);
   } 
   else{
    throw "Something went wrong";}

   }

}



  // Future post (String url)
  // static Future response = http.get(Uri.parse(url));
  // return response;
