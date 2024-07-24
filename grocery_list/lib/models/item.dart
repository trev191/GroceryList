// Basic class for single grocery list item
class Item {
  Item({
    required this.itemText,
  });

  String itemText;

  // Convert object to JSON-encodable map
  Map<String, dynamic> toJson() {
    return {
      'itemText': itemText,
    };
  }
}