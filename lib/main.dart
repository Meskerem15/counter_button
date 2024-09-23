
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;
  bool _isFirstImage = true;

  // This method is called when the increment button is pressed
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // This method is called when the toggle image button is pressed
  void _toggleImage() {
    setState(() {
      _isFirstImage = !_isFirstImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Counter and Image Toggle App'),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Counter Text
                Text(
                  'Counter: $_counter',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                // Display Image from the web
                Image.network(
                  _isFirstImage
                    ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWlOfiE45cjdBRyOERRZWc7Ouka_3pS7fXDyHGridaOdHqRdoe_-cXjhYllbA-iMeRKk8&usqp=CAU'
                    : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWLtIDguaBFDhDCLI26afG9AdIzHTsixamnm1TTu-ETwAQuQcNt8PjPKIPqaOjbniNMWg&usqp=CAU',
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return Text('Error loading image');
                  },
                ),
                SizedBox(height: 20),
                // Toggle Image Button
                ElevatedButton(
                  onPressed: _toggleImage,
                  child: Text('Toggle Image'),
                ),
              ],
            ),
            // Positioned Increment Button at the bottom center
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _incrementCounter,
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 24),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
