import 'package:http/http.dart' show Client;
class NewsApiProvider {

  Client client = Client();
  
  fetchTopsIds() {
    client.get('https://hacker-news.firebaseio.com/v0/topstories.json');
  }

  fetchItem() {

  }
}