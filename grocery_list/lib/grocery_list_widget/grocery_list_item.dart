import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_list/blocs/grocery_list_bloc.dart';
import 'package:grocery_list/models/item.dart';
import 'package:grocery_list/grocery_list_widget/error_dialog.dart';

// Contains Widget builder for single grocery list item.
// Each grocery list item consists of the item and buttons to delete/update
class GroceryListItem extends StatelessWidget {
  GroceryListItem({
    super.key,
    required this.item,
  });

  final Item item;
  final TextEditingController _editItemTextFieldController =
                                    TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.itemText),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon for deleting Grocery List Item
          IconButton(
            onPressed: () {
              context.read<GroceryListBloc>().add(
                DeleteGroceryListItem(groceryListItem: this)
              );
            },
            icon: const Icon(Icons.delete, size: 28, color: Colors.red),
          ),
          // Icon for updating Grocery List Item
          IconButton(
            onPressed: () => _displayEditGroceryListItemDialog(context),
            icon: const Icon(Icons.edit, size: 28, color: Colors.green),
          ),
        ],
      ),
    );
  }

    // Display dialog box for editing current Grocery List Item
  Future<void> _displayEditGroceryListItemDialog(BuildContext contextArgument) async {
    // Populate edit text field using current item's text
    _editItemTextFieldController.text = item.itemText;

    return showDialog(
      context: contextArgument,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit item'),
          content: TextField(
            controller: _editItemTextFieldController,
            decoration: const InputDecoration(hintText: 'Edit item text'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Apply Changes'),
              onPressed: () {
                if (_editItemTextFieldController.text.isNotEmpty){
                  // Update Grocery List Item with new name and emit to BLoC handler
                  Navigator.of(context).pop();
                  GroceryListItem newGroceryListItem = GroceryListItem(
                    key: key,
                    item: Item(itemText: _editItemTextFieldController.text),
                  );
                  context.read<GroceryListBloc>().add(UpdateGroceryListItem(
                    groceryListItem: newGroceryListItem,
                  ));
                } else {
                  // Handle empty text field
                  displayEmptyFieldError(context);
                }
              },
            )
          ]
        );
      }
    );
  }
}