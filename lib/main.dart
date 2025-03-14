import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/models/new_model.dart';
import 'api/services/new_service.dart';
//import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  List<New> news = [];
  final ApiService newsService = ApiService();

  MyAppState() {
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      news = await newsService.fetchNews();
      print('Fetched ${news.length} news items');
      notifyListeners();
    } catch (e) {
      print('Failed to load news: $e');
    }
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Noticies noves'),
            Container(
              color: Colors.purple[100],
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: appState.news.map((news) {
                    return SizedBox(
                      width: 150,
                      height: 150,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                news.name ?? 'No title',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(), // situa el botó de llegir més a la part inferior de la card
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewsPage(news: news),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Llegir més',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsPage extends StatelessWidget {
  final New news;

  const NewsPage({required this.news, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticia al detall'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible( // premet que el text s'adapti a la pantalla
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.name ?? 'No title for this new',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      
                    ),
                    softWrap: true, // trenca la linia si es necesari
                  ),
                  SizedBox(height: 8),
                  Text(
                    news.description ?? 'No description for this new', 
                    style: TextStyle(fontSize: 16),
                    softWrap: true, // trenca la linia si es necesari
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    child: Image.network(   //s'utilitza per a carregar imatges des de internet
                      news.image ?? '',
                      fit: BoxFit.cover,   // ajusta la imatge a la mida del sizedBox
                    ),
                  ),
                  SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // equilibrem distancies en tots els costats de la tarjeta
                      child: Column(
                        children: [
                          Text(
                            'Url de la noticia:',
                            style: TextStyle(fontSize: 16),
                            softWrap: true, // trenca la linia si es necesari
                          ),
                          SizedBox(height: 8),
                          Text(
                            news.url ?? 'No url for this new', 
                            style: TextStyle(fontSize: 16),
                            softWrap: true,// trenca la linia siés necesari
                          ),
                          ElevatedButton(
                            
                            onPressed: () =>{},// _launchURL(news.url),
 
                            child: Text("Obrir noticia al navegador"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_launchURL(String? url) async {
  if (url == null || url.isEmpty) {
    throw Exception('URL is null or empty');
  }
  final Uri uri = Uri.parse(url);
  //if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
 // }
}
