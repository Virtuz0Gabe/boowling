import 'package:flutter/material.dart';
import 'package:boowling/View/home_page.dart';

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
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = [
    const HomePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.people), label: "Alunos"),
          //NavigationDestination(icon: Icon(Icons.list_rounded), label: "Chamada"),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    ); 
  }
}     
