import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class TransactionDetails {
  int? id;
  String? name;
  String? email;
  int? age;


  TransactionDetails({
    this.id,
    this.name,
    this.email,
    this.age,

  });



  TransactionDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json['name'];
    email = json['family'];
    age = json['age'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['family'] = email;
    data['age'] = age;

    return data;
  }
}

Future<bool> deleteAlbum(TransactionDetails transactionDetails) async {
  try {

    final response = await Dio().delete(
            "${baseUrl}delete/${transactionDetails.id}");
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }catch(e){
    return false;
  }
}



class APIService {
  APIService._singleton();
  static final APIService instance = APIService._singleton();
}
String get baseUrl {

  return 'http://127.0.0.1:8080/api/mori/student/';}


Future<List<TransactionDetails>> fetchAlbum() async {
  try{
    final response = await Dio().get("http://127.0.0.1:8080/api/mori/student/get");

    if (response.statusCode == 200) {
      var res = <TransactionDetails>[];
      for(var s in response.data as List<dynamic>){
        res.add(TransactionDetails.fromJson(s));
      }
     return res;
    } else {
      return [];
    }
  }catch(e){
    return [];
  }

}




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
        title: 'zaban',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00F000)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();


  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {






  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    // void deleteItem(int index) {
    //   setState(() {
    //     items.removeAt(index);
    //   });
    // }

    return Scaffold(
      body: Column(

        children: [
          Text('mori mori'),
          BigCard(pair: pair),

          ElevatedButton(
            onPressed: () {
              appState.getNext();
              fetchAlbum();
              print('next pressed2!');
            },
            child: Text('next'),
          ),
          Expanded(child: FutureBuilder<List<TransactionDetails>>(
            future: fetchAlbum(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(snapshot.data![index].id.toString()),
                      ),
                      subtitleTextStyle:
                      TextStyle(color: Colors.blue),
                      title: Text(snapshot.data![index].name.toString()),
                      trailing:
                      Text(snapshot.data![index].age.toString()),
                      subtitle: Row(
                        children: [
                          Text(snapshot.data![index].email.toString()),
                          IconButton(onPressed: () async {
                           await deleteAlbum(snapshot.data![index]);

                           // setState(() {
                           //
                           // });
                            print("delete pressed");

                            // snapshot.data![index]
                          }, icon: Icon(Icons.delete))
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
          ),

        ],
      ),
    );


  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      elevation: 10000000,
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(pair.asLowerCase, style: style,),
      ),
    );
  }
}
class NextPage extends MyHomePage{
  var current = WordPair.random();

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: Column(
            children: [
              Text("nextPage"),
              ElevatedButton(onPressed: (){
                print('button pressed!');
              }, child: Text("next"))
            ],
          )
        );
  }

}
