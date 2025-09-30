import 'package:database/database.dart' as db;

import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.color,
    super.icon,
    required super.createdAt,
    required super.sortOrder,
  });

  /// Convert from Drift Category to CategoryModel
  factory CategoryModel.fromDrift(db.Category driftCategory) {
    return CategoryModel(
      id: driftCategory.id,
      name: driftCategory.name,
      color: driftCategory.color,
      icon: driftCategory.icon,
      createdAt: driftCategory.createdAt,
      sortOrder: driftCategory.sortOrder,
    );
  }

  /// Convert CategoryModel to Category entity
  Category toEntity() {
    return Category(
      id: id,
      name: name,
      color: color,
      icon: icon,
      createdAt: createdAt,
      sortOrder: sortOrder,
    );
  }
}
