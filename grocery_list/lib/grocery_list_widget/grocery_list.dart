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

// Basic class for single grocery list item
class Item {
  Item({
    required this.itemText,
  });

  final String itemText;
}

// Contains Widget builder for single grocery list item
class GroceryListItem extends StatelessWidget {
  const GroceryListItem({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.itemText)
    );
  }
}

class _GroceryListState extends State<GroceryListHomePage> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<Item> _items = <Item>[];

  void _addItem(String itemText) {
    setState(() {
      _items.add(Item(itemText: itemText));
    });
    _textFieldController.clear();
  }

  List<GroceryListItem> buildGroceryListItemsWidget() {
    return (
      _items.map((Item item) {
        return GroceryListItem(
          item: item,
        );
      }).toList()
    );
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
                if (_textFieldController.text != ''){
                  Navigator.of(context).pop();
                  _addItem(_textFieldController.text);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => const AlertDialog(
                      content: Text('Field must not be empty'),
                    ));
                }
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
        children: buildGroceryListItemsWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayAddItemDialog(),
        tooltip: 'Add item',
        child: const Icon(Icons.add),
      ),
    );
  }
}