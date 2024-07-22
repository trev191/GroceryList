
import 'package:flutter/material.dart';
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
      title: Text(item.itemText)
    );
  }
}