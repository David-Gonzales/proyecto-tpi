import 'package:http/http.dart' as http;
class RegistroService {

  postRegistro() async {
    try {
      var url = Uri.parse('');
      var response = await http.post(
        url,
        body: {}
      );

      if(response.statusCode == 200){

      } else {
        return null;
      }

    } catch (e) {
      print(e);
      return null;
    }
    

  }
}