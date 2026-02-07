import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  const SizeSelector({super.key});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int selectedSize = 0;
  final sizes = ['39', '40', '41', '42', '43', '44', '45'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          sizes.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(sizes[index]),
              selected: selectedSize == index,
              onSelected: (bool selected) {
                selectedSize = selected ? index : selectedSize;
                setState(() {});
              },
              selectedColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(
                color: selectedSize == index ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
