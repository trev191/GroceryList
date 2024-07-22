import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_list/blocs/grocery_list_bloc.dart';
import 'package:grocery_list/models/item.dart';

// Contains Widget builder for single grocery list item.
// Each grocery list item consists of the item and buttons to delete/update
class GroceryListItem extends StatelessWidget {
  const GroceryListItem({
    super.key,
    required this.item,
  });

  final Item item;

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
            onPressed: () {
              // TODO ADD IN FIELDS FROM DIALOG BOX TO UPDATE
              // Currently hardcoded to update the item field name when button is clicked
              GroceryListItem newGroceryListItem = GroceryListItem(key: this.key, item: this.item);
              newGroceryListItem.item.itemText = 'UPDATED';

              context.read<GroceryListBloc>().add(UpdateGroceryListItem(
                groceryListItem: newGroceryListItem,
              ));
            },
            icon: const Icon(Icons.edit, size: 28, color: Colors.green),
          ),
        ],
      ),
    );
  }
}