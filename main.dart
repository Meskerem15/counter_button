import 'package:flutter/material.dart';

// Entry point of the application
void main() => runApp(MyApp());

// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enhanced Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterWidget(),
    );
  }
}

// Stateful widget that maintains the state of the counter
class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  // Counter variable to track the current value
  int _counter = 0;
  
  // Controller for the text input field to get custom increment values
  final _incrementController = TextEditingController();
  
  // Maximum value the counter can reach
  final _maxCounter = 100;
  
  // List to store the history of counter values
  final _history = <int>[];
  
  // Variable to keep track of the previous counter value for undo functionality
  int? _previousCounter;

  @override
  Widget build(BuildContext context) {
    // Determine the color of the counter based on its value
    Color counterColor;
    if (_counter == 0) {
      counterColor = Colors.red;
    } else if (_counter > 50) {
      counterColor = Colors.green;
    } else {
      counterColor = Colors.blue;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display the current counter value with dynamic background color
          Center(
            child: Container(
              color: counterColor,
              child: Text(
                '$_counter',
                style: TextStyle(fontSize: 50.0, color: Colors.white),
              ),
            ),
          ),
          // Slider to adjust the counter value
          Slider(
            min: 0,
            max: _maxCounter.toDouble(),
            value: _counter.toDouble(),
            onChanged: (double value) {
              // Update counter value and history if within the maximum limit
              if (value <= _maxCounter) {
                setState(() {
                  _counter = value.toInt();
                  _addToHistory();
                });
              }
            },
            activeColor: Colors.blue,
            inactiveColor: Colors.red,
          ),
          // Text field for custom increment value
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _incrementController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Custom Increment Value',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // Row with buttons for counter manipulation
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text('Increment'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _decrementCounter,
                child: const Text('Decrement'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _resetCounter,
                child: const Text('Reset'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _undoCounter,
                child: const Text('Undo'),
              ),
            ],
          ),
          // Display message if the maximum counter value is reached
          if (_counter >= _maxCounter)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Maximum limit reached!',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          // Display counter history
          Expanded(
            child: ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final value = _history[index];
                return ListTile(
                  title: Text('$value'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Increment the counter by a custom or default value
  void _incrementCounter() {
    final incrementValue = int.tryParse(_incrementController.text) ?? 1;
    if (_counter + incrementValue <= _maxCounter) {
      setState(() {
        _previousCounter = _counter;
        _counter += incrementValue;
        _addToHistory();
        if (_counter == 50 || _counter == 100) {
          _showCongratulationsDialog();
        }
      });
    }
  }

  // Decrement the counter if it's above 0
  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _previousCounter = _counter;
        _counter--;
        _addToHistory();
      });
    }
  }

  // Reset the counter to 0
  void _resetCounter() {
    setState(() {
      _previousCounter = _counter;
      _counter = 0;
      _addToHistory();
    });
  }

  // Undo the last counter change
  void _undoCounter() {
    if (_history.isNotEmpty) {
      setState(() {
        _counter = _history.removeLast();
      });
    }
  }

  // Add the current counter value to the history
  void _addToHistory() {
    _history.add(_counter);
  }

  // Display a congratulatory message when reaching certain milestones
  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: Text('You have reached $_counter!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

}