part of 'grocery_list_bloc.dart';

sealed class GroceryListState {
  List<GroceryListItem> groceryListItems = <GroceryListItem>[];
  GroceryListState({required this.groceryListItems});
}

final class GroceryListInitial extends GroceryListState {
  GroceryListInitial({required super.groceryListItems});
}

final class GroceryListUpdated extends GroceryListState {
  GroceryListUpdated({required super.groceryListItems});
}