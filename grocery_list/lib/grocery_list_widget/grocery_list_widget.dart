import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_list/blocs/grocery_list_bloc.dart';
import 'package:grocery_list/grocery_list_widget/grocery_list_item.dart';

class GroceryListApp extends StatelessWidget {
  const GroceryListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroceryListBloc(),
      child: MaterialApp(
        title: 'Grocery List',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 85, 93, 107)),
          useMaterial3: true,
        ),
        home: const GroceryListHomePage(title: 'Grocery List Home Page'),
      ),
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

  ListView buildGroceryListItemsWidget(items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GroceryListItem(
          item: item,
        );
      },
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
                if (_textFieldController.text.isNotEmpty){
                  Navigator.of(context).pop();
                  context.read<GroceryListBloc>().add(
                    AddItem(itemText: _textFieldController.text)
                  );
                  _textFieldController.clear();
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
      body: BlocBuilder<GroceryListBloc, GroceryListState> (
          builder: (context, state) {
            if (state is GroceryListUpdated && state.items.isNotEmpty) {
              return buildGroceryListItemsWidget(state.items);
            } else {
              return const SizedBox(
                width: double.infinity,
                child: Center(child: Text('No current items')),
              );
            }
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayAddItemDialog(),
        tooltip: 'Add item',
        child: const Icon(Icons.add),
      ),
    );
  }
}