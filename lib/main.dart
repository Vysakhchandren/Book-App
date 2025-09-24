import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
      ),
      home: const MyHomePage(),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override

  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('A.Reader'),
      ),
      body: const Column(
        children: [Text("Hello")],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.save),label: 'Save'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite')

      ],
      selectedItemColor: Theme.of(context).colorScheme.onPrimary,
      unselectedItemColor:Theme.of(context).colorScheme.onPrimary,
      onTap: (value) {
          print('Tapped: $value');
        setState(() {
          _currentIndex = value;
        });
        print('Tapped CurrentIndex: $_currentIndex');

      },
      ),

    );
  }
}
