import 'package:flutter/material.dart';

typedef BookEditedCallback = Function(String value,
    TextEditingController textConroller, double sliderValue, bool switchValue);

class EditBookDialog extends StatefulWidget {
  const EditBookDialog({
    super.key,
    required this.onEditConfirmed,
  });

  final BookEditedCallback onEditConfirmed;

  @override
  State<EditBookDialog> createState() => _EditBookDialogState();
}

class _EditBookDialogState extends State<EditBookDialog> {
  final TextEditingController _inputController = TextEditingController();
  final ButtonStyle fictionStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);
  final ButtonStyle nonFictionStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);

  String valueText = "";
  double sliderValue = .0;
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Book'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: _inputController,
            decoration: const InputDecoration(hintText: "enter new name"),
          ),
          Slider(
            min: 0,
            max: 1,
            value: sliderValue,
            onChanged: (double value) {
              setState(() {
                sliderValue = value;
              });
            },
          ),
          SwitchListTile(
              value: switchValue,
              onChanged: (bool value) {
                setState(() {
                  switchValue = value;
                });
              },
              title: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Is your book ',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                    TextSpan(
                        text: 'Fiction', style: TextStyle(color: Colors.red)),
                    TextSpan(
                        text: ' or ',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                    TextSpan(
                        text: 'Non-Fiction',
                        style: TextStyle(color: Colors.green)),
                    TextSpan(
                        text: ' ?',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)))
                  ],
                ),
              )),
        ],
      ),
      actions: <Widget>[
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: nonFictionStyle,
              onPressed: value.text.isNotEmpty
                  ? () {
                      setState(() {
                        widget.onEditConfirmed(valueText, _inputController,
                            sliderValue, !switchValue);
                        Navigator.pop(context);
                      });
                    }
                  : null,
              child: const Text('OK'),
            );
          },
        ),
        ElevatedButton(
          key: const Key("CancelButton"),
          style: fictionStyle,
          child: const Text('Cancel'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
      ],
    );
  }
}
