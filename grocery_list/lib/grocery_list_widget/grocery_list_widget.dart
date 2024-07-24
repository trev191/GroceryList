import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_list/blocs/grocery_list_bloc.dart';
import 'package:grocery_list/grocery_list_widget/grocery_list_item.dart';
import 'package:grocery_list/models/item.dart';
import 'package:grocery_list/grocery_list_widget/error_dialog.dart';

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
        home: const GroceryListHomePage(title: 'Grocery List'),
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
  final TextEditingController _addItemTextFieldController = TextEditingController();

  // Assemble all Grocery List Items into a List widget
  ListView buildGroceryListItemsWidget(items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return (items[index]);
      },
    );
  }

  // Display dialog box for adding new Grocery List Item
  Future<void> _displayAddGroceryListItemDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new item'),
          content: TextField(
            controller: _addItemTextFieldController,
            decoration: const InputDecoration(hintText: 'Type new item'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (_addItemTextFieldController.text.isNotEmpty){
                  // Create new Grocery List Item and emit to BLoC handler
                  Navigator.of(context).pop();
                  GroceryListItem newGroceryListItem = GroceryListItem(
                    key: UniqueKey(),
                    item: Item(itemText: _addItemTextFieldController.text),
                  );
                  context.read<GroceryListBloc>().add(
                    AddGroceryListItem(groceryListItem: newGroceryListItem)
                  );
                  _addItemTextFieldController.clear();
                } else {
                  // Handle empty text field
                  displayEmptyFieldError(context);
                }
              },
            ),
          ],
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    // Create grocery list initialization event to grab data from disk
    context.read<GroceryListBloc>().add(
      InitGroceryListItems()
    );
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocBuilder<GroceryListBloc, GroceryListState> (
          builder: (context, state) {
            // Display grocery list items upon state update and non-empty state
            if (((state is GroceryListInitial) || (state is GroceryListUpdated))
                 && state.groceryListItems.isNotEmpty) {
              return buildGroceryListItemsWidget(state.groceryListItems);
            } else {
              // Display message stating empty list
              return const SizedBox(
                width: double.infinity,
                child: Center(child: Text('No current items')),
              );
            }
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayAddGroceryListItemDialog(),
        tooltip: 'Add item',
        child: const Icon(Icons.add),
      ),
    );
  }
}