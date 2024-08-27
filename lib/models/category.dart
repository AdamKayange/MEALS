import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    this.color = const Color.fromARGB(255, 241, 112, 6),
    required this.title,
  });
  final String id;
  final String title;
  final Color color;
}
