part of 'grocery_list_bloc.dart';

@immutable
sealed class GroceryListEvent {}

class AddItem extends GroceryListEvent {
  final String itemText;

  AddItem({required this.itemText});
}
