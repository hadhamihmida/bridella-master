import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key? key,
    this.maxLines = 1,
    required this.label,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  TextFieldWidgetState createState() => TextFieldWidgetState();
}

class TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),

           TextField(
  decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
      borderRadius: BorderRadius.circular(50.0),
    ),
     focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Color.fromARGB(255, 207, 53, 176)),
                  borderRadius: BorderRadius.circular(15),),
  ),
           


          // TextField(
          //   controller: controller,
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //   ),
            maxLines: widget.maxLines,
          ),
        ],
      );
}
// TextField(
//   decoration: InputDecoration(
//     enabledBorder: OutlineInputBorder(
//       borderSide:
//           BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
//       borderRadius: BorderRadius.circular(50.0),
//     ),
//   ),
// )