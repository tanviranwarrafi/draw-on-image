import 'package:flutter/material.dart';
import 'package:tutorial/themes/colors.dart';

const _POINTER_COLORS = [black, error, amber, info, green, teal];

class WrapColorsList extends StatelessWidget {
  final Color selectedItem;
  final Function(Color) onSelect;
  WrapColorsList({required this.selectedItem, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 06, runSpacing: 10, children: List.generate(_POINTER_COLORS.length, _colorItemCard).toList());
  }

  Widget _colorItemCard(int index) {
    var color = _POINTER_COLORS[index];
    var selected = color == selectedItem;
    return InkWell(
      onTap: () => onSelect(color),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: !selected ? null : Border.all(color: white, width: 2, strokeAlign: BorderSide.strokeAlignOutside),
        ),
      ),
    );
  }
}
