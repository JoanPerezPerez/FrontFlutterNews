import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/models/new_model.dart';
import 'api/services/new_service.dart';

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
          children:[
            Text('Noticies noves'),
            Container(
              color: Colors.purple[100],
              padding: const EdgeInsets.all(16.0),
              child:Row(
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
                            SizedBox(height: 8),
                            Text(
                              news.description ?? 'No description',
                              style: TextStyle(fontSize: 5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
