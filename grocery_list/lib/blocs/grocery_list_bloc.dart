import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:grocery_list/grocery_list_widget/grocery_list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'grocery_list_event.dart';
part 'grocery_list_state.dart';

// Make call to shared preferences for grocery list items state and
// convert it back to List<GroceryListItem>
Future<List<GroceryListItem>> _retrieveGroceryListItemsFromDisk() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  const jsonDecoder = JsonDecoder();
  String? groceryListItemsFromPrefs = prefs.getString('groceryListItems');

  // Found entry from shared preferences
  if (groceryListItemsFromPrefs != null) {    
    // Convert JSON string to List<Map<String, dynamic>>
    List<dynamic> groceryListItemsMap = jsonDecoder.convert(groceryListItemsFromPrefs);

    // Convert List<Map<String, dynamic>> to List<GroceryListItem>
    List<GroceryListItem> groceryListItems = groceryListItemsMap
        .map((json) => GroceryListItem.fromJson(json))
        .toList();

    return groceryListItems;
  } else {
    // No grocery list entry in shared preferences
    return [];
  }
}

// Save grocery list items state to disk via shared_preferences
void _storeGroceryListItemsToDisk(List<GroceryListItem> groceryListItems) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  const jsonEncoder = JsonEncoder();

  // Convert List<GroceryListItem> to JSON String
  String groceryListItemsString = jsonEncoder.convert(groceryListItems);
  prefs.setString('groceryListItems', groceryListItemsString);
}

class GroceryListBloc extends Bloc<GroceryListEvent, GroceryListState> {
  GroceryListBloc() : super(GroceryListInitial(groceryListItems: [])) {
    // Register Events and Handlers
    on<InitGroceryListItems>(_initGroceryListItems);
    on<AddGroceryListItem>(_addGroceryListItem);
    on<DeleteGroceryListItem>(_deleteGroceryListItem);
    on<UpdateGroceryListItem>(_updateGroceryListItem);
  }

  // Grab persisted data from disk
  void _initGroceryListItems(InitGroceryListItems event, Emitter<GroceryListState> emit) async {
    state.groceryListItems = await _retrieveGroceryListItemsFromDisk();
    emit(GroceryListInitial(groceryListItems: state.groceryListItems));
  }

  // Add new grocery list item, emit update, and save to disk
  void _addGroceryListItem(AddGroceryListItem event, Emitter<GroceryListState> emit) {
    state.groceryListItems.add(event.groceryListItem);
    emit(GroceryListUpdated(groceryListItems: state.groceryListItems));
    _storeGroceryListItemsToDisk(state.groceryListItems);
  }

  // Delete grocery list item, emit update, and save to disk
  void _deleteGroceryListItem(DeleteGroceryListItem event, Emitter<GroceryListState> emit) {
    state.groceryListItems.remove(event.groceryListItem);
    emit(GroceryListUpdated(groceryListItems: state.groceryListItems));
    _storeGroceryListItemsToDisk(state.groceryListItems);
  }

  // Update existing grocery list item, emit update, and save to disk
  void _updateGroceryListItem(UpdateGroceryListItem event, Emitter<GroceryListState> emit) {
    for (int i = 0; i < state.groceryListItems.length; i++) {
      if (state.groceryListItems[i].key == event.groceryListItem.key) {
        state.groceryListItems[i] = event.groceryListItem;
        emit(GroceryListUpdated(groceryListItems: state.groceryListItems));
        _storeGroceryListItemsToDisk(state.groceryListItems);
        return;
      }
    }
  }
}
