part of 'grocery_list_bloc.dart';

sealed class GroceryListState {
  List<Item> items = <Item>[];
  GroceryListState({required this.items});
}

final class GroceryListInitial extends GroceryListState {
  GroceryListInitial({required super.items});
}

final class GroceryListUpdated extends GroceryListState {
  GroceryListUpdated({required super.items});
}