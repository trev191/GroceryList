import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_list/blocs/grocery_list_bloc.dart';
import 'package:grocery_list/models/item.dart';

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
      title: Text(item.itemText),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              context.read<GroceryListBloc>().add(DeleteGroceryListItem(groceryListItem: this));
            },
            icon: const Icon(Icons.delete, size: 28, color: Colors.red),
          ),
          IconButton(
            onPressed: () {
              // TODO ADD IN FIELDS TO UPDATE
              context.read<GroceryListBloc>().add(UpdateGroceryListItem(groceryListItem: this));
            },
            icon: const Icon(Icons.edit, size: 28, color: Colors.green),
          ),
        ],
      ),
    );
  }
}