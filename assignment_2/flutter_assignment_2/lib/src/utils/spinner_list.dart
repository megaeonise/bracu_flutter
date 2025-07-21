import 'package:flutter/material.dart';

DropdownMenu<String> spinnerList(
  List<String> options,
  changeSelection,
  menuValue,
) {
  return DropdownMenu(
    dropdownMenuEntries: options.map((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList(),
    inputDecorationTheme: InputDecorationTheme(border: InputBorder.none),
    initialSelection: menuValue,
    onSelected: (value) => changeSelection(value!),
  );
}
