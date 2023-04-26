import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Color Pallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title:  'Color Pallet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<String, Color> colors = {
    'purple': Colors.purple,
    'blue': Colors.blue,
    'yellow': Colors.yellow,
    'pink': Colors.pink,
    'teal': Colors.teal,
    'orange': Colors.orange,
  };

  Color? selectedColor;
  

  void _setColor(String colorName, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('color', colorName);
    setState(() {
      selectedColor = color;
    });
  }

  void _getStoredColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? colorName = prefs.getString('color');
    setState(() {
      selectedColor = colors[colorName];
    });
  }

  @override
  void initState() {
    _getStoredColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor,
      appBar: AppBar(
        backgroundColor: selectedColor,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              const SizedBox(
              height: 20,
            ),
            Center(
              child: Text('You are operating on ${Platform.operatingSystem}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 50,),
            for(var entry in colors.entries)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(offset: Offset(14, 8),
                    color: Colors.black26,
                    blurRadius: .4,
                    spreadRadius: .7,
                    blurStyle: BlurStyle.outer,
                    )
                  ]
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: entry.value,
                    minimumSize: Size(300, 60),
                  ),
                  onPressed: () => _setColor(entry.key, entry.value),
                  child: Text(entry.key.toString()),
                ),
              ),
              
          ],
        ),
      ),
    );
  }
}
