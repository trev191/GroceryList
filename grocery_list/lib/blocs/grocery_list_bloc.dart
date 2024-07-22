import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:grocery_list/models/item.dart';

part 'grocery_list_event.dart';
part 'grocery_list_state.dart';

class GroceryListBloc extends Bloc<GroceryListEvent, GroceryListState> {
  GroceryListBloc() : super(GroceryListInitial(items: [])) {
    on<AddItem>((event, emit) {
      state.items.add(Item(itemText: event.itemText));
      emit(GroceryListUpdated(items: state.items));
    });
  }
}
