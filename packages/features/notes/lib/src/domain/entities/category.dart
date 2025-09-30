import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String color;
  final String? icon;
  final DateTime createdAt;
  final int sortOrder;

  const Category({
    required this.id,
    required this.name,
    required this.color,
    this.icon,
    required this.createdAt,
    required this.sortOrder,
  });

  Category copyWith({
    int? id,
    String? name,
    String? color,
    String? icon,
    DateTime? createdAt,
    int? sortOrder,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  List<Object?> get props => [id, name, color, icon, createdAt, sortOrder];
}
