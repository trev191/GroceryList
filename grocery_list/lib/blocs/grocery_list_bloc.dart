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
    on<AddGroceryListItem>(_addGroceryListItem);
    on<DeleteGroceryListItem>(_deleteGroceryListItem);
    on<UpdateGroceryListItem>(_updateGroceryListItem);
  }

  void _addGroceryListItem(AddGroceryListItem event, Emitter<GroceryListState> emit) {
    state.groceryListItems.add(event.groceryListItem);
    emit(GroceryListUpdated(groceryListItems: state.groceryListItems));
  }

  void _deleteGroceryListItem(DeleteGroceryListItem event, Emitter<GroceryListState> emit) {
    state.groceryListItems.remove(event.groceryListItem);
    emit(GroceryListUpdated(groceryListItems: state.groceryListItems));
  }

  void _updateGroceryListItem(UpdateGroceryListItem event, Emitter<GroceryListState> emit) {
    for (int i = 0; i < state.groceryListItems.length; i++) {
      if (state.groceryListItems[i].key == event.groceryListItem.key) {
        state.groceryListItems[i] = event.groceryListItem;
        emit(GroceryListUpdated(groceryListItems: state.groceryListItems));
        return;
      }
    }
  }
}
