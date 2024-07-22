part of 'grocery_list_bloc.dart';

@immutable
sealed class GroceryListEvent {}

class AddGroceryListItem extends GroceryListEvent {
  final GroceryListItem groceryListItem;

  AddGroceryListItem({required this.groceryListItem});
}

class DeleteGroceryListItem extends GroceryListEvent {
  final GroceryListItem groceryListItem;

  DeleteGroceryListItem({required this.groceryListItem});
}

class UpdateGroceryListItem extends GroceryListEvent {
  final GroceryListItem groceryListItem;

  UpdateGroceryListItem({required this.groceryListItem});
}