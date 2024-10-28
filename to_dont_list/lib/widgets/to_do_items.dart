import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/book.dart';
import 'package:to_dont_list/widgets/edit_book_dialog.dart';

typedef ToDoListChangedCallback = Function(Book item, bool completed);
typedef ToDoListRemovedCallback = Function(Book item);

class BookItem extends StatefulWidget {
  BookItem(
      {required this.item,
      required this.completed,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(item));

  final Book item;
  final bool completed;

  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return widget.completed //
        ? Colors.black
        : Theme.of(context).primaryColor;
  }

  // Changes the values of the book to the new ones input by user
  // Similar to the method in main that triggers todo dialog
  void _handleChangedValues(String newName, TextEditingController controller,
      double newProgress, bool isFiction) {
    setState(() {
      widget.item.name = newName;
      widget.item.progress = newProgress;
      widget.item.isFiction = isFiction;
    });
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!widget.completed) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          widget.item.increaseProgress();
        });
      },
      onLongPress: widget.completed
          ? () {
              setState(() {
                widget.onDeleteItem(widget.item);
              });
            }
          : null,
      // Added Icon next to progress indicator
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
              value: widget.item.progress,
              backgroundColor: Colors.black54,
              color: widget.item.isFiction == true ? Colors.red : Colors.green
              //child: Text(item.abbrev()),
              ),
          // When the icon is pressed it will open the edit book dialog
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return EditBookDialog(
                          onEditConfirmed: _handleChangedValues);
                    });
              },
              color: widget.item.isFiction == true ? Colors.red : Colors.green),
        ],
      ),
      title: Text(
        widget.item.name,
        style: _getTextStyle(context),
      ),
    );
  }
}
