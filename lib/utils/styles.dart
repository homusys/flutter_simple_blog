import 'package:flutter/material.dart';

const colorBg = 0xFF468432;
const colorPrimary = 0xFF9AD872;
const colorSecondary = 0xFFFFEF91;
const colorAccent = 0xFFFFA02E;

enum AppColors {
  bg(color: Color(colorBg)),
  primary(color: Color(colorPrimary)),
  secondary(color: Color(colorSecondary)),
  accent(color: Color(colorAccent));

  const AppColors({required this.color});

  final Color color;
}
