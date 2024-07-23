import 'package:flutter/material.dart';

// Display dialog stating empty text field
displayEmptyFieldError(BuildContext contextArgument) {
  return(
    showDialog(
      context: contextArgument,
      builder: (BuildContext context) => const AlertDialog(
        content: Text('Field must not be empty'),
      )
    )
  );
}