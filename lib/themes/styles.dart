import 'package:flutter/material.dart';

enum AppTheme {
  bg(color: Color(0xFF468432)),
  primary(color: Color(0xFF9AD872)),
  secondary(color: Color(0xFFFFEF91)),
  accent(color: Color(0xFFFFA02E));

  const AppTheme({required this.color});

  final Color color;
}
