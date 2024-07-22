import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:grocery_list/models/item.dart';
import 'package:grocery_list/grocery_list_widget/grocery_list_item.dart';

part 'grocery_list_event.dart';
part 'grocery_list_state.dart';

class GroceryListBloc extends Bloc<GroceryListEvent, GroceryListState> {
  GroceryListBloc() : super(GroceryListInitial(groceryListItems: [])) {
    // Register Events and Handlers
    on<AddGroceryListItem>(_addItem);
    on<DeleteGroceryListItem>(_deleteItem);
    on<UpdateGroceryListItem>(_updateItem);
  }

  void _addItem(AddGroceryListItem event, Emitter<GroceryListState> emit) {
    state.groceryListItems.add(event.groceryListItem);
    emit(GroceryListUpdated(groceryListItems: state.groceryListItems));
  }

  void _deleteItem(DeleteGroceryListItem event, Emitter<GroceryListState> emit) {
    state.groceryListItems.remove(event.groceryListItem);
    emit(GroceryListUpdated(groceryListItems: state.groceryListItems));
  }

  void _updateItem(UpdateGroceryListItem event, Emitter<GroceryListState> emit) {
    // TODO UPDATE ITEM
    emit(GroceryListUpdated(groceryListItems: state.groceryListItems));
  }
}
