import 'package:flutter/material.dart';

class GroceryListApp extends StatelessWidget {
  const GroceryListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 85, 93, 107)),
        useMaterial3: true,
      ),
      home: const GroceryListHomePage(title: 'Grocery List Home Page'),
    );
  }
}

class GroceryListHomePage extends StatefulWidget {
  const GroceryListHomePage({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryListHomePage> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<String> _items = <String>[];

  void _addItem(String item) {
    setState(() {
      _items.add(item);
    });
    _textFieldController.clear();
  }

  Future<void> _displayAddItemDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new item'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type new item'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                _addItem(_textFieldController.text);
              },
            ),
          ],
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _items.map((String item) {
          return Text(
            item
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayAddItemDialog(),
        tooltip: 'Add item',
        child: const Icon(Icons.add),
      ),
    );
  }
}