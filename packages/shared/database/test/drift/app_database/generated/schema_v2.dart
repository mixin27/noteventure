// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class Categories extends Table with TableInfo<Categories, CategoriesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Categories(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    color,
    icon,
    createdAt,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoriesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriesData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  Categories createAlias(String alias) {
    return Categories(attachedDatabase, alias);
  }
}

class CategoriesData extends DataClass implements Insertable<CategoriesData> {
  final String id;
  final String name;
  final String color;
  final String? icon;
  final DateTime createdAt;
  final int sortOrder;
  const CategoriesData({
    required this.id,
    required this.name,
    required this.color,
    this.icon,
    required this.createdAt,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['color'] = Variable<String>(color);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      color: Value(color),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      createdAt: Value(createdAt),
      sortOrder: Value(sortOrder),
    );
  }

  factory CategoriesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriesData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String>(json['color']),
      icon: serializer.fromJson<String?>(json['icon']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String>(color),
      'icon': serializer.toJson<String?>(icon),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  CategoriesData copyWith({
    String? id,
    String? name,
    String? color,
    Value<String?> icon = const Value.absent(),
    DateTime? createdAt,
    int? sortOrder,
  }) => CategoriesData(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color ?? this.color,
    icon: icon.present ? icon.value : this.icon,
    createdAt: createdAt ?? this.createdAt,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  CategoriesData copyWithCompanion(CategoriesCompanion data) {
    return CategoriesData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      icon: data.icon.present ? data.icon.value : this.icon,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('createdAt: $createdAt, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color, icon, createdAt, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriesData &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.icon == this.icon &&
          other.createdAt == this.createdAt &&
          other.sortOrder == this.sortOrder);
}

class CategoriesCompanion extends UpdateCompanion<CategoriesData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> color;
  final Value<String?> icon;
  final Value<DateTime> createdAt;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    required String color,
    this.icon = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       color = Value(color);
  static Insertable<CategoriesData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? color,
    Expression<String>? icon,
    Expression<DateTime>? createdAt,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      if (createdAt != null) 'created_at': createdAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? color,
    Value<String?>? icon,
    Value<DateTime>? createdAt,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('createdAt: $createdAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Notes extends Table with TableInfo<Notes, NotesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Notes(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<int> editCount = GeneratedColumn<int>(
    'edit_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<String> noteType = GeneratedColumn<String>(
    'note_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('\'standard\''),
  );
  late final GeneratedColumn<bool> isLocked = GeneratedColumn<bool>(
    'is_locked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_locked" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<DateTime> unlockDate = GeneratedColumn<DateTime>(
    'unlock_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE SET NULL',
    ),
  );
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>(
    'is_pinned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pinned" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> requiredChallengeLevel = GeneratedColumn<int>(
    'required_challenge_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<String> serverUuid = GeneratedColumn<String>(
    'server_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    content,
    createdAt,
    updatedAt,
    editCount,
    noteType,
    isLocked,
    unlockDate,
    categoryId,
    sortOrder,
    color,
    isPinned,
    isFavorite,
    requiredChallengeLevel,
    isDeleted,
    deletedAt,
    serverUuid,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotesData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      editCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}edit_count'],
      )!,
      noteType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note_type'],
      )!,
      isLocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_locked'],
      )!,
      unlockDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlock_date'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      isPinned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pinned'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      requiredChallengeLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}required_challenge_level'],
      ),
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      serverUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_uuid'],
      ),
    );
  }

  @override
  Notes createAlias(String alias) {
    return Notes(attachedDatabase, alias);
  }
}

class NotesData extends DataClass implements Insertable<NotesData> {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int editCount;
  final String noteType;
  final bool isLocked;
  final DateTime? unlockDate;
  final String? categoryId;
  final int sortOrder;
  final String? color;
  final bool isPinned;
  final bool isFavorite;
  final int? requiredChallengeLevel;
  final bool isDeleted;
  final DateTime? deletedAt;
  final String? serverUuid;
  const NotesData({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.editCount,
    required this.noteType,
    required this.isLocked,
    this.unlockDate,
    this.categoryId,
    required this.sortOrder,
    this.color,
    required this.isPinned,
    required this.isFavorite,
    this.requiredChallengeLevel,
    required this.isDeleted,
    this.deletedAt,
    this.serverUuid,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['edit_count'] = Variable<int>(editCount);
    map['note_type'] = Variable<String>(noteType);
    map['is_locked'] = Variable<bool>(isLocked);
    if (!nullToAbsent || unlockDate != null) {
      map['unlock_date'] = Variable<DateTime>(unlockDate);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['is_pinned'] = Variable<bool>(isPinned);
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || requiredChallengeLevel != null) {
      map['required_challenge_level'] = Variable<int>(requiredChallengeLevel);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || serverUuid != null) {
      map['server_uuid'] = Variable<String>(serverUuid);
    }
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      editCount: Value(editCount),
      noteType: Value(noteType),
      isLocked: Value(isLocked),
      unlockDate: unlockDate == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockDate),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      sortOrder: Value(sortOrder),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      isPinned: Value(isPinned),
      isFavorite: Value(isFavorite),
      requiredChallengeLevel: requiredChallengeLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(requiredChallengeLevel),
      isDeleted: Value(isDeleted),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverUuid: serverUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUuid),
    );
  }

  factory NotesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotesData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      editCount: serializer.fromJson<int>(json['editCount']),
      noteType: serializer.fromJson<String>(json['noteType']),
      isLocked: serializer.fromJson<bool>(json['isLocked']),
      unlockDate: serializer.fromJson<DateTime?>(json['unlockDate']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      color: serializer.fromJson<String?>(json['color']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      requiredChallengeLevel: serializer.fromJson<int?>(
        json['requiredChallengeLevel'],
      ),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      serverUuid: serializer.fromJson<String?>(json['serverUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'editCount': serializer.toJson<int>(editCount),
      'noteType': serializer.toJson<String>(noteType),
      'isLocked': serializer.toJson<bool>(isLocked),
      'unlockDate': serializer.toJson<DateTime?>(unlockDate),
      'categoryId': serializer.toJson<String?>(categoryId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'color': serializer.toJson<String?>(color),
      'isPinned': serializer.toJson<bool>(isPinned),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'requiredChallengeLevel': serializer.toJson<int?>(requiredChallengeLevel),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'serverUuid': serializer.toJson<String?>(serverUuid),
    };
  }

  NotesData copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? editCount,
    String? noteType,
    bool? isLocked,
    Value<DateTime?> unlockDate = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    int? sortOrder,
    Value<String?> color = const Value.absent(),
    bool? isPinned,
    bool? isFavorite,
    Value<int?> requiredChallengeLevel = const Value.absent(),
    bool? isDeleted,
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<String?> serverUuid = const Value.absent(),
  }) => NotesData(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    editCount: editCount ?? this.editCount,
    noteType: noteType ?? this.noteType,
    isLocked: isLocked ?? this.isLocked,
    unlockDate: unlockDate.present ? unlockDate.value : this.unlockDate,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    sortOrder: sortOrder ?? this.sortOrder,
    color: color.present ? color.value : this.color,
    isPinned: isPinned ?? this.isPinned,
    isFavorite: isFavorite ?? this.isFavorite,
    requiredChallengeLevel: requiredChallengeLevel.present
        ? requiredChallengeLevel.value
        : this.requiredChallengeLevel,
    isDeleted: isDeleted ?? this.isDeleted,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverUuid: serverUuid.present ? serverUuid.value : this.serverUuid,
  );
  NotesData copyWithCompanion(NotesCompanion data) {
    return NotesData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      editCount: data.editCount.present ? data.editCount.value : this.editCount,
      noteType: data.noteType.present ? data.noteType.value : this.noteType,
      isLocked: data.isLocked.present ? data.isLocked.value : this.isLocked,
      unlockDate: data.unlockDate.present
          ? data.unlockDate.value
          : this.unlockDate,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      color: data.color.present ? data.color.value : this.color,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      requiredChallengeLevel: data.requiredChallengeLevel.present
          ? data.requiredChallengeLevel.value
          : this.requiredChallengeLevel,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverUuid: data.serverUuid.present
          ? data.serverUuid.value
          : this.serverUuid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotesData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('editCount: $editCount, ')
          ..write('noteType: $noteType, ')
          ..write('isLocked: $isLocked, ')
          ..write('unlockDate: $unlockDate, ')
          ..write('categoryId: $categoryId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('color: $color, ')
          ..write('isPinned: $isPinned, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('requiredChallengeLevel: $requiredChallengeLevel, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverUuid: $serverUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    content,
    createdAt,
    updatedAt,
    editCount,
    noteType,
    isLocked,
    unlockDate,
    categoryId,
    sortOrder,
    color,
    isPinned,
    isFavorite,
    requiredChallengeLevel,
    isDeleted,
    deletedAt,
    serverUuid,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotesData &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.editCount == this.editCount &&
          other.noteType == this.noteType &&
          other.isLocked == this.isLocked &&
          other.unlockDate == this.unlockDate &&
          other.categoryId == this.categoryId &&
          other.sortOrder == this.sortOrder &&
          other.color == this.color &&
          other.isPinned == this.isPinned &&
          other.isFavorite == this.isFavorite &&
          other.requiredChallengeLevel == this.requiredChallengeLevel &&
          other.isDeleted == this.isDeleted &&
          other.deletedAt == this.deletedAt &&
          other.serverUuid == this.serverUuid);
}

class NotesCompanion extends UpdateCompanion<NotesData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> content;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> editCount;
  final Value<String> noteType;
  final Value<bool> isLocked;
  final Value<DateTime?> unlockDate;
  final Value<String?> categoryId;
  final Value<int> sortOrder;
  final Value<String?> color;
  final Value<bool> isPinned;
  final Value<bool> isFavorite;
  final Value<int?> requiredChallengeLevel;
  final Value<bool> isDeleted;
  final Value<DateTime?> deletedAt;
  final Value<String?> serverUuid;
  final Value<int> rowid;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.editCount = const Value.absent(),
    this.noteType = const Value.absent(),
    this.isLocked = const Value.absent(),
    this.unlockDate = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.color = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.requiredChallengeLevel = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    required String id,
    required String title,
    required String content,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.editCount = const Value.absent(),
    this.noteType = const Value.absent(),
    this.isLocked = const Value.absent(),
    this.unlockDate = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.color = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.requiredChallengeLevel = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       content = Value(content);
  static Insertable<NotesData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? editCount,
    Expression<String>? noteType,
    Expression<bool>? isLocked,
    Expression<DateTime>? unlockDate,
    Expression<String>? categoryId,
    Expression<int>? sortOrder,
    Expression<String>? color,
    Expression<bool>? isPinned,
    Expression<bool>? isFavorite,
    Expression<int>? requiredChallengeLevel,
    Expression<bool>? isDeleted,
    Expression<DateTime>? deletedAt,
    Expression<String>? serverUuid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (editCount != null) 'edit_count': editCount,
      if (noteType != null) 'note_type': noteType,
      if (isLocked != null) 'is_locked': isLocked,
      if (unlockDate != null) 'unlock_date': unlockDate,
      if (categoryId != null) 'category_id': categoryId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (color != null) 'color': color,
      if (isPinned != null) 'is_pinned': isPinned,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (requiredChallengeLevel != null)
        'required_challenge_level': requiredChallengeLevel,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverUuid != null) 'server_uuid': serverUuid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? content,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? editCount,
    Value<String>? noteType,
    Value<bool>? isLocked,
    Value<DateTime?>? unlockDate,
    Value<String?>? categoryId,
    Value<int>? sortOrder,
    Value<String?>? color,
    Value<bool>? isPinned,
    Value<bool>? isFavorite,
    Value<int?>? requiredChallengeLevel,
    Value<bool>? isDeleted,
    Value<DateTime?>? deletedAt,
    Value<String?>? serverUuid,
    Value<int>? rowid,
  }) {
    return NotesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      editCount: editCount ?? this.editCount,
      noteType: noteType ?? this.noteType,
      isLocked: isLocked ?? this.isLocked,
      unlockDate: unlockDate ?? this.unlockDate,
      categoryId: categoryId ?? this.categoryId,
      sortOrder: sortOrder ?? this.sortOrder,
      color: color ?? this.color,
      isPinned: isPinned ?? this.isPinned,
      isFavorite: isFavorite ?? this.isFavorite,
      requiredChallengeLevel:
          requiredChallengeLevel ?? this.requiredChallengeLevel,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
      serverUuid: serverUuid ?? this.serverUuid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (editCount.present) {
      map['edit_count'] = Variable<int>(editCount.value);
    }
    if (noteType.present) {
      map['note_type'] = Variable<String>(noteType.value);
    }
    if (isLocked.present) {
      map['is_locked'] = Variable<bool>(isLocked.value);
    }
    if (unlockDate.present) {
      map['unlock_date'] = Variable<DateTime>(unlockDate.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (requiredChallengeLevel.present) {
      map['required_challenge_level'] = Variable<int>(
        requiredChallengeLevel.value,
      );
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (serverUuid.present) {
      map['server_uuid'] = Variable<String>(serverUuid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('editCount: $editCount, ')
          ..write('noteType: $noteType, ')
          ..write('isLocked: $isLocked, ')
          ..write('unlockDate: $unlockDate, ')
          ..write('categoryId: $categoryId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('color: $color, ')
          ..write('isPinned: $isPinned, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('requiredChallengeLevel: $requiredChallengeLevel, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverUuid: $serverUuid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ChallengeHistory extends Table
    with TableInfo<ChallengeHistory, ChallengeHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ChallengeHistory(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> challengeType = GeneratedColumn<String>(
    'challenge_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> difficultyLevel = GeneratedColumn<int>(
    'difficulty_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> correctAnswer = GeneratedColumn<String>(
    'correct_answer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> userAnswer = GeneratedColumn<String>(
    'user_answer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<bool> wasCorrect = GeneratedColumn<bool>(
    'was_correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("was_correct" IN (0, 1))',
    ),
  );
  late final GeneratedColumn<int> pointsEarned = GeneratedColumn<int>(
    'points_earned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> xpEarned = GeneratedColumn<int>(
    'xp_earned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> timeSpentSeconds = GeneratedColumn<int>(
    'time_spent_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<int> timeLimitSeconds = GeneratedColumn<int>(
    'time_limit_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<bool> wasDoubleOrNothing = GeneratedColumn<bool>(
    'was_double_or_nothing',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("was_double_or_nothing" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<bool> wasPartOfStreak = GeneratedColumn<bool>(
    'was_part_of_streak',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("was_part_of_streak" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<String> triggerReason = GeneratedColumn<String>(
    'trigger_reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> relatedNoteId = GeneratedColumn<int>(
    'related_note_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES notes (id) ON DELETE SET NULL',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    challengeType,
    difficulty,
    difficultyLevel,
    question,
    correctAnswer,
    userAnswer,
    wasCorrect,
    pointsEarned,
    xpEarned,
    timeSpentSeconds,
    timeLimitSeconds,
    wasDoubleOrNothing,
    wasPartOfStreak,
    completedAt,
    triggerReason,
    relatedNoteId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'challenge_history';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChallengeHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChallengeHistoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      challengeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}challenge_type'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      difficultyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}difficulty_level'],
      )!,
      question: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question'],
      )!,
      correctAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}correct_answer'],
      )!,
      userAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_answer'],
      ),
      wasCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}was_correct'],
      )!,
      pointsEarned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points_earned'],
      )!,
      xpEarned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_earned'],
      )!,
      timeSpentSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_spent_seconds'],
      ),
      timeLimitSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_limit_seconds'],
      ),
      wasDoubleOrNothing: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}was_double_or_nothing'],
      )!,
      wasPartOfStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}was_part_of_streak'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
      triggerReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger_reason'],
      )!,
      relatedNoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}related_note_id'],
      ),
    );
  }

  @override
  ChallengeHistory createAlias(String alias) {
    return ChallengeHistory(attachedDatabase, alias);
  }
}

class ChallengeHistoryData extends DataClass
    implements Insertable<ChallengeHistoryData> {
  final String id;
  final String challengeType;
  final String difficulty;
  final int difficultyLevel;
  final String question;
  final String correctAnswer;
  final String? userAnswer;
  final bool wasCorrect;
  final int pointsEarned;
  final int xpEarned;
  final int? timeSpentSeconds;
  final int? timeLimitSeconds;
  final bool wasDoubleOrNothing;
  final bool wasPartOfStreak;
  final DateTime completedAt;
  final String triggerReason;
  final int? relatedNoteId;
  const ChallengeHistoryData({
    required this.id,
    required this.challengeType,
    required this.difficulty,
    required this.difficultyLevel,
    required this.question,
    required this.correctAnswer,
    this.userAnswer,
    required this.wasCorrect,
    required this.pointsEarned,
    required this.xpEarned,
    this.timeSpentSeconds,
    this.timeLimitSeconds,
    required this.wasDoubleOrNothing,
    required this.wasPartOfStreak,
    required this.completedAt,
    required this.triggerReason,
    this.relatedNoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['challenge_type'] = Variable<String>(challengeType);
    map['difficulty'] = Variable<String>(difficulty);
    map['difficulty_level'] = Variable<int>(difficultyLevel);
    map['question'] = Variable<String>(question);
    map['correct_answer'] = Variable<String>(correctAnswer);
    if (!nullToAbsent || userAnswer != null) {
      map['user_answer'] = Variable<String>(userAnswer);
    }
    map['was_correct'] = Variable<bool>(wasCorrect);
    map['points_earned'] = Variable<int>(pointsEarned);
    map['xp_earned'] = Variable<int>(xpEarned);
    if (!nullToAbsent || timeSpentSeconds != null) {
      map['time_spent_seconds'] = Variable<int>(timeSpentSeconds);
    }
    if (!nullToAbsent || timeLimitSeconds != null) {
      map['time_limit_seconds'] = Variable<int>(timeLimitSeconds);
    }
    map['was_double_or_nothing'] = Variable<bool>(wasDoubleOrNothing);
    map['was_part_of_streak'] = Variable<bool>(wasPartOfStreak);
    map['completed_at'] = Variable<DateTime>(completedAt);
    map['trigger_reason'] = Variable<String>(triggerReason);
    if (!nullToAbsent || relatedNoteId != null) {
      map['related_note_id'] = Variable<int>(relatedNoteId);
    }
    return map;
  }

  ChallengeHistoryCompanion toCompanion(bool nullToAbsent) {
    return ChallengeHistoryCompanion(
      id: Value(id),
      challengeType: Value(challengeType),
      difficulty: Value(difficulty),
      difficultyLevel: Value(difficultyLevel),
      question: Value(question),
      correctAnswer: Value(correctAnswer),
      userAnswer: userAnswer == null && nullToAbsent
          ? const Value.absent()
          : Value(userAnswer),
      wasCorrect: Value(wasCorrect),
      pointsEarned: Value(pointsEarned),
      xpEarned: Value(xpEarned),
      timeSpentSeconds: timeSpentSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(timeSpentSeconds),
      timeLimitSeconds: timeLimitSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(timeLimitSeconds),
      wasDoubleOrNothing: Value(wasDoubleOrNothing),
      wasPartOfStreak: Value(wasPartOfStreak),
      completedAt: Value(completedAt),
      triggerReason: Value(triggerReason),
      relatedNoteId: relatedNoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedNoteId),
    );
  }

  factory ChallengeHistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChallengeHistoryData(
      id: serializer.fromJson<String>(json['id']),
      challengeType: serializer.fromJson<String>(json['challengeType']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      difficultyLevel: serializer.fromJson<int>(json['difficultyLevel']),
      question: serializer.fromJson<String>(json['question']),
      correctAnswer: serializer.fromJson<String>(json['correctAnswer']),
      userAnswer: serializer.fromJson<String?>(json['userAnswer']),
      wasCorrect: serializer.fromJson<bool>(json['wasCorrect']),
      pointsEarned: serializer.fromJson<int>(json['pointsEarned']),
      xpEarned: serializer.fromJson<int>(json['xpEarned']),
      timeSpentSeconds: serializer.fromJson<int?>(json['timeSpentSeconds']),
      timeLimitSeconds: serializer.fromJson<int?>(json['timeLimitSeconds']),
      wasDoubleOrNothing: serializer.fromJson<bool>(json['wasDoubleOrNothing']),
      wasPartOfStreak: serializer.fromJson<bool>(json['wasPartOfStreak']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      triggerReason: serializer.fromJson<String>(json['triggerReason']),
      relatedNoteId: serializer.fromJson<int?>(json['relatedNoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'challengeType': serializer.toJson<String>(challengeType),
      'difficulty': serializer.toJson<String>(difficulty),
      'difficultyLevel': serializer.toJson<int>(difficultyLevel),
      'question': serializer.toJson<String>(question),
      'correctAnswer': serializer.toJson<String>(correctAnswer),
      'userAnswer': serializer.toJson<String?>(userAnswer),
      'wasCorrect': serializer.toJson<bool>(wasCorrect),
      'pointsEarned': serializer.toJson<int>(pointsEarned),
      'xpEarned': serializer.toJson<int>(xpEarned),
      'timeSpentSeconds': serializer.toJson<int?>(timeSpentSeconds),
      'timeLimitSeconds': serializer.toJson<int?>(timeLimitSeconds),
      'wasDoubleOrNothing': serializer.toJson<bool>(wasDoubleOrNothing),
      'wasPartOfStreak': serializer.toJson<bool>(wasPartOfStreak),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'triggerReason': serializer.toJson<String>(triggerReason),
      'relatedNoteId': serializer.toJson<int?>(relatedNoteId),
    };
  }

  ChallengeHistoryData copyWith({
    String? id,
    String? challengeType,
    String? difficulty,
    int? difficultyLevel,
    String? question,
    String? correctAnswer,
    Value<String?> userAnswer = const Value.absent(),
    bool? wasCorrect,
    int? pointsEarned,
    int? xpEarned,
    Value<int?> timeSpentSeconds = const Value.absent(),
    Value<int?> timeLimitSeconds = const Value.absent(),
    bool? wasDoubleOrNothing,
    bool? wasPartOfStreak,
    DateTime? completedAt,
    String? triggerReason,
    Value<int?> relatedNoteId = const Value.absent(),
  }) => ChallengeHistoryData(
    id: id ?? this.id,
    challengeType: challengeType ?? this.challengeType,
    difficulty: difficulty ?? this.difficulty,
    difficultyLevel: difficultyLevel ?? this.difficultyLevel,
    question: question ?? this.question,
    correctAnswer: correctAnswer ?? this.correctAnswer,
    userAnswer: userAnswer.present ? userAnswer.value : this.userAnswer,
    wasCorrect: wasCorrect ?? this.wasCorrect,
    pointsEarned: pointsEarned ?? this.pointsEarned,
    xpEarned: xpEarned ?? this.xpEarned,
    timeSpentSeconds: timeSpentSeconds.present
        ? timeSpentSeconds.value
        : this.timeSpentSeconds,
    timeLimitSeconds: timeLimitSeconds.present
        ? timeLimitSeconds.value
        : this.timeLimitSeconds,
    wasDoubleOrNothing: wasDoubleOrNothing ?? this.wasDoubleOrNothing,
    wasPartOfStreak: wasPartOfStreak ?? this.wasPartOfStreak,
    completedAt: completedAt ?? this.completedAt,
    triggerReason: triggerReason ?? this.triggerReason,
    relatedNoteId: relatedNoteId.present
        ? relatedNoteId.value
        : this.relatedNoteId,
  );
  ChallengeHistoryData copyWithCompanion(ChallengeHistoryCompanion data) {
    return ChallengeHistoryData(
      id: data.id.present ? data.id.value : this.id,
      challengeType: data.challengeType.present
          ? data.challengeType.value
          : this.challengeType,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      difficultyLevel: data.difficultyLevel.present
          ? data.difficultyLevel.value
          : this.difficultyLevel,
      question: data.question.present ? data.question.value : this.question,
      correctAnswer: data.correctAnswer.present
          ? data.correctAnswer.value
          : this.correctAnswer,
      userAnswer: data.userAnswer.present
          ? data.userAnswer.value
          : this.userAnswer,
      wasCorrect: data.wasCorrect.present
          ? data.wasCorrect.value
          : this.wasCorrect,
      pointsEarned: data.pointsEarned.present
          ? data.pointsEarned.value
          : this.pointsEarned,
      xpEarned: data.xpEarned.present ? data.xpEarned.value : this.xpEarned,
      timeSpentSeconds: data.timeSpentSeconds.present
          ? data.timeSpentSeconds.value
          : this.timeSpentSeconds,
      timeLimitSeconds: data.timeLimitSeconds.present
          ? data.timeLimitSeconds.value
          : this.timeLimitSeconds,
      wasDoubleOrNothing: data.wasDoubleOrNothing.present
          ? data.wasDoubleOrNothing.value
          : this.wasDoubleOrNothing,
      wasPartOfStreak: data.wasPartOfStreak.present
          ? data.wasPartOfStreak.value
          : this.wasPartOfStreak,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      triggerReason: data.triggerReason.present
          ? data.triggerReason.value
          : this.triggerReason,
      relatedNoteId: data.relatedNoteId.present
          ? data.relatedNoteId.value
          : this.relatedNoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChallengeHistoryData(')
          ..write('id: $id, ')
          ..write('challengeType: $challengeType, ')
          ..write('difficulty: $difficulty, ')
          ..write('difficultyLevel: $difficultyLevel, ')
          ..write('question: $question, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('userAnswer: $userAnswer, ')
          ..write('wasCorrect: $wasCorrect, ')
          ..write('pointsEarned: $pointsEarned, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('timeSpentSeconds: $timeSpentSeconds, ')
          ..write('timeLimitSeconds: $timeLimitSeconds, ')
          ..write('wasDoubleOrNothing: $wasDoubleOrNothing, ')
          ..write('wasPartOfStreak: $wasPartOfStreak, ')
          ..write('completedAt: $completedAt, ')
          ..write('triggerReason: $triggerReason, ')
          ..write('relatedNoteId: $relatedNoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    challengeType,
    difficulty,
    difficultyLevel,
    question,
    correctAnswer,
    userAnswer,
    wasCorrect,
    pointsEarned,
    xpEarned,
    timeSpentSeconds,
    timeLimitSeconds,
    wasDoubleOrNothing,
    wasPartOfStreak,
    completedAt,
    triggerReason,
    relatedNoteId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChallengeHistoryData &&
          other.id == this.id &&
          other.challengeType == this.challengeType &&
          other.difficulty == this.difficulty &&
          other.difficultyLevel == this.difficultyLevel &&
          other.question == this.question &&
          other.correctAnswer == this.correctAnswer &&
          other.userAnswer == this.userAnswer &&
          other.wasCorrect == this.wasCorrect &&
          other.pointsEarned == this.pointsEarned &&
          other.xpEarned == this.xpEarned &&
          other.timeSpentSeconds == this.timeSpentSeconds &&
          other.timeLimitSeconds == this.timeLimitSeconds &&
          other.wasDoubleOrNothing == this.wasDoubleOrNothing &&
          other.wasPartOfStreak == this.wasPartOfStreak &&
          other.completedAt == this.completedAt &&
          other.triggerReason == this.triggerReason &&
          other.relatedNoteId == this.relatedNoteId);
}

class ChallengeHistoryCompanion extends UpdateCompanion<ChallengeHistoryData> {
  final Value<String> id;
  final Value<String> challengeType;
  final Value<String> difficulty;
  final Value<int> difficultyLevel;
  final Value<String> question;
  final Value<String> correctAnswer;
  final Value<String?> userAnswer;
  final Value<bool> wasCorrect;
  final Value<int> pointsEarned;
  final Value<int> xpEarned;
  final Value<int?> timeSpentSeconds;
  final Value<int?> timeLimitSeconds;
  final Value<bool> wasDoubleOrNothing;
  final Value<bool> wasPartOfStreak;
  final Value<DateTime> completedAt;
  final Value<String> triggerReason;
  final Value<int?> relatedNoteId;
  final Value<int> rowid;
  const ChallengeHistoryCompanion({
    this.id = const Value.absent(),
    this.challengeType = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.difficultyLevel = const Value.absent(),
    this.question = const Value.absent(),
    this.correctAnswer = const Value.absent(),
    this.userAnswer = const Value.absent(),
    this.wasCorrect = const Value.absent(),
    this.pointsEarned = const Value.absent(),
    this.xpEarned = const Value.absent(),
    this.timeSpentSeconds = const Value.absent(),
    this.timeLimitSeconds = const Value.absent(),
    this.wasDoubleOrNothing = const Value.absent(),
    this.wasPartOfStreak = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.triggerReason = const Value.absent(),
    this.relatedNoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChallengeHistoryCompanion.insert({
    required String id,
    required String challengeType,
    required String difficulty,
    required int difficultyLevel,
    required String question,
    required String correctAnswer,
    this.userAnswer = const Value.absent(),
    required bool wasCorrect,
    required int pointsEarned,
    required int xpEarned,
    this.timeSpentSeconds = const Value.absent(),
    this.timeLimitSeconds = const Value.absent(),
    this.wasDoubleOrNothing = const Value.absent(),
    this.wasPartOfStreak = const Value.absent(),
    this.completedAt = const Value.absent(),
    required String triggerReason,
    this.relatedNoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       challengeType = Value(challengeType),
       difficulty = Value(difficulty),
       difficultyLevel = Value(difficultyLevel),
       question = Value(question),
       correctAnswer = Value(correctAnswer),
       wasCorrect = Value(wasCorrect),
       pointsEarned = Value(pointsEarned),
       xpEarned = Value(xpEarned),
       triggerReason = Value(triggerReason);
  static Insertable<ChallengeHistoryData> custom({
    Expression<String>? id,
    Expression<String>? challengeType,
    Expression<String>? difficulty,
    Expression<int>? difficultyLevel,
    Expression<String>? question,
    Expression<String>? correctAnswer,
    Expression<String>? userAnswer,
    Expression<bool>? wasCorrect,
    Expression<int>? pointsEarned,
    Expression<int>? xpEarned,
    Expression<int>? timeSpentSeconds,
    Expression<int>? timeLimitSeconds,
    Expression<bool>? wasDoubleOrNothing,
    Expression<bool>? wasPartOfStreak,
    Expression<DateTime>? completedAt,
    Expression<String>? triggerReason,
    Expression<int>? relatedNoteId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (challengeType != null) 'challenge_type': challengeType,
      if (difficulty != null) 'difficulty': difficulty,
      if (difficultyLevel != null) 'difficulty_level': difficultyLevel,
      if (question != null) 'question': question,
      if (correctAnswer != null) 'correct_answer': correctAnswer,
      if (userAnswer != null) 'user_answer': userAnswer,
      if (wasCorrect != null) 'was_correct': wasCorrect,
      if (pointsEarned != null) 'points_earned': pointsEarned,
      if (xpEarned != null) 'xp_earned': xpEarned,
      if (timeSpentSeconds != null) 'time_spent_seconds': timeSpentSeconds,
      if (timeLimitSeconds != null) 'time_limit_seconds': timeLimitSeconds,
      if (wasDoubleOrNothing != null)
        'was_double_or_nothing': wasDoubleOrNothing,
      if (wasPartOfStreak != null) 'was_part_of_streak': wasPartOfStreak,
      if (completedAt != null) 'completed_at': completedAt,
      if (triggerReason != null) 'trigger_reason': triggerReason,
      if (relatedNoteId != null) 'related_note_id': relatedNoteId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChallengeHistoryCompanion copyWith({
    Value<String>? id,
    Value<String>? challengeType,
    Value<String>? difficulty,
    Value<int>? difficultyLevel,
    Value<String>? question,
    Value<String>? correctAnswer,
    Value<String?>? userAnswer,
    Value<bool>? wasCorrect,
    Value<int>? pointsEarned,
    Value<int>? xpEarned,
    Value<int?>? timeSpentSeconds,
    Value<int?>? timeLimitSeconds,
    Value<bool>? wasDoubleOrNothing,
    Value<bool>? wasPartOfStreak,
    Value<DateTime>? completedAt,
    Value<String>? triggerReason,
    Value<int?>? relatedNoteId,
    Value<int>? rowid,
  }) {
    return ChallengeHistoryCompanion(
      id: id ?? this.id,
      challengeType: challengeType ?? this.challengeType,
      difficulty: difficulty ?? this.difficulty,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      userAnswer: userAnswer ?? this.userAnswer,
      wasCorrect: wasCorrect ?? this.wasCorrect,
      pointsEarned: pointsEarned ?? this.pointsEarned,
      xpEarned: xpEarned ?? this.xpEarned,
      timeSpentSeconds: timeSpentSeconds ?? this.timeSpentSeconds,
      timeLimitSeconds: timeLimitSeconds ?? this.timeLimitSeconds,
      wasDoubleOrNothing: wasDoubleOrNothing ?? this.wasDoubleOrNothing,
      wasPartOfStreak: wasPartOfStreak ?? this.wasPartOfStreak,
      completedAt: completedAt ?? this.completedAt,
      triggerReason: triggerReason ?? this.triggerReason,
      relatedNoteId: relatedNoteId ?? this.relatedNoteId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (challengeType.present) {
      map['challenge_type'] = Variable<String>(challengeType.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (difficultyLevel.present) {
      map['difficulty_level'] = Variable<int>(difficultyLevel.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (correctAnswer.present) {
      map['correct_answer'] = Variable<String>(correctAnswer.value);
    }
    if (userAnswer.present) {
      map['user_answer'] = Variable<String>(userAnswer.value);
    }
    if (wasCorrect.present) {
      map['was_correct'] = Variable<bool>(wasCorrect.value);
    }
    if (pointsEarned.present) {
      map['points_earned'] = Variable<int>(pointsEarned.value);
    }
    if (xpEarned.present) {
      map['xp_earned'] = Variable<int>(xpEarned.value);
    }
    if (timeSpentSeconds.present) {
      map['time_spent_seconds'] = Variable<int>(timeSpentSeconds.value);
    }
    if (timeLimitSeconds.present) {
      map['time_limit_seconds'] = Variable<int>(timeLimitSeconds.value);
    }
    if (wasDoubleOrNothing.present) {
      map['was_double_or_nothing'] = Variable<bool>(wasDoubleOrNothing.value);
    }
    if (wasPartOfStreak.present) {
      map['was_part_of_streak'] = Variable<bool>(wasPartOfStreak.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (triggerReason.present) {
      map['trigger_reason'] = Variable<String>(triggerReason.value);
    }
    if (relatedNoteId.present) {
      map['related_note_id'] = Variable<int>(relatedNoteId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChallengeHistoryCompanion(')
          ..write('id: $id, ')
          ..write('challengeType: $challengeType, ')
          ..write('difficulty: $difficulty, ')
          ..write('difficultyLevel: $difficultyLevel, ')
          ..write('question: $question, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('userAnswer: $userAnswer, ')
          ..write('wasCorrect: $wasCorrect, ')
          ..write('pointsEarned: $pointsEarned, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('timeSpentSeconds: $timeSpentSeconds, ')
          ..write('timeLimitSeconds: $timeLimitSeconds, ')
          ..write('wasDoubleOrNothing: $wasDoubleOrNothing, ')
          ..write('wasPartOfStreak: $wasPartOfStreak, ')
          ..write('completedAt: $completedAt, ')
          ..write('triggerReason: $triggerReason, ')
          ..write('relatedNoteId: $relatedNoteId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ChaosEvents extends Table with TableInfo<ChaosEvents, ChaosEventsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ChaosEvents(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> eventKey = GeneratedColumn<String>(
    'event_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<DateTime> triggeredAt = GeneratedColumn<DateTime>(
    'triggered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<bool> wasResolved = GeneratedColumn<bool>(
    'was_resolved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("was_resolved" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> pointsAwarded = GeneratedColumn<int>(
    'points_awarded',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventKey,
    eventType,
    title,
    message,
    triggeredAt,
    wasResolved,
    pointsAwarded,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chaos_events';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChaosEventsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChaosEventsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_key'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      triggeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}triggered_at'],
      )!,
      wasResolved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}was_resolved'],
      )!,
      pointsAwarded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points_awarded'],
      )!,
    );
  }

  @override
  ChaosEvents createAlias(String alias) {
    return ChaosEvents(attachedDatabase, alias);
  }
}

class ChaosEventsData extends DataClass implements Insertable<ChaosEventsData> {
  final String id;
  final String eventKey;
  final String eventType;
  final String title;
  final String message;
  final DateTime triggeredAt;
  final bool wasResolved;
  final int pointsAwarded;
  const ChaosEventsData({
    required this.id,
    required this.eventKey,
    required this.eventType,
    required this.title,
    required this.message,
    required this.triggeredAt,
    required this.wasResolved,
    required this.pointsAwarded,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_key'] = Variable<String>(eventKey);
    map['event_type'] = Variable<String>(eventType);
    map['title'] = Variable<String>(title);
    map['message'] = Variable<String>(message);
    map['triggered_at'] = Variable<DateTime>(triggeredAt);
    map['was_resolved'] = Variable<bool>(wasResolved);
    map['points_awarded'] = Variable<int>(pointsAwarded);
    return map;
  }

  ChaosEventsCompanion toCompanion(bool nullToAbsent) {
    return ChaosEventsCompanion(
      id: Value(id),
      eventKey: Value(eventKey),
      eventType: Value(eventType),
      title: Value(title),
      message: Value(message),
      triggeredAt: Value(triggeredAt),
      wasResolved: Value(wasResolved),
      pointsAwarded: Value(pointsAwarded),
    );
  }

  factory ChaosEventsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChaosEventsData(
      id: serializer.fromJson<String>(json['id']),
      eventKey: serializer.fromJson<String>(json['eventKey']),
      eventType: serializer.fromJson<String>(json['eventType']),
      title: serializer.fromJson<String>(json['title']),
      message: serializer.fromJson<String>(json['message']),
      triggeredAt: serializer.fromJson<DateTime>(json['triggeredAt']),
      wasResolved: serializer.fromJson<bool>(json['wasResolved']),
      pointsAwarded: serializer.fromJson<int>(json['pointsAwarded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventKey': serializer.toJson<String>(eventKey),
      'eventType': serializer.toJson<String>(eventType),
      'title': serializer.toJson<String>(title),
      'message': serializer.toJson<String>(message),
      'triggeredAt': serializer.toJson<DateTime>(triggeredAt),
      'wasResolved': serializer.toJson<bool>(wasResolved),
      'pointsAwarded': serializer.toJson<int>(pointsAwarded),
    };
  }

  ChaosEventsData copyWith({
    String? id,
    String? eventKey,
    String? eventType,
    String? title,
    String? message,
    DateTime? triggeredAt,
    bool? wasResolved,
    int? pointsAwarded,
  }) => ChaosEventsData(
    id: id ?? this.id,
    eventKey: eventKey ?? this.eventKey,
    eventType: eventType ?? this.eventType,
    title: title ?? this.title,
    message: message ?? this.message,
    triggeredAt: triggeredAt ?? this.triggeredAt,
    wasResolved: wasResolved ?? this.wasResolved,
    pointsAwarded: pointsAwarded ?? this.pointsAwarded,
  );
  ChaosEventsData copyWithCompanion(ChaosEventsCompanion data) {
    return ChaosEventsData(
      id: data.id.present ? data.id.value : this.id,
      eventKey: data.eventKey.present ? data.eventKey.value : this.eventKey,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      title: data.title.present ? data.title.value : this.title,
      message: data.message.present ? data.message.value : this.message,
      triggeredAt: data.triggeredAt.present
          ? data.triggeredAt.value
          : this.triggeredAt,
      wasResolved: data.wasResolved.present
          ? data.wasResolved.value
          : this.wasResolved,
      pointsAwarded: data.pointsAwarded.present
          ? data.pointsAwarded.value
          : this.pointsAwarded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChaosEventsData(')
          ..write('id: $id, ')
          ..write('eventKey: $eventKey, ')
          ..write('eventType: $eventType, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('triggeredAt: $triggeredAt, ')
          ..write('wasResolved: $wasResolved, ')
          ..write('pointsAwarded: $pointsAwarded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventKey,
    eventType,
    title,
    message,
    triggeredAt,
    wasResolved,
    pointsAwarded,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChaosEventsData &&
          other.id == this.id &&
          other.eventKey == this.eventKey &&
          other.eventType == this.eventType &&
          other.title == this.title &&
          other.message == this.message &&
          other.triggeredAt == this.triggeredAt &&
          other.wasResolved == this.wasResolved &&
          other.pointsAwarded == this.pointsAwarded);
}

class ChaosEventsCompanion extends UpdateCompanion<ChaosEventsData> {
  final Value<String> id;
  final Value<String> eventKey;
  final Value<String> eventType;
  final Value<String> title;
  final Value<String> message;
  final Value<DateTime> triggeredAt;
  final Value<bool> wasResolved;
  final Value<int> pointsAwarded;
  final Value<int> rowid;
  const ChaosEventsCompanion({
    this.id = const Value.absent(),
    this.eventKey = const Value.absent(),
    this.eventType = const Value.absent(),
    this.title = const Value.absent(),
    this.message = const Value.absent(),
    this.triggeredAt = const Value.absent(),
    this.wasResolved = const Value.absent(),
    this.pointsAwarded = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChaosEventsCompanion.insert({
    required String id,
    required String eventKey,
    required String eventType,
    required String title,
    required String message,
    this.triggeredAt = const Value.absent(),
    this.wasResolved = const Value.absent(),
    this.pointsAwarded = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventKey = Value(eventKey),
       eventType = Value(eventType),
       title = Value(title),
       message = Value(message);
  static Insertable<ChaosEventsData> custom({
    Expression<String>? id,
    Expression<String>? eventKey,
    Expression<String>? eventType,
    Expression<String>? title,
    Expression<String>? message,
    Expression<DateTime>? triggeredAt,
    Expression<bool>? wasResolved,
    Expression<int>? pointsAwarded,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventKey != null) 'event_key': eventKey,
      if (eventType != null) 'event_type': eventType,
      if (title != null) 'title': title,
      if (message != null) 'message': message,
      if (triggeredAt != null) 'triggered_at': triggeredAt,
      if (wasResolved != null) 'was_resolved': wasResolved,
      if (pointsAwarded != null) 'points_awarded': pointsAwarded,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChaosEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? eventKey,
    Value<String>? eventType,
    Value<String>? title,
    Value<String>? message,
    Value<DateTime>? triggeredAt,
    Value<bool>? wasResolved,
    Value<int>? pointsAwarded,
    Value<int>? rowid,
  }) {
    return ChaosEventsCompanion(
      id: id ?? this.id,
      eventKey: eventKey ?? this.eventKey,
      eventType: eventType ?? this.eventType,
      title: title ?? this.title,
      message: message ?? this.message,
      triggeredAt: triggeredAt ?? this.triggeredAt,
      wasResolved: wasResolved ?? this.wasResolved,
      pointsAwarded: pointsAwarded ?? this.pointsAwarded,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventKey.present) {
      map['event_key'] = Variable<String>(eventKey.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (triggeredAt.present) {
      map['triggered_at'] = Variable<DateTime>(triggeredAt.value);
    }
    if (wasResolved.present) {
      map['was_resolved'] = Variable<bool>(wasResolved.value);
    }
    if (pointsAwarded.present) {
      map['points_awarded'] = Variable<int>(pointsAwarded.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChaosEventsCompanion(')
          ..write('id: $id, ')
          ..write('eventKey: $eventKey, ')
          ..write('eventType: $eventType, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('triggeredAt: $triggeredAt, ')
          ..write('wasResolved: $wasResolved, ')
          ..write('pointsAwarded: $pointsAwarded, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class PointTransactions extends Table
    with TableInfo<PointTransactions, PointTransactionsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  PointTransactions(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<String> relatedNoteId = GeneratedColumn<String>(
    'related_note_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES notes (id) ON DELETE SET NULL',
    ),
  );
  late final GeneratedColumn<String> relatedChallengeId =
      GeneratedColumn<String>(
        'related_challenge_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES challenge_history (id) ON DELETE SET NULL',
        ),
      );
  late final GeneratedColumn<String> relatedEventId = GeneratedColumn<String>(
    'related_event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chaos_events (id) ON DELETE SET NULL',
    ),
  );
  late final GeneratedColumn<int> balanceAfter = GeneratedColumn<int>(
    'balance_after',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> serverUuid = GeneratedColumn<String>(
    'server_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    amount,
    reason,
    description,
    timestamp,
    relatedNoteId,
    relatedChallengeId,
    relatedEventId,
    balanceAfter,
    serverUuid,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'point_transactions';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PointTransactionsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PointTransactionsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      relatedNoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_note_id'],
      ),
      relatedChallengeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_challenge_id'],
      ),
      relatedEventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_event_id'],
      ),
      balanceAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance_after'],
      )!,
      serverUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_uuid'],
      ),
    );
  }

  @override
  PointTransactions createAlias(String alias) {
    return PointTransactions(attachedDatabase, alias);
  }
}

class PointTransactionsData extends DataClass
    implements Insertable<PointTransactionsData> {
  final String id;
  final int amount;
  final String reason;
  final String? description;
  final DateTime timestamp;
  final String? relatedNoteId;
  final String? relatedChallengeId;
  final String? relatedEventId;
  final int balanceAfter;
  final String? serverUuid;
  const PointTransactionsData({
    required this.id,
    required this.amount,
    required this.reason,
    this.description,
    required this.timestamp,
    this.relatedNoteId,
    this.relatedChallengeId,
    this.relatedEventId,
    required this.balanceAfter,
    this.serverUuid,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['amount'] = Variable<int>(amount);
    map['reason'] = Variable<String>(reason);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || relatedNoteId != null) {
      map['related_note_id'] = Variable<String>(relatedNoteId);
    }
    if (!nullToAbsent || relatedChallengeId != null) {
      map['related_challenge_id'] = Variable<String>(relatedChallengeId);
    }
    if (!nullToAbsent || relatedEventId != null) {
      map['related_event_id'] = Variable<String>(relatedEventId);
    }
    map['balance_after'] = Variable<int>(balanceAfter);
    if (!nullToAbsent || serverUuid != null) {
      map['server_uuid'] = Variable<String>(serverUuid);
    }
    return map;
  }

  PointTransactionsCompanion toCompanion(bool nullToAbsent) {
    return PointTransactionsCompanion(
      id: Value(id),
      amount: Value(amount),
      reason: Value(reason),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      timestamp: Value(timestamp),
      relatedNoteId: relatedNoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedNoteId),
      relatedChallengeId: relatedChallengeId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedChallengeId),
      relatedEventId: relatedEventId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedEventId),
      balanceAfter: Value(balanceAfter),
      serverUuid: serverUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(serverUuid),
    );
  }

  factory PointTransactionsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PointTransactionsData(
      id: serializer.fromJson<String>(json['id']),
      amount: serializer.fromJson<int>(json['amount']),
      reason: serializer.fromJson<String>(json['reason']),
      description: serializer.fromJson<String?>(json['description']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      relatedNoteId: serializer.fromJson<String?>(json['relatedNoteId']),
      relatedChallengeId: serializer.fromJson<String?>(
        json['relatedChallengeId'],
      ),
      relatedEventId: serializer.fromJson<String?>(json['relatedEventId']),
      balanceAfter: serializer.fromJson<int>(json['balanceAfter']),
      serverUuid: serializer.fromJson<String?>(json['serverUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'amount': serializer.toJson<int>(amount),
      'reason': serializer.toJson<String>(reason),
      'description': serializer.toJson<String?>(description),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'relatedNoteId': serializer.toJson<String?>(relatedNoteId),
      'relatedChallengeId': serializer.toJson<String?>(relatedChallengeId),
      'relatedEventId': serializer.toJson<String?>(relatedEventId),
      'balanceAfter': serializer.toJson<int>(balanceAfter),
      'serverUuid': serializer.toJson<String?>(serverUuid),
    };
  }

  PointTransactionsData copyWith({
    String? id,
    int? amount,
    String? reason,
    Value<String?> description = const Value.absent(),
    DateTime? timestamp,
    Value<String?> relatedNoteId = const Value.absent(),
    Value<String?> relatedChallengeId = const Value.absent(),
    Value<String?> relatedEventId = const Value.absent(),
    int? balanceAfter,
    Value<String?> serverUuid = const Value.absent(),
  }) => PointTransactionsData(
    id: id ?? this.id,
    amount: amount ?? this.amount,
    reason: reason ?? this.reason,
    description: description.present ? description.value : this.description,
    timestamp: timestamp ?? this.timestamp,
    relatedNoteId: relatedNoteId.present
        ? relatedNoteId.value
        : this.relatedNoteId,
    relatedChallengeId: relatedChallengeId.present
        ? relatedChallengeId.value
        : this.relatedChallengeId,
    relatedEventId: relatedEventId.present
        ? relatedEventId.value
        : this.relatedEventId,
    balanceAfter: balanceAfter ?? this.balanceAfter,
    serverUuid: serverUuid.present ? serverUuid.value : this.serverUuid,
  );
  PointTransactionsData copyWithCompanion(PointTransactionsCompanion data) {
    return PointTransactionsData(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      reason: data.reason.present ? data.reason.value : this.reason,
      description: data.description.present
          ? data.description.value
          : this.description,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      relatedNoteId: data.relatedNoteId.present
          ? data.relatedNoteId.value
          : this.relatedNoteId,
      relatedChallengeId: data.relatedChallengeId.present
          ? data.relatedChallengeId.value
          : this.relatedChallengeId,
      relatedEventId: data.relatedEventId.present
          ? data.relatedEventId.value
          : this.relatedEventId,
      balanceAfter: data.balanceAfter.present
          ? data.balanceAfter.value
          : this.balanceAfter,
      serverUuid: data.serverUuid.present
          ? data.serverUuid.value
          : this.serverUuid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PointTransactionsData(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('description: $description, ')
          ..write('timestamp: $timestamp, ')
          ..write('relatedNoteId: $relatedNoteId, ')
          ..write('relatedChallengeId: $relatedChallengeId, ')
          ..write('relatedEventId: $relatedEventId, ')
          ..write('balanceAfter: $balanceAfter, ')
          ..write('serverUuid: $serverUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    amount,
    reason,
    description,
    timestamp,
    relatedNoteId,
    relatedChallengeId,
    relatedEventId,
    balanceAfter,
    serverUuid,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PointTransactionsData &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.reason == this.reason &&
          other.description == this.description &&
          other.timestamp == this.timestamp &&
          other.relatedNoteId == this.relatedNoteId &&
          other.relatedChallengeId == this.relatedChallengeId &&
          other.relatedEventId == this.relatedEventId &&
          other.balanceAfter == this.balanceAfter &&
          other.serverUuid == this.serverUuid);
}

class PointTransactionsCompanion
    extends UpdateCompanion<PointTransactionsData> {
  final Value<String> id;
  final Value<int> amount;
  final Value<String> reason;
  final Value<String?> description;
  final Value<DateTime> timestamp;
  final Value<String?> relatedNoteId;
  final Value<String?> relatedChallengeId;
  final Value<String?> relatedEventId;
  final Value<int> balanceAfter;
  final Value<String?> serverUuid;
  final Value<int> rowid;
  const PointTransactionsCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.reason = const Value.absent(),
    this.description = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.relatedNoteId = const Value.absent(),
    this.relatedChallengeId = const Value.absent(),
    this.relatedEventId = const Value.absent(),
    this.balanceAfter = const Value.absent(),
    this.serverUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PointTransactionsCompanion.insert({
    required String id,
    required int amount,
    required String reason,
    this.description = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.relatedNoteId = const Value.absent(),
    this.relatedChallengeId = const Value.absent(),
    this.relatedEventId = const Value.absent(),
    required int balanceAfter,
    this.serverUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       amount = Value(amount),
       reason = Value(reason),
       balanceAfter = Value(balanceAfter);
  static Insertable<PointTransactionsData> custom({
    Expression<String>? id,
    Expression<int>? amount,
    Expression<String>? reason,
    Expression<String>? description,
    Expression<DateTime>? timestamp,
    Expression<String>? relatedNoteId,
    Expression<String>? relatedChallengeId,
    Expression<String>? relatedEventId,
    Expression<int>? balanceAfter,
    Expression<String>? serverUuid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (reason != null) 'reason': reason,
      if (description != null) 'description': description,
      if (timestamp != null) 'timestamp': timestamp,
      if (relatedNoteId != null) 'related_note_id': relatedNoteId,
      if (relatedChallengeId != null)
        'related_challenge_id': relatedChallengeId,
      if (relatedEventId != null) 'related_event_id': relatedEventId,
      if (balanceAfter != null) 'balance_after': balanceAfter,
      if (serverUuid != null) 'server_uuid': serverUuid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PointTransactionsCompanion copyWith({
    Value<String>? id,
    Value<int>? amount,
    Value<String>? reason,
    Value<String?>? description,
    Value<DateTime>? timestamp,
    Value<String?>? relatedNoteId,
    Value<String?>? relatedChallengeId,
    Value<String?>? relatedEventId,
    Value<int>? balanceAfter,
    Value<String?>? serverUuid,
    Value<int>? rowid,
  }) {
    return PointTransactionsCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      reason: reason ?? this.reason,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      relatedNoteId: relatedNoteId ?? this.relatedNoteId,
      relatedChallengeId: relatedChallengeId ?? this.relatedChallengeId,
      relatedEventId: relatedEventId ?? this.relatedEventId,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      serverUuid: serverUuid ?? this.serverUuid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (relatedNoteId.present) {
      map['related_note_id'] = Variable<String>(relatedNoteId.value);
    }
    if (relatedChallengeId.present) {
      map['related_challenge_id'] = Variable<String>(relatedChallengeId.value);
    }
    if (relatedEventId.present) {
      map['related_event_id'] = Variable<String>(relatedEventId.value);
    }
    if (balanceAfter.present) {
      map['balance_after'] = Variable<int>(balanceAfter.value);
    }
    if (serverUuid.present) {
      map['server_uuid'] = Variable<String>(serverUuid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PointTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('description: $description, ')
          ..write('timestamp: $timestamp, ')
          ..write('relatedNoteId: $relatedNoteId, ')
          ..write('relatedChallengeId: $relatedChallengeId, ')
          ..write('relatedEventId: $relatedEventId, ')
          ..write('balanceAfter: $balanceAfter, ')
          ..write('serverUuid: $serverUuid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class UserProgress extends Table
    with TableInfo<UserProgress, UserProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  UserProgress(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> totalPoints = GeneratedColumn<int>(
    'total_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('100'),
  );
  late final GeneratedColumn<int> lifetimePointsEarned = GeneratedColumn<int>(
    'lifetime_points_earned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> lifetimePointsSpent = GeneratedColumn<int>(
    'lifetime_points_spent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('1'),
  );
  late final GeneratedColumn<int> currentXp = GeneratedColumn<int>(
    'current_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> xpToNextLevel = GeneratedColumn<int>(
    'xp_to_next_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('100'),
  );
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
    'current_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
    'longest_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<DateTime> lastChallengeDate =
      GeneratedColumn<DateTime>(
        'last_challenge_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  late final GeneratedColumn<int> totalChallengesSolved = GeneratedColumn<int>(
    'total_challenges_solved',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> totalChallengesFailed = GeneratedColumn<int>(
    'total_challenges_failed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> totalNotesCreated = GeneratedColumn<int>(
    'total_notes_created',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> totalNotesDeleted = GeneratedColumn<int>(
    'total_notes_deleted',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<bool> chaosEnabled = GeneratedColumn<bool>(
    'chaos_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("chaos_enabled" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('1'),
  );
  late final GeneratedColumn<int> challengeTimeLimit = GeneratedColumn<int>(
    'challenge_time_limit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('30'),
  );
  late final GeneratedColumn<String> personalityTone = GeneratedColumn<String>(
    'personality_tone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('\'random\''),
  );
  late final GeneratedColumn<bool> soundEnabled = GeneratedColumn<bool>(
    'sound_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sound_enabled" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('1'),
  );
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
    'notifications_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notifications_enabled" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('1'),
  );
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    totalPoints,
    lifetimePointsEarned,
    lifetimePointsSpent,
    level,
    currentXp,
    xpToNextLevel,
    currentStreak,
    longestStreak,
    lastChallengeDate,
    totalChallengesSolved,
    totalChallengesFailed,
    totalNotesCreated,
    totalNotesDeleted,
    chaosEnabled,
    challengeTimeLimit,
    personalityTone,
    soundEnabled,
    notificationsEnabled,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_progress';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProgressData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      totalPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_points'],
      )!,
      lifetimePointsEarned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lifetime_points_earned'],
      )!,
      lifetimePointsSpent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lifetime_points_spent'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      currentXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_xp'],
      )!,
      xpToNextLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_to_next_level'],
      )!,
      currentStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_streak'],
      )!,
      longestStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}longest_streak'],
      )!,
      lastChallengeDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_challenge_date'],
      ),
      totalChallengesSolved: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_challenges_solved'],
      )!,
      totalChallengesFailed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_challenges_failed'],
      )!,
      totalNotesCreated: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_notes_created'],
      )!,
      totalNotesDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_notes_deleted'],
      )!,
      chaosEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}chaos_enabled'],
      )!,
      challengeTimeLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}challenge_time_limit'],
      )!,
      personalityTone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}personality_tone'],
      )!,
      soundEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sound_enabled'],
      )!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notifications_enabled'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  UserProgress createAlias(String alias) {
    return UserProgress(attachedDatabase, alias);
  }
}

class UserProgressData extends DataClass
    implements Insertable<UserProgressData> {
  final String id;
  final int totalPoints;
  final int lifetimePointsEarned;
  final int lifetimePointsSpent;
  final int level;
  final int currentXp;
  final int xpToNextLevel;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastChallengeDate;
  final int totalChallengesSolved;
  final int totalChallengesFailed;
  final int totalNotesCreated;
  final int totalNotesDeleted;
  final bool chaosEnabled;
  final int challengeTimeLimit;
  final String personalityTone;
  final bool soundEnabled;
  final bool notificationsEnabled;
  final DateTime updatedAt;
  const UserProgressData({
    required this.id,
    required this.totalPoints,
    required this.lifetimePointsEarned,
    required this.lifetimePointsSpent,
    required this.level,
    required this.currentXp,
    required this.xpToNextLevel,
    required this.currentStreak,
    required this.longestStreak,
    this.lastChallengeDate,
    required this.totalChallengesSolved,
    required this.totalChallengesFailed,
    required this.totalNotesCreated,
    required this.totalNotesDeleted,
    required this.chaosEnabled,
    required this.challengeTimeLimit,
    required this.personalityTone,
    required this.soundEnabled,
    required this.notificationsEnabled,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['total_points'] = Variable<int>(totalPoints);
    map['lifetime_points_earned'] = Variable<int>(lifetimePointsEarned);
    map['lifetime_points_spent'] = Variable<int>(lifetimePointsSpent);
    map['level'] = Variable<int>(level);
    map['current_xp'] = Variable<int>(currentXp);
    map['xp_to_next_level'] = Variable<int>(xpToNextLevel);
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    if (!nullToAbsent || lastChallengeDate != null) {
      map['last_challenge_date'] = Variable<DateTime>(lastChallengeDate);
    }
    map['total_challenges_solved'] = Variable<int>(totalChallengesSolved);
    map['total_challenges_failed'] = Variable<int>(totalChallengesFailed);
    map['total_notes_created'] = Variable<int>(totalNotesCreated);
    map['total_notes_deleted'] = Variable<int>(totalNotesDeleted);
    map['chaos_enabled'] = Variable<bool>(chaosEnabled);
    map['challenge_time_limit'] = Variable<int>(challengeTimeLimit);
    map['personality_tone'] = Variable<String>(personalityTone);
    map['sound_enabled'] = Variable<bool>(soundEnabled);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProgressCompanion toCompanion(bool nullToAbsent) {
    return UserProgressCompanion(
      id: Value(id),
      totalPoints: Value(totalPoints),
      lifetimePointsEarned: Value(lifetimePointsEarned),
      lifetimePointsSpent: Value(lifetimePointsSpent),
      level: Value(level),
      currentXp: Value(currentXp),
      xpToNextLevel: Value(xpToNextLevel),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      lastChallengeDate: lastChallengeDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastChallengeDate),
      totalChallengesSolved: Value(totalChallengesSolved),
      totalChallengesFailed: Value(totalChallengesFailed),
      totalNotesCreated: Value(totalNotesCreated),
      totalNotesDeleted: Value(totalNotesDeleted),
      chaosEnabled: Value(chaosEnabled),
      challengeTimeLimit: Value(challengeTimeLimit),
      personalityTone: Value(personalityTone),
      soundEnabled: Value(soundEnabled),
      notificationsEnabled: Value(notificationsEnabled),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProgressData(
      id: serializer.fromJson<String>(json['id']),
      totalPoints: serializer.fromJson<int>(json['totalPoints']),
      lifetimePointsEarned: serializer.fromJson<int>(
        json['lifetimePointsEarned'],
      ),
      lifetimePointsSpent: serializer.fromJson<int>(
        json['lifetimePointsSpent'],
      ),
      level: serializer.fromJson<int>(json['level']),
      currentXp: serializer.fromJson<int>(json['currentXp']),
      xpToNextLevel: serializer.fromJson<int>(json['xpToNextLevel']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      lastChallengeDate: serializer.fromJson<DateTime?>(
        json['lastChallengeDate'],
      ),
      totalChallengesSolved: serializer.fromJson<int>(
        json['totalChallengesSolved'],
      ),
      totalChallengesFailed: serializer.fromJson<int>(
        json['totalChallengesFailed'],
      ),
      totalNotesCreated: serializer.fromJson<int>(json['totalNotesCreated']),
      totalNotesDeleted: serializer.fromJson<int>(json['totalNotesDeleted']),
      chaosEnabled: serializer.fromJson<bool>(json['chaosEnabled']),
      challengeTimeLimit: serializer.fromJson<int>(json['challengeTimeLimit']),
      personalityTone: serializer.fromJson<String>(json['personalityTone']),
      soundEnabled: serializer.fromJson<bool>(json['soundEnabled']),
      notificationsEnabled: serializer.fromJson<bool>(
        json['notificationsEnabled'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'totalPoints': serializer.toJson<int>(totalPoints),
      'lifetimePointsEarned': serializer.toJson<int>(lifetimePointsEarned),
      'lifetimePointsSpent': serializer.toJson<int>(lifetimePointsSpent),
      'level': serializer.toJson<int>(level),
      'currentXp': serializer.toJson<int>(currentXp),
      'xpToNextLevel': serializer.toJson<int>(xpToNextLevel),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'lastChallengeDate': serializer.toJson<DateTime?>(lastChallengeDate),
      'totalChallengesSolved': serializer.toJson<int>(totalChallengesSolved),
      'totalChallengesFailed': serializer.toJson<int>(totalChallengesFailed),
      'totalNotesCreated': serializer.toJson<int>(totalNotesCreated),
      'totalNotesDeleted': serializer.toJson<int>(totalNotesDeleted),
      'chaosEnabled': serializer.toJson<bool>(chaosEnabled),
      'challengeTimeLimit': serializer.toJson<int>(challengeTimeLimit),
      'personalityTone': serializer.toJson<String>(personalityTone),
      'soundEnabled': serializer.toJson<bool>(soundEnabled),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserProgressData copyWith({
    String? id,
    int? totalPoints,
    int? lifetimePointsEarned,
    int? lifetimePointsSpent,
    int? level,
    int? currentXp,
    int? xpToNextLevel,
    int? currentStreak,
    int? longestStreak,
    Value<DateTime?> lastChallengeDate = const Value.absent(),
    int? totalChallengesSolved,
    int? totalChallengesFailed,
    int? totalNotesCreated,
    int? totalNotesDeleted,
    bool? chaosEnabled,
    int? challengeTimeLimit,
    String? personalityTone,
    bool? soundEnabled,
    bool? notificationsEnabled,
    DateTime? updatedAt,
  }) => UserProgressData(
    id: id ?? this.id,
    totalPoints: totalPoints ?? this.totalPoints,
    lifetimePointsEarned: lifetimePointsEarned ?? this.lifetimePointsEarned,
    lifetimePointsSpent: lifetimePointsSpent ?? this.lifetimePointsSpent,
    level: level ?? this.level,
    currentXp: currentXp ?? this.currentXp,
    xpToNextLevel: xpToNextLevel ?? this.xpToNextLevel,
    currentStreak: currentStreak ?? this.currentStreak,
    longestStreak: longestStreak ?? this.longestStreak,
    lastChallengeDate: lastChallengeDate.present
        ? lastChallengeDate.value
        : this.lastChallengeDate,
    totalChallengesSolved: totalChallengesSolved ?? this.totalChallengesSolved,
    totalChallengesFailed: totalChallengesFailed ?? this.totalChallengesFailed,
    totalNotesCreated: totalNotesCreated ?? this.totalNotesCreated,
    totalNotesDeleted: totalNotesDeleted ?? this.totalNotesDeleted,
    chaosEnabled: chaosEnabled ?? this.chaosEnabled,
    challengeTimeLimit: challengeTimeLimit ?? this.challengeTimeLimit,
    personalityTone: personalityTone ?? this.personalityTone,
    soundEnabled: soundEnabled ?? this.soundEnabled,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserProgressData copyWithCompanion(UserProgressCompanion data) {
    return UserProgressData(
      id: data.id.present ? data.id.value : this.id,
      totalPoints: data.totalPoints.present
          ? data.totalPoints.value
          : this.totalPoints,
      lifetimePointsEarned: data.lifetimePointsEarned.present
          ? data.lifetimePointsEarned.value
          : this.lifetimePointsEarned,
      lifetimePointsSpent: data.lifetimePointsSpent.present
          ? data.lifetimePointsSpent.value
          : this.lifetimePointsSpent,
      level: data.level.present ? data.level.value : this.level,
      currentXp: data.currentXp.present ? data.currentXp.value : this.currentXp,
      xpToNextLevel: data.xpToNextLevel.present
          ? data.xpToNextLevel.value
          : this.xpToNextLevel,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      longestStreak: data.longestStreak.present
          ? data.longestStreak.value
          : this.longestStreak,
      lastChallengeDate: data.lastChallengeDate.present
          ? data.lastChallengeDate.value
          : this.lastChallengeDate,
      totalChallengesSolved: data.totalChallengesSolved.present
          ? data.totalChallengesSolved.value
          : this.totalChallengesSolved,
      totalChallengesFailed: data.totalChallengesFailed.present
          ? data.totalChallengesFailed.value
          : this.totalChallengesFailed,
      totalNotesCreated: data.totalNotesCreated.present
          ? data.totalNotesCreated.value
          : this.totalNotesCreated,
      totalNotesDeleted: data.totalNotesDeleted.present
          ? data.totalNotesDeleted.value
          : this.totalNotesDeleted,
      chaosEnabled: data.chaosEnabled.present
          ? data.chaosEnabled.value
          : this.chaosEnabled,
      challengeTimeLimit: data.challengeTimeLimit.present
          ? data.challengeTimeLimit.value
          : this.challengeTimeLimit,
      personalityTone: data.personalityTone.present
          ? data.personalityTone.value
          : this.personalityTone,
      soundEnabled: data.soundEnabled.present
          ? data.soundEnabled.value
          : this.soundEnabled,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressData(')
          ..write('id: $id, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('lifetimePointsEarned: $lifetimePointsEarned, ')
          ..write('lifetimePointsSpent: $lifetimePointsSpent, ')
          ..write('level: $level, ')
          ..write('currentXp: $currentXp, ')
          ..write('xpToNextLevel: $xpToNextLevel, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastChallengeDate: $lastChallengeDate, ')
          ..write('totalChallengesSolved: $totalChallengesSolved, ')
          ..write('totalChallengesFailed: $totalChallengesFailed, ')
          ..write('totalNotesCreated: $totalNotesCreated, ')
          ..write('totalNotesDeleted: $totalNotesDeleted, ')
          ..write('chaosEnabled: $chaosEnabled, ')
          ..write('challengeTimeLimit: $challengeTimeLimit, ')
          ..write('personalityTone: $personalityTone, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    totalPoints,
    lifetimePointsEarned,
    lifetimePointsSpent,
    level,
    currentXp,
    xpToNextLevel,
    currentStreak,
    longestStreak,
    lastChallengeDate,
    totalChallengesSolved,
    totalChallengesFailed,
    totalNotesCreated,
    totalNotesDeleted,
    chaosEnabled,
    challengeTimeLimit,
    personalityTone,
    soundEnabled,
    notificationsEnabled,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProgressData &&
          other.id == this.id &&
          other.totalPoints == this.totalPoints &&
          other.lifetimePointsEarned == this.lifetimePointsEarned &&
          other.lifetimePointsSpent == this.lifetimePointsSpent &&
          other.level == this.level &&
          other.currentXp == this.currentXp &&
          other.xpToNextLevel == this.xpToNextLevel &&
          other.currentStreak == this.currentStreak &&
          other.longestStreak == this.longestStreak &&
          other.lastChallengeDate == this.lastChallengeDate &&
          other.totalChallengesSolved == this.totalChallengesSolved &&
          other.totalChallengesFailed == this.totalChallengesFailed &&
          other.totalNotesCreated == this.totalNotesCreated &&
          other.totalNotesDeleted == this.totalNotesDeleted &&
          other.chaosEnabled == this.chaosEnabled &&
          other.challengeTimeLimit == this.challengeTimeLimit &&
          other.personalityTone == this.personalityTone &&
          other.soundEnabled == this.soundEnabled &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.updatedAt == this.updatedAt);
}

class UserProgressCompanion extends UpdateCompanion<UserProgressData> {
  final Value<String> id;
  final Value<int> totalPoints;
  final Value<int> lifetimePointsEarned;
  final Value<int> lifetimePointsSpent;
  final Value<int> level;
  final Value<int> currentXp;
  final Value<int> xpToNextLevel;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<DateTime?> lastChallengeDate;
  final Value<int> totalChallengesSolved;
  final Value<int> totalChallengesFailed;
  final Value<int> totalNotesCreated;
  final Value<int> totalNotesDeleted;
  final Value<bool> chaosEnabled;
  final Value<int> challengeTimeLimit;
  final Value<String> personalityTone;
  final Value<bool> soundEnabled;
  final Value<bool> notificationsEnabled;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserProgressCompanion({
    this.id = const Value.absent(),
    this.totalPoints = const Value.absent(),
    this.lifetimePointsEarned = const Value.absent(),
    this.lifetimePointsSpent = const Value.absent(),
    this.level = const Value.absent(),
    this.currentXp = const Value.absent(),
    this.xpToNextLevel = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.lastChallengeDate = const Value.absent(),
    this.totalChallengesSolved = const Value.absent(),
    this.totalChallengesFailed = const Value.absent(),
    this.totalNotesCreated = const Value.absent(),
    this.totalNotesDeleted = const Value.absent(),
    this.chaosEnabled = const Value.absent(),
    this.challengeTimeLimit = const Value.absent(),
    this.personalityTone = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProgressCompanion.insert({
    required String id,
    this.totalPoints = const Value.absent(),
    this.lifetimePointsEarned = const Value.absent(),
    this.lifetimePointsSpent = const Value.absent(),
    this.level = const Value.absent(),
    this.currentXp = const Value.absent(),
    this.xpToNextLevel = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.lastChallengeDate = const Value.absent(),
    this.totalChallengesSolved = const Value.absent(),
    this.totalChallengesFailed = const Value.absent(),
    this.totalNotesCreated = const Value.absent(),
    this.totalNotesDeleted = const Value.absent(),
    this.chaosEnabled = const Value.absent(),
    this.challengeTimeLimit = const Value.absent(),
    this.personalityTone = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<UserProgressData> custom({
    Expression<String>? id,
    Expression<int>? totalPoints,
    Expression<int>? lifetimePointsEarned,
    Expression<int>? lifetimePointsSpent,
    Expression<int>? level,
    Expression<int>? currentXp,
    Expression<int>? xpToNextLevel,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<DateTime>? lastChallengeDate,
    Expression<int>? totalChallengesSolved,
    Expression<int>? totalChallengesFailed,
    Expression<int>? totalNotesCreated,
    Expression<int>? totalNotesDeleted,
    Expression<bool>? chaosEnabled,
    Expression<int>? challengeTimeLimit,
    Expression<String>? personalityTone,
    Expression<bool>? soundEnabled,
    Expression<bool>? notificationsEnabled,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalPoints != null) 'total_points': totalPoints,
      if (lifetimePointsEarned != null)
        'lifetime_points_earned': lifetimePointsEarned,
      if (lifetimePointsSpent != null)
        'lifetime_points_spent': lifetimePointsSpent,
      if (level != null) 'level': level,
      if (currentXp != null) 'current_xp': currentXp,
      if (xpToNextLevel != null) 'xp_to_next_level': xpToNextLevel,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (lastChallengeDate != null) 'last_challenge_date': lastChallengeDate,
      if (totalChallengesSolved != null)
        'total_challenges_solved': totalChallengesSolved,
      if (totalChallengesFailed != null)
        'total_challenges_failed': totalChallengesFailed,
      if (totalNotesCreated != null) 'total_notes_created': totalNotesCreated,
      if (totalNotesDeleted != null) 'total_notes_deleted': totalNotesDeleted,
      if (chaosEnabled != null) 'chaos_enabled': chaosEnabled,
      if (challengeTimeLimit != null)
        'challenge_time_limit': challengeTimeLimit,
      if (personalityTone != null) 'personality_tone': personalityTone,
      if (soundEnabled != null) 'sound_enabled': soundEnabled,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProgressCompanion copyWith({
    Value<String>? id,
    Value<int>? totalPoints,
    Value<int>? lifetimePointsEarned,
    Value<int>? lifetimePointsSpent,
    Value<int>? level,
    Value<int>? currentXp,
    Value<int>? xpToNextLevel,
    Value<int>? currentStreak,
    Value<int>? longestStreak,
    Value<DateTime?>? lastChallengeDate,
    Value<int>? totalChallengesSolved,
    Value<int>? totalChallengesFailed,
    Value<int>? totalNotesCreated,
    Value<int>? totalNotesDeleted,
    Value<bool>? chaosEnabled,
    Value<int>? challengeTimeLimit,
    Value<String>? personalityTone,
    Value<bool>? soundEnabled,
    Value<bool>? notificationsEnabled,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserProgressCompanion(
      id: id ?? this.id,
      totalPoints: totalPoints ?? this.totalPoints,
      lifetimePointsEarned: lifetimePointsEarned ?? this.lifetimePointsEarned,
      lifetimePointsSpent: lifetimePointsSpent ?? this.lifetimePointsSpent,
      level: level ?? this.level,
      currentXp: currentXp ?? this.currentXp,
      xpToNextLevel: xpToNextLevel ?? this.xpToNextLevel,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastChallengeDate: lastChallengeDate ?? this.lastChallengeDate,
      totalChallengesSolved:
          totalChallengesSolved ?? this.totalChallengesSolved,
      totalChallengesFailed:
          totalChallengesFailed ?? this.totalChallengesFailed,
      totalNotesCreated: totalNotesCreated ?? this.totalNotesCreated,
      totalNotesDeleted: totalNotesDeleted ?? this.totalNotesDeleted,
      chaosEnabled: chaosEnabled ?? this.chaosEnabled,
      challengeTimeLimit: challengeTimeLimit ?? this.challengeTimeLimit,
      personalityTone: personalityTone ?? this.personalityTone,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (totalPoints.present) {
      map['total_points'] = Variable<int>(totalPoints.value);
    }
    if (lifetimePointsEarned.present) {
      map['lifetime_points_earned'] = Variable<int>(lifetimePointsEarned.value);
    }
    if (lifetimePointsSpent.present) {
      map['lifetime_points_spent'] = Variable<int>(lifetimePointsSpent.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (currentXp.present) {
      map['current_xp'] = Variable<int>(currentXp.value);
    }
    if (xpToNextLevel.present) {
      map['xp_to_next_level'] = Variable<int>(xpToNextLevel.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (lastChallengeDate.present) {
      map['last_challenge_date'] = Variable<DateTime>(lastChallengeDate.value);
    }
    if (totalChallengesSolved.present) {
      map['total_challenges_solved'] = Variable<int>(
        totalChallengesSolved.value,
      );
    }
    if (totalChallengesFailed.present) {
      map['total_challenges_failed'] = Variable<int>(
        totalChallengesFailed.value,
      );
    }
    if (totalNotesCreated.present) {
      map['total_notes_created'] = Variable<int>(totalNotesCreated.value);
    }
    if (totalNotesDeleted.present) {
      map['total_notes_deleted'] = Variable<int>(totalNotesDeleted.value);
    }
    if (chaosEnabled.present) {
      map['chaos_enabled'] = Variable<bool>(chaosEnabled.value);
    }
    if (challengeTimeLimit.present) {
      map['challenge_time_limit'] = Variable<int>(challengeTimeLimit.value);
    }
    if (personalityTone.present) {
      map['personality_tone'] = Variable<String>(personalityTone.value);
    }
    if (soundEnabled.present) {
      map['sound_enabled'] = Variable<bool>(soundEnabled.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressCompanion(')
          ..write('id: $id, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('lifetimePointsEarned: $lifetimePointsEarned, ')
          ..write('lifetimePointsSpent: $lifetimePointsSpent, ')
          ..write('level: $level, ')
          ..write('currentXp: $currentXp, ')
          ..write('xpToNextLevel: $xpToNextLevel, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastChallengeDate: $lastChallengeDate, ')
          ..write('totalChallengesSolved: $totalChallengesSolved, ')
          ..write('totalChallengesFailed: $totalChallengesFailed, ')
          ..write('totalNotesCreated: $totalNotesCreated, ')
          ..write('totalNotesDeleted: $totalNotesDeleted, ')
          ..write('chaosEnabled: $chaosEnabled, ')
          ..write('challengeTimeLimit: $challengeTimeLimit, ')
          ..write('personalityTone: $personalityTone, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Achievements extends Table
    with TableInfo<Achievements, AchievementsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Achievements(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> achievementKey = GeneratedColumn<String>(
    'achievement_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> targetValue = GeneratedColumn<int>(
    'target_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> currentProgress = GeneratedColumn<int>(
    'current_progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<bool> isUnlocked = GeneratedColumn<bool>(
    'is_unlocked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_unlocked" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<int> pointReward = GeneratedColumn<int>(
    'point_reward',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<String> rarity = GeneratedColumn<String>(
    'rarity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('\'common\''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    achievementKey,
    name,
    description,
    iconName,
    targetValue,
    currentProgress,
    isUnlocked,
    unlockedAt,
    pointReward,
    rarity,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievements';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AchievementsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AchievementsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      achievementKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}achievement_key'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      )!,
      targetValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_value'],
      )!,
      currentProgress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_progress'],
      )!,
      isUnlocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_unlocked'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      ),
      pointReward: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}point_reward'],
      )!,
      rarity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rarity'],
      )!,
    );
  }

  @override
  Achievements createAlias(String alias) {
    return Achievements(attachedDatabase, alias);
  }
}

class AchievementsData extends DataClass
    implements Insertable<AchievementsData> {
  final String id;
  final String achievementKey;
  final String name;
  final String description;
  final String iconName;
  final int targetValue;
  final int currentProgress;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final int pointReward;
  final String rarity;
  const AchievementsData({
    required this.id,
    required this.achievementKey,
    required this.name,
    required this.description,
    required this.iconName,
    required this.targetValue,
    required this.currentProgress,
    required this.isUnlocked,
    this.unlockedAt,
    required this.pointReward,
    required this.rarity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['achievement_key'] = Variable<String>(achievementKey);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['icon_name'] = Variable<String>(iconName);
    map['target_value'] = Variable<int>(targetValue);
    map['current_progress'] = Variable<int>(currentProgress);
    map['is_unlocked'] = Variable<bool>(isUnlocked);
    if (!nullToAbsent || unlockedAt != null) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    }
    map['point_reward'] = Variable<int>(pointReward);
    map['rarity'] = Variable<String>(rarity);
    return map;
  }

  AchievementsCompanion toCompanion(bool nullToAbsent) {
    return AchievementsCompanion(
      id: Value(id),
      achievementKey: Value(achievementKey),
      name: Value(name),
      description: Value(description),
      iconName: Value(iconName),
      targetValue: Value(targetValue),
      currentProgress: Value(currentProgress),
      isUnlocked: Value(isUnlocked),
      unlockedAt: unlockedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockedAt),
      pointReward: Value(pointReward),
      rarity: Value(rarity),
    );
  }

  factory AchievementsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AchievementsData(
      id: serializer.fromJson<String>(json['id']),
      achievementKey: serializer.fromJson<String>(json['achievementKey']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      iconName: serializer.fromJson<String>(json['iconName']),
      targetValue: serializer.fromJson<int>(json['targetValue']),
      currentProgress: serializer.fromJson<int>(json['currentProgress']),
      isUnlocked: serializer.fromJson<bool>(json['isUnlocked']),
      unlockedAt: serializer.fromJson<DateTime?>(json['unlockedAt']),
      pointReward: serializer.fromJson<int>(json['pointReward']),
      rarity: serializer.fromJson<String>(json['rarity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'achievementKey': serializer.toJson<String>(achievementKey),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'iconName': serializer.toJson<String>(iconName),
      'targetValue': serializer.toJson<int>(targetValue),
      'currentProgress': serializer.toJson<int>(currentProgress),
      'isUnlocked': serializer.toJson<bool>(isUnlocked),
      'unlockedAt': serializer.toJson<DateTime?>(unlockedAt),
      'pointReward': serializer.toJson<int>(pointReward),
      'rarity': serializer.toJson<String>(rarity),
    };
  }

  AchievementsData copyWith({
    String? id,
    String? achievementKey,
    String? name,
    String? description,
    String? iconName,
    int? targetValue,
    int? currentProgress,
    bool? isUnlocked,
    Value<DateTime?> unlockedAt = const Value.absent(),
    int? pointReward,
    String? rarity,
  }) => AchievementsData(
    id: id ?? this.id,
    achievementKey: achievementKey ?? this.achievementKey,
    name: name ?? this.name,
    description: description ?? this.description,
    iconName: iconName ?? this.iconName,
    targetValue: targetValue ?? this.targetValue,
    currentProgress: currentProgress ?? this.currentProgress,
    isUnlocked: isUnlocked ?? this.isUnlocked,
    unlockedAt: unlockedAt.present ? unlockedAt.value : this.unlockedAt,
    pointReward: pointReward ?? this.pointReward,
    rarity: rarity ?? this.rarity,
  );
  AchievementsData copyWithCompanion(AchievementsCompanion data) {
    return AchievementsData(
      id: data.id.present ? data.id.value : this.id,
      achievementKey: data.achievementKey.present
          ? data.achievementKey.value
          : this.achievementKey,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      targetValue: data.targetValue.present
          ? data.targetValue.value
          : this.targetValue,
      currentProgress: data.currentProgress.present
          ? data.currentProgress.value
          : this.currentProgress,
      isUnlocked: data.isUnlocked.present
          ? data.isUnlocked.value
          : this.isUnlocked,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
      pointReward: data.pointReward.present
          ? data.pointReward.value
          : this.pointReward,
      rarity: data.rarity.present ? data.rarity.value : this.rarity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsData(')
          ..write('id: $id, ')
          ..write('achievementKey: $achievementKey, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('iconName: $iconName, ')
          ..write('targetValue: $targetValue, ')
          ..write('currentProgress: $currentProgress, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('pointReward: $pointReward, ')
          ..write('rarity: $rarity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    achievementKey,
    name,
    description,
    iconName,
    targetValue,
    currentProgress,
    isUnlocked,
    unlockedAt,
    pointReward,
    rarity,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AchievementsData &&
          other.id == this.id &&
          other.achievementKey == this.achievementKey &&
          other.name == this.name &&
          other.description == this.description &&
          other.iconName == this.iconName &&
          other.targetValue == this.targetValue &&
          other.currentProgress == this.currentProgress &&
          other.isUnlocked == this.isUnlocked &&
          other.unlockedAt == this.unlockedAt &&
          other.pointReward == this.pointReward &&
          other.rarity == this.rarity);
}

class AchievementsCompanion extends UpdateCompanion<AchievementsData> {
  final Value<String> id;
  final Value<String> achievementKey;
  final Value<String> name;
  final Value<String> description;
  final Value<String> iconName;
  final Value<int> targetValue;
  final Value<int> currentProgress;
  final Value<bool> isUnlocked;
  final Value<DateTime?> unlockedAt;
  final Value<int> pointReward;
  final Value<String> rarity;
  final Value<int> rowid;
  const AchievementsCompanion({
    this.id = const Value.absent(),
    this.achievementKey = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.iconName = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.currentProgress = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.pointReward = const Value.absent(),
    this.rarity = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AchievementsCompanion.insert({
    required String id,
    required String achievementKey,
    required String name,
    required String description,
    required String iconName,
    required int targetValue,
    this.currentProgress = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.pointReward = const Value.absent(),
    this.rarity = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       achievementKey = Value(achievementKey),
       name = Value(name),
       description = Value(description),
       iconName = Value(iconName),
       targetValue = Value(targetValue);
  static Insertable<AchievementsData> custom({
    Expression<String>? id,
    Expression<String>? achievementKey,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? iconName,
    Expression<int>? targetValue,
    Expression<int>? currentProgress,
    Expression<bool>? isUnlocked,
    Expression<DateTime>? unlockedAt,
    Expression<int>? pointReward,
    Expression<String>? rarity,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (achievementKey != null) 'achievement_key': achievementKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (iconName != null) 'icon_name': iconName,
      if (targetValue != null) 'target_value': targetValue,
      if (currentProgress != null) 'current_progress': currentProgress,
      if (isUnlocked != null) 'is_unlocked': isUnlocked,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (pointReward != null) 'point_reward': pointReward,
      if (rarity != null) 'rarity': rarity,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AchievementsCompanion copyWith({
    Value<String>? id,
    Value<String>? achievementKey,
    Value<String>? name,
    Value<String>? description,
    Value<String>? iconName,
    Value<int>? targetValue,
    Value<int>? currentProgress,
    Value<bool>? isUnlocked,
    Value<DateTime?>? unlockedAt,
    Value<int>? pointReward,
    Value<String>? rarity,
    Value<int>? rowid,
  }) {
    return AchievementsCompanion(
      id: id ?? this.id,
      achievementKey: achievementKey ?? this.achievementKey,
      name: name ?? this.name,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      targetValue: targetValue ?? this.targetValue,
      currentProgress: currentProgress ?? this.currentProgress,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      pointReward: pointReward ?? this.pointReward,
      rarity: rarity ?? this.rarity,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (achievementKey.present) {
      map['achievement_key'] = Variable<String>(achievementKey.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<int>(targetValue.value);
    }
    if (currentProgress.present) {
      map['current_progress'] = Variable<int>(currentProgress.value);
    }
    if (isUnlocked.present) {
      map['is_unlocked'] = Variable<bool>(isUnlocked.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    if (pointReward.present) {
      map['point_reward'] = Variable<int>(pointReward.value);
    }
    if (rarity.present) {
      map['rarity'] = Variable<String>(rarity.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsCompanion(')
          ..write('id: $id, ')
          ..write('achievementKey: $achievementKey, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('iconName: $iconName, ')
          ..write('targetValue: $targetValue, ')
          ..write('currentProgress: $currentProgress, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('pointReward: $pointReward, ')
          ..write('rarity: $rarity, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ActiveEffects extends Table
    with TableInfo<ActiveEffects, ActiveEffectsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ActiveEffects(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> effectType = GeneratedColumn<String>(
    'effect_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<double> multiplier = GeneratedColumn<double>(
    'multiplier',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('1.0'),
  );
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('1'),
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> relatedEventId = GeneratedColumn<int>(
    'related_event_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chaos_events (id) ON DELETE SET NULL',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    effectType,
    multiplier,
    startedAt,
    expiresAt,
    isActive,
    description,
    relatedEventId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'active_effects';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActiveEffectsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActiveEffectsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      effectType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effect_type'],
      )!,
      multiplier: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}multiplier'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      relatedEventId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}related_event_id'],
      ),
    );
  }

  @override
  ActiveEffects createAlias(String alias) {
    return ActiveEffects(attachedDatabase, alias);
  }
}

class ActiveEffectsData extends DataClass
    implements Insertable<ActiveEffectsData> {
  final String id;
  final String effectType;
  final double multiplier;
  final DateTime startedAt;
  final DateTime expiresAt;
  final bool isActive;
  final String description;
  final int? relatedEventId;
  const ActiveEffectsData({
    required this.id,
    required this.effectType,
    required this.multiplier,
    required this.startedAt,
    required this.expiresAt,
    required this.isActive,
    required this.description,
    this.relatedEventId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['effect_type'] = Variable<String>(effectType);
    map['multiplier'] = Variable<double>(multiplier);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    map['is_active'] = Variable<bool>(isActive);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || relatedEventId != null) {
      map['related_event_id'] = Variable<int>(relatedEventId);
    }
    return map;
  }

  ActiveEffectsCompanion toCompanion(bool nullToAbsent) {
    return ActiveEffectsCompanion(
      id: Value(id),
      effectType: Value(effectType),
      multiplier: Value(multiplier),
      startedAt: Value(startedAt),
      expiresAt: Value(expiresAt),
      isActive: Value(isActive),
      description: Value(description),
      relatedEventId: relatedEventId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedEventId),
    );
  }

  factory ActiveEffectsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActiveEffectsData(
      id: serializer.fromJson<String>(json['id']),
      effectType: serializer.fromJson<String>(json['effectType']),
      multiplier: serializer.fromJson<double>(json['multiplier']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      description: serializer.fromJson<String>(json['description']),
      relatedEventId: serializer.fromJson<int?>(json['relatedEventId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'effectType': serializer.toJson<String>(effectType),
      'multiplier': serializer.toJson<double>(multiplier),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
      'isActive': serializer.toJson<bool>(isActive),
      'description': serializer.toJson<String>(description),
      'relatedEventId': serializer.toJson<int?>(relatedEventId),
    };
  }

  ActiveEffectsData copyWith({
    String? id,
    String? effectType,
    double? multiplier,
    DateTime? startedAt,
    DateTime? expiresAt,
    bool? isActive,
    String? description,
    Value<int?> relatedEventId = const Value.absent(),
  }) => ActiveEffectsData(
    id: id ?? this.id,
    effectType: effectType ?? this.effectType,
    multiplier: multiplier ?? this.multiplier,
    startedAt: startedAt ?? this.startedAt,
    expiresAt: expiresAt ?? this.expiresAt,
    isActive: isActive ?? this.isActive,
    description: description ?? this.description,
    relatedEventId: relatedEventId.present
        ? relatedEventId.value
        : this.relatedEventId,
  );
  ActiveEffectsData copyWithCompanion(ActiveEffectsCompanion data) {
    return ActiveEffectsData(
      id: data.id.present ? data.id.value : this.id,
      effectType: data.effectType.present
          ? data.effectType.value
          : this.effectType,
      multiplier: data.multiplier.present
          ? data.multiplier.value
          : this.multiplier,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      description: data.description.present
          ? data.description.value
          : this.description,
      relatedEventId: data.relatedEventId.present
          ? data.relatedEventId.value
          : this.relatedEventId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActiveEffectsData(')
          ..write('id: $id, ')
          ..write('effectType: $effectType, ')
          ..write('multiplier: $multiplier, ')
          ..write('startedAt: $startedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('isActive: $isActive, ')
          ..write('description: $description, ')
          ..write('relatedEventId: $relatedEventId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    effectType,
    multiplier,
    startedAt,
    expiresAt,
    isActive,
    description,
    relatedEventId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActiveEffectsData &&
          other.id == this.id &&
          other.effectType == this.effectType &&
          other.multiplier == this.multiplier &&
          other.startedAt == this.startedAt &&
          other.expiresAt == this.expiresAt &&
          other.isActive == this.isActive &&
          other.description == this.description &&
          other.relatedEventId == this.relatedEventId);
}

class ActiveEffectsCompanion extends UpdateCompanion<ActiveEffectsData> {
  final Value<String> id;
  final Value<String> effectType;
  final Value<double> multiplier;
  final Value<DateTime> startedAt;
  final Value<DateTime> expiresAt;
  final Value<bool> isActive;
  final Value<String> description;
  final Value<int?> relatedEventId;
  final Value<int> rowid;
  const ActiveEffectsCompanion({
    this.id = const Value.absent(),
    this.effectType = const Value.absent(),
    this.multiplier = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.description = const Value.absent(),
    this.relatedEventId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActiveEffectsCompanion.insert({
    required String id,
    required String effectType,
    this.multiplier = const Value.absent(),
    this.startedAt = const Value.absent(),
    required DateTime expiresAt,
    this.isActive = const Value.absent(),
    required String description,
    this.relatedEventId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       effectType = Value(effectType),
       expiresAt = Value(expiresAt),
       description = Value(description);
  static Insertable<ActiveEffectsData> custom({
    Expression<String>? id,
    Expression<String>? effectType,
    Expression<double>? multiplier,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? expiresAt,
    Expression<bool>? isActive,
    Expression<String>? description,
    Expression<int>? relatedEventId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (effectType != null) 'effect_type': effectType,
      if (multiplier != null) 'multiplier': multiplier,
      if (startedAt != null) 'started_at': startedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (isActive != null) 'is_active': isActive,
      if (description != null) 'description': description,
      if (relatedEventId != null) 'related_event_id': relatedEventId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActiveEffectsCompanion copyWith({
    Value<String>? id,
    Value<String>? effectType,
    Value<double>? multiplier,
    Value<DateTime>? startedAt,
    Value<DateTime>? expiresAt,
    Value<bool>? isActive,
    Value<String>? description,
    Value<int?>? relatedEventId,
    Value<int>? rowid,
  }) {
    return ActiveEffectsCompanion(
      id: id ?? this.id,
      effectType: effectType ?? this.effectType,
      multiplier: multiplier ?? this.multiplier,
      startedAt: startedAt ?? this.startedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      isActive: isActive ?? this.isActive,
      description: description ?? this.description,
      relatedEventId: relatedEventId ?? this.relatedEventId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (effectType.present) {
      map['effect_type'] = Variable<String>(effectType.value);
    }
    if (multiplier.present) {
      map['multiplier'] = Variable<double>(multiplier.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (relatedEventId.present) {
      map['related_event_id'] = Variable<int>(relatedEventId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActiveEffectsCompanion(')
          ..write('id: $id, ')
          ..write('effectType: $effectType, ')
          ..write('multiplier: $multiplier, ')
          ..write('startedAt: $startedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('isActive: $isActive, ')
          ..write('description: $description, ')
          ..write('relatedEventId: $relatedEventId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Themes extends Table with TableInfo<Themes, ThemesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Themes(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> themeKey = GeneratedColumn<String>(
    'theme_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> unlockCost = GeneratedColumn<int>(
    'unlock_cost',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<bool> isUnlocked = GeneratedColumn<bool>(
    'is_unlocked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_unlocked" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<String> primaryColor = GeneratedColumn<String>(
    'primary_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> secondaryColor = GeneratedColumn<String>(
    'secondary_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> backgroundColor = GeneratedColumn<String>(
    'background_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> surfaceColor = GeneratedColumn<String>(
    'surface_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> themeStyle = GeneratedColumn<String>(
    'theme_style',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    themeKey,
    name,
    description,
    unlockCost,
    isUnlocked,
    unlockedAt,
    isActive,
    primaryColor,
    secondaryColor,
    backgroundColor,
    surfaceColor,
    themeStyle,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'themes';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ThemesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ThemesData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      themeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_key'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      unlockCost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unlock_cost'],
      )!,
      isUnlocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_unlocked'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      primaryColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_color'],
      )!,
      secondaryColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondary_color'],
      )!,
      backgroundColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}background_color'],
      )!,
      surfaceColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}surface_color'],
      )!,
      themeStyle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_style'],
      )!,
    );
  }

  @override
  Themes createAlias(String alias) {
    return Themes(attachedDatabase, alias);
  }
}

class ThemesData extends DataClass implements Insertable<ThemesData> {
  final String id;
  final String themeKey;
  final String name;
  final String description;
  final int unlockCost;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final bool isActive;
  final String primaryColor;
  final String secondaryColor;
  final String backgroundColor;
  final String surfaceColor;
  final String themeStyle;
  const ThemesData({
    required this.id,
    required this.themeKey,
    required this.name,
    required this.description,
    required this.unlockCost,
    required this.isUnlocked,
    this.unlockedAt,
    required this.isActive,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.themeStyle,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['theme_key'] = Variable<String>(themeKey);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['unlock_cost'] = Variable<int>(unlockCost);
    map['is_unlocked'] = Variable<bool>(isUnlocked);
    if (!nullToAbsent || unlockedAt != null) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['primary_color'] = Variable<String>(primaryColor);
    map['secondary_color'] = Variable<String>(secondaryColor);
    map['background_color'] = Variable<String>(backgroundColor);
    map['surface_color'] = Variable<String>(surfaceColor);
    map['theme_style'] = Variable<String>(themeStyle);
    return map;
  }

  ThemesCompanion toCompanion(bool nullToAbsent) {
    return ThemesCompanion(
      id: Value(id),
      themeKey: Value(themeKey),
      name: Value(name),
      description: Value(description),
      unlockCost: Value(unlockCost),
      isUnlocked: Value(isUnlocked),
      unlockedAt: unlockedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockedAt),
      isActive: Value(isActive),
      primaryColor: Value(primaryColor),
      secondaryColor: Value(secondaryColor),
      backgroundColor: Value(backgroundColor),
      surfaceColor: Value(surfaceColor),
      themeStyle: Value(themeStyle),
    );
  }

  factory ThemesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ThemesData(
      id: serializer.fromJson<String>(json['id']),
      themeKey: serializer.fromJson<String>(json['themeKey']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      unlockCost: serializer.fromJson<int>(json['unlockCost']),
      isUnlocked: serializer.fromJson<bool>(json['isUnlocked']),
      unlockedAt: serializer.fromJson<DateTime?>(json['unlockedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      primaryColor: serializer.fromJson<String>(json['primaryColor']),
      secondaryColor: serializer.fromJson<String>(json['secondaryColor']),
      backgroundColor: serializer.fromJson<String>(json['backgroundColor']),
      surfaceColor: serializer.fromJson<String>(json['surfaceColor']),
      themeStyle: serializer.fromJson<String>(json['themeStyle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'themeKey': serializer.toJson<String>(themeKey),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'unlockCost': serializer.toJson<int>(unlockCost),
      'isUnlocked': serializer.toJson<bool>(isUnlocked),
      'unlockedAt': serializer.toJson<DateTime?>(unlockedAt),
      'isActive': serializer.toJson<bool>(isActive),
      'primaryColor': serializer.toJson<String>(primaryColor),
      'secondaryColor': serializer.toJson<String>(secondaryColor),
      'backgroundColor': serializer.toJson<String>(backgroundColor),
      'surfaceColor': serializer.toJson<String>(surfaceColor),
      'themeStyle': serializer.toJson<String>(themeStyle),
    };
  }

  ThemesData copyWith({
    String? id,
    String? themeKey,
    String? name,
    String? description,
    int? unlockCost,
    bool? isUnlocked,
    Value<DateTime?> unlockedAt = const Value.absent(),
    bool? isActive,
    String? primaryColor,
    String? secondaryColor,
    String? backgroundColor,
    String? surfaceColor,
    String? themeStyle,
  }) => ThemesData(
    id: id ?? this.id,
    themeKey: themeKey ?? this.themeKey,
    name: name ?? this.name,
    description: description ?? this.description,
    unlockCost: unlockCost ?? this.unlockCost,
    isUnlocked: isUnlocked ?? this.isUnlocked,
    unlockedAt: unlockedAt.present ? unlockedAt.value : this.unlockedAt,
    isActive: isActive ?? this.isActive,
    primaryColor: primaryColor ?? this.primaryColor,
    secondaryColor: secondaryColor ?? this.secondaryColor,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    surfaceColor: surfaceColor ?? this.surfaceColor,
    themeStyle: themeStyle ?? this.themeStyle,
  );
  ThemesData copyWithCompanion(ThemesCompanion data) {
    return ThemesData(
      id: data.id.present ? data.id.value : this.id,
      themeKey: data.themeKey.present ? data.themeKey.value : this.themeKey,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      unlockCost: data.unlockCost.present
          ? data.unlockCost.value
          : this.unlockCost,
      isUnlocked: data.isUnlocked.present
          ? data.isUnlocked.value
          : this.isUnlocked,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      primaryColor: data.primaryColor.present
          ? data.primaryColor.value
          : this.primaryColor,
      secondaryColor: data.secondaryColor.present
          ? data.secondaryColor.value
          : this.secondaryColor,
      backgroundColor: data.backgroundColor.present
          ? data.backgroundColor.value
          : this.backgroundColor,
      surfaceColor: data.surfaceColor.present
          ? data.surfaceColor.value
          : this.surfaceColor,
      themeStyle: data.themeStyle.present
          ? data.themeStyle.value
          : this.themeStyle,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ThemesData(')
          ..write('id: $id, ')
          ..write('themeKey: $themeKey, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('unlockCost: $unlockCost, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('isActive: $isActive, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('secondaryColor: $secondaryColor, ')
          ..write('backgroundColor: $backgroundColor, ')
          ..write('surfaceColor: $surfaceColor, ')
          ..write('themeStyle: $themeStyle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    themeKey,
    name,
    description,
    unlockCost,
    isUnlocked,
    unlockedAt,
    isActive,
    primaryColor,
    secondaryColor,
    backgroundColor,
    surfaceColor,
    themeStyle,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ThemesData &&
          other.id == this.id &&
          other.themeKey == this.themeKey &&
          other.name == this.name &&
          other.description == this.description &&
          other.unlockCost == this.unlockCost &&
          other.isUnlocked == this.isUnlocked &&
          other.unlockedAt == this.unlockedAt &&
          other.isActive == this.isActive &&
          other.primaryColor == this.primaryColor &&
          other.secondaryColor == this.secondaryColor &&
          other.backgroundColor == this.backgroundColor &&
          other.surfaceColor == this.surfaceColor &&
          other.themeStyle == this.themeStyle);
}

class ThemesCompanion extends UpdateCompanion<ThemesData> {
  final Value<String> id;
  final Value<String> themeKey;
  final Value<String> name;
  final Value<String> description;
  final Value<int> unlockCost;
  final Value<bool> isUnlocked;
  final Value<DateTime?> unlockedAt;
  final Value<bool> isActive;
  final Value<String> primaryColor;
  final Value<String> secondaryColor;
  final Value<String> backgroundColor;
  final Value<String> surfaceColor;
  final Value<String> themeStyle;
  final Value<int> rowid;
  const ThemesCompanion({
    this.id = const Value.absent(),
    this.themeKey = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.unlockCost = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.primaryColor = const Value.absent(),
    this.secondaryColor = const Value.absent(),
    this.backgroundColor = const Value.absent(),
    this.surfaceColor = const Value.absent(),
    this.themeStyle = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ThemesCompanion.insert({
    required String id,
    required String themeKey,
    required String name,
    required String description,
    required int unlockCost,
    this.isUnlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    required String primaryColor,
    required String secondaryColor,
    required String backgroundColor,
    required String surfaceColor,
    required String themeStyle,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       themeKey = Value(themeKey),
       name = Value(name),
       description = Value(description),
       unlockCost = Value(unlockCost),
       primaryColor = Value(primaryColor),
       secondaryColor = Value(secondaryColor),
       backgroundColor = Value(backgroundColor),
       surfaceColor = Value(surfaceColor),
       themeStyle = Value(themeStyle);
  static Insertable<ThemesData> custom({
    Expression<String>? id,
    Expression<String>? themeKey,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? unlockCost,
    Expression<bool>? isUnlocked,
    Expression<DateTime>? unlockedAt,
    Expression<bool>? isActive,
    Expression<String>? primaryColor,
    Expression<String>? secondaryColor,
    Expression<String>? backgroundColor,
    Expression<String>? surfaceColor,
    Expression<String>? themeStyle,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeKey != null) 'theme_key': themeKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (unlockCost != null) 'unlock_cost': unlockCost,
      if (isUnlocked != null) 'is_unlocked': isUnlocked,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (isActive != null) 'is_active': isActive,
      if (primaryColor != null) 'primary_color': primaryColor,
      if (secondaryColor != null) 'secondary_color': secondaryColor,
      if (backgroundColor != null) 'background_color': backgroundColor,
      if (surfaceColor != null) 'surface_color': surfaceColor,
      if (themeStyle != null) 'theme_style': themeStyle,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ThemesCompanion copyWith({
    Value<String>? id,
    Value<String>? themeKey,
    Value<String>? name,
    Value<String>? description,
    Value<int>? unlockCost,
    Value<bool>? isUnlocked,
    Value<DateTime?>? unlockedAt,
    Value<bool>? isActive,
    Value<String>? primaryColor,
    Value<String>? secondaryColor,
    Value<String>? backgroundColor,
    Value<String>? surfaceColor,
    Value<String>? themeStyle,
    Value<int>? rowid,
  }) {
    return ThemesCompanion(
      id: id ?? this.id,
      themeKey: themeKey ?? this.themeKey,
      name: name ?? this.name,
      description: description ?? this.description,
      unlockCost: unlockCost ?? this.unlockCost,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      isActive: isActive ?? this.isActive,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      themeStyle: themeStyle ?? this.themeStyle,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (themeKey.present) {
      map['theme_key'] = Variable<String>(themeKey.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (unlockCost.present) {
      map['unlock_cost'] = Variable<int>(unlockCost.value);
    }
    if (isUnlocked.present) {
      map['is_unlocked'] = Variable<bool>(isUnlocked.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (primaryColor.present) {
      map['primary_color'] = Variable<String>(primaryColor.value);
    }
    if (secondaryColor.present) {
      map['secondary_color'] = Variable<String>(secondaryColor.value);
    }
    if (backgroundColor.present) {
      map['background_color'] = Variable<String>(backgroundColor.value);
    }
    if (surfaceColor.present) {
      map['surface_color'] = Variable<String>(surfaceColor.value);
    }
    if (themeStyle.present) {
      map['theme_style'] = Variable<String>(themeStyle.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThemesCompanion(')
          ..write('id: $id, ')
          ..write('themeKey: $themeKey, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('unlockCost: $unlockCost, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('isActive: $isActive, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('secondaryColor: $secondaryColor, ')
          ..write('backgroundColor: $backgroundColor, ')
          ..write('surfaceColor: $surfaceColor, ')
          ..write('themeStyle: $themeStyle, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class DailyChallenges extends Table
    with TableInfo<DailyChallenges, DailyChallengesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DailyChallenges(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> challengeType = GeneratedColumn<String>(
    'challenge_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> targetCount = GeneratedColumn<int>(
    'target_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> currentProgress = GeneratedColumn<int>(
    'current_progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> pointReward = GeneratedColumn<int>(
    'point_reward',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    challengeType,
    title,
    description,
    targetCount,
    currentProgress,
    pointReward,
    isCompleted,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_challenges';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyChallengesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyChallengesData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      challengeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}challenge_type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      targetCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_count'],
      )!,
      currentProgress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_progress'],
      )!,
      pointReward: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}point_reward'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  DailyChallenges createAlias(String alias) {
    return DailyChallenges(attachedDatabase, alias);
  }
}

class DailyChallengesData extends DataClass
    implements Insertable<DailyChallengesData> {
  final String id;
  final DateTime date;
  final String challengeType;
  final String title;
  final String description;
  final int targetCount;
  final int currentProgress;
  final int pointReward;
  final bool isCompleted;
  final DateTime? completedAt;
  const DailyChallengesData({
    required this.id,
    required this.date,
    required this.challengeType,
    required this.title,
    required this.description,
    required this.targetCount,
    required this.currentProgress,
    required this.pointReward,
    required this.isCompleted,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['challenge_type'] = Variable<String>(challengeType);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['target_count'] = Variable<int>(targetCount);
    map['current_progress'] = Variable<int>(currentProgress);
    map['point_reward'] = Variable<int>(pointReward);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  DailyChallengesCompanion toCompanion(bool nullToAbsent) {
    return DailyChallengesCompanion(
      id: Value(id),
      date: Value(date),
      challengeType: Value(challengeType),
      title: Value(title),
      description: Value(description),
      targetCount: Value(targetCount),
      currentProgress: Value(currentProgress),
      pointReward: Value(pointReward),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory DailyChallengesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyChallengesData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      challengeType: serializer.fromJson<String>(json['challengeType']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      targetCount: serializer.fromJson<int>(json['targetCount']),
      currentProgress: serializer.fromJson<int>(json['currentProgress']),
      pointReward: serializer.fromJson<int>(json['pointReward']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'challengeType': serializer.toJson<String>(challengeType),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'targetCount': serializer.toJson<int>(targetCount),
      'currentProgress': serializer.toJson<int>(currentProgress),
      'pointReward': serializer.toJson<int>(pointReward),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  DailyChallengesData copyWith({
    String? id,
    DateTime? date,
    String? challengeType,
    String? title,
    String? description,
    int? targetCount,
    int? currentProgress,
    int? pointReward,
    bool? isCompleted,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => DailyChallengesData(
    id: id ?? this.id,
    date: date ?? this.date,
    challengeType: challengeType ?? this.challengeType,
    title: title ?? this.title,
    description: description ?? this.description,
    targetCount: targetCount ?? this.targetCount,
    currentProgress: currentProgress ?? this.currentProgress,
    pointReward: pointReward ?? this.pointReward,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  DailyChallengesData copyWithCompanion(DailyChallengesCompanion data) {
    return DailyChallengesData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      challengeType: data.challengeType.present
          ? data.challengeType.value
          : this.challengeType,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      targetCount: data.targetCount.present
          ? data.targetCount.value
          : this.targetCount,
      currentProgress: data.currentProgress.present
          ? data.currentProgress.value
          : this.currentProgress,
      pointReward: data.pointReward.present
          ? data.pointReward.value
          : this.pointReward,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyChallengesData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('challengeType: $challengeType, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('targetCount: $targetCount, ')
          ..write('currentProgress: $currentProgress, ')
          ..write('pointReward: $pointReward, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    challengeType,
    title,
    description,
    targetCount,
    currentProgress,
    pointReward,
    isCompleted,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyChallengesData &&
          other.id == this.id &&
          other.date == this.date &&
          other.challengeType == this.challengeType &&
          other.title == this.title &&
          other.description == this.description &&
          other.targetCount == this.targetCount &&
          other.currentProgress == this.currentProgress &&
          other.pointReward == this.pointReward &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt);
}

class DailyChallengesCompanion extends UpdateCompanion<DailyChallengesData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String> challengeType;
  final Value<String> title;
  final Value<String> description;
  final Value<int> targetCount;
  final Value<int> currentProgress;
  final Value<int> pointReward;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const DailyChallengesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.challengeType = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.targetCount = const Value.absent(),
    this.currentProgress = const Value.absent(),
    this.pointReward = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyChallengesCompanion.insert({
    required String id,
    required DateTime date,
    required String challengeType,
    required String title,
    required String description,
    required int targetCount,
    this.currentProgress = const Value.absent(),
    required int pointReward,
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       challengeType = Value(challengeType),
       title = Value(title),
       description = Value(description),
       targetCount = Value(targetCount),
       pointReward = Value(pointReward);
  static Insertable<DailyChallengesData> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? challengeType,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? targetCount,
    Expression<int>? currentProgress,
    Expression<int>? pointReward,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (challengeType != null) 'challenge_type': challengeType,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (targetCount != null) 'target_count': targetCount,
      if (currentProgress != null) 'current_progress': currentProgress,
      if (pointReward != null) 'point_reward': pointReward,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyChallengesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<String>? challengeType,
    Value<String>? title,
    Value<String>? description,
    Value<int>? targetCount,
    Value<int>? currentProgress,
    Value<int>? pointReward,
    Value<bool>? isCompleted,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return DailyChallengesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      challengeType: challengeType ?? this.challengeType,
      title: title ?? this.title,
      description: description ?? this.description,
      targetCount: targetCount ?? this.targetCount,
      currentProgress: currentProgress ?? this.currentProgress,
      pointReward: pointReward ?? this.pointReward,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (challengeType.present) {
      map['challenge_type'] = Variable<String>(challengeType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (targetCount.present) {
      map['target_count'] = Variable<int>(targetCount.value);
    }
    if (currentProgress.present) {
      map['current_progress'] = Variable<int>(currentProgress.value);
    }
    if (pointReward.present) {
      map['point_reward'] = Variable<int>(pointReward.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyChallengesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('challengeType: $challengeType, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('targetCount: $targetCount, ')
          ..write('currentProgress: $currentProgress, ')
          ..write('pointReward: $pointReward, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ChallengeQuestions extends Table
    with TableInfo<ChallengeQuestions, ChallengeQuestionsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ChallengeQuestions(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> challengeType = GeneratedColumn<String>(
    'challenge_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> correctAnswer = GeneratedColumn<String>(
    'correct_answer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> wrongAnswers = GeneratedColumn<String>(
    'wrong_answers',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
    'explanation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<int> timesUsed = GeneratedColumn<int>(
    'times_used',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<DateTime> lastUsed = GeneratedColumn<DateTime>(
    'last_used',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    challengeType,
    difficulty,
    question,
    correctAnswer,
    wrongAnswers,
    explanation,
    category,
    timesUsed,
    lastUsed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'challenge_questions';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChallengeQuestionsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChallengeQuestionsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      challengeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}challenge_type'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      question: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question'],
      )!,
      correctAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}correct_answer'],
      )!,
      wrongAnswers: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wrong_answers'],
      ),
      explanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explanation'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      timesUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}times_used'],
      )!,
      lastUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_used'],
      ),
    );
  }

  @override
  ChallengeQuestions createAlias(String alias) {
    return ChallengeQuestions(attachedDatabase, alias);
  }
}

class ChallengeQuestionsData extends DataClass
    implements Insertable<ChallengeQuestionsData> {
  final String id;
  final String challengeType;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final String? wrongAnswers;
  final String? explanation;
  final String? category;
  final int timesUsed;
  final DateTime? lastUsed;
  const ChallengeQuestionsData({
    required this.id,
    required this.challengeType,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    this.wrongAnswers,
    this.explanation,
    this.category,
    required this.timesUsed,
    this.lastUsed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['challenge_type'] = Variable<String>(challengeType);
    map['difficulty'] = Variable<String>(difficulty);
    map['question'] = Variable<String>(question);
    map['correct_answer'] = Variable<String>(correctAnswer);
    if (!nullToAbsent || wrongAnswers != null) {
      map['wrong_answers'] = Variable<String>(wrongAnswers);
    }
    if (!nullToAbsent || explanation != null) {
      map['explanation'] = Variable<String>(explanation);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['times_used'] = Variable<int>(timesUsed);
    if (!nullToAbsent || lastUsed != null) {
      map['last_used'] = Variable<DateTime>(lastUsed);
    }
    return map;
  }

  ChallengeQuestionsCompanion toCompanion(bool nullToAbsent) {
    return ChallengeQuestionsCompanion(
      id: Value(id),
      challengeType: Value(challengeType),
      difficulty: Value(difficulty),
      question: Value(question),
      correctAnswer: Value(correctAnswer),
      wrongAnswers: wrongAnswers == null && nullToAbsent
          ? const Value.absent()
          : Value(wrongAnswers),
      explanation: explanation == null && nullToAbsent
          ? const Value.absent()
          : Value(explanation),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      timesUsed: Value(timesUsed),
      lastUsed: lastUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsed),
    );
  }

  factory ChallengeQuestionsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChallengeQuestionsData(
      id: serializer.fromJson<String>(json['id']),
      challengeType: serializer.fromJson<String>(json['challengeType']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      question: serializer.fromJson<String>(json['question']),
      correctAnswer: serializer.fromJson<String>(json['correctAnswer']),
      wrongAnswers: serializer.fromJson<String?>(json['wrongAnswers']),
      explanation: serializer.fromJson<String?>(json['explanation']),
      category: serializer.fromJson<String?>(json['category']),
      timesUsed: serializer.fromJson<int>(json['timesUsed']),
      lastUsed: serializer.fromJson<DateTime?>(json['lastUsed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'challengeType': serializer.toJson<String>(challengeType),
      'difficulty': serializer.toJson<String>(difficulty),
      'question': serializer.toJson<String>(question),
      'correctAnswer': serializer.toJson<String>(correctAnswer),
      'wrongAnswers': serializer.toJson<String?>(wrongAnswers),
      'explanation': serializer.toJson<String?>(explanation),
      'category': serializer.toJson<String?>(category),
      'timesUsed': serializer.toJson<int>(timesUsed),
      'lastUsed': serializer.toJson<DateTime?>(lastUsed),
    };
  }

  ChallengeQuestionsData copyWith({
    String? id,
    String? challengeType,
    String? difficulty,
    String? question,
    String? correctAnswer,
    Value<String?> wrongAnswers = const Value.absent(),
    Value<String?> explanation = const Value.absent(),
    Value<String?> category = const Value.absent(),
    int? timesUsed,
    Value<DateTime?> lastUsed = const Value.absent(),
  }) => ChallengeQuestionsData(
    id: id ?? this.id,
    challengeType: challengeType ?? this.challengeType,
    difficulty: difficulty ?? this.difficulty,
    question: question ?? this.question,
    correctAnswer: correctAnswer ?? this.correctAnswer,
    wrongAnswers: wrongAnswers.present ? wrongAnswers.value : this.wrongAnswers,
    explanation: explanation.present ? explanation.value : this.explanation,
    category: category.present ? category.value : this.category,
    timesUsed: timesUsed ?? this.timesUsed,
    lastUsed: lastUsed.present ? lastUsed.value : this.lastUsed,
  );
  ChallengeQuestionsData copyWithCompanion(ChallengeQuestionsCompanion data) {
    return ChallengeQuestionsData(
      id: data.id.present ? data.id.value : this.id,
      challengeType: data.challengeType.present
          ? data.challengeType.value
          : this.challengeType,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      question: data.question.present ? data.question.value : this.question,
      correctAnswer: data.correctAnswer.present
          ? data.correctAnswer.value
          : this.correctAnswer,
      wrongAnswers: data.wrongAnswers.present
          ? data.wrongAnswers.value
          : this.wrongAnswers,
      explanation: data.explanation.present
          ? data.explanation.value
          : this.explanation,
      category: data.category.present ? data.category.value : this.category,
      timesUsed: data.timesUsed.present ? data.timesUsed.value : this.timesUsed,
      lastUsed: data.lastUsed.present ? data.lastUsed.value : this.lastUsed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChallengeQuestionsData(')
          ..write('id: $id, ')
          ..write('challengeType: $challengeType, ')
          ..write('difficulty: $difficulty, ')
          ..write('question: $question, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('wrongAnswers: $wrongAnswers, ')
          ..write('explanation: $explanation, ')
          ..write('category: $category, ')
          ..write('timesUsed: $timesUsed, ')
          ..write('lastUsed: $lastUsed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    challengeType,
    difficulty,
    question,
    correctAnswer,
    wrongAnswers,
    explanation,
    category,
    timesUsed,
    lastUsed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChallengeQuestionsData &&
          other.id == this.id &&
          other.challengeType == this.challengeType &&
          other.difficulty == this.difficulty &&
          other.question == this.question &&
          other.correctAnswer == this.correctAnswer &&
          other.wrongAnswers == this.wrongAnswers &&
          other.explanation == this.explanation &&
          other.category == this.category &&
          other.timesUsed == this.timesUsed &&
          other.lastUsed == this.lastUsed);
}

class ChallengeQuestionsCompanion
    extends UpdateCompanion<ChallengeQuestionsData> {
  final Value<String> id;
  final Value<String> challengeType;
  final Value<String> difficulty;
  final Value<String> question;
  final Value<String> correctAnswer;
  final Value<String?> wrongAnswers;
  final Value<String?> explanation;
  final Value<String?> category;
  final Value<int> timesUsed;
  final Value<DateTime?> lastUsed;
  final Value<int> rowid;
  const ChallengeQuestionsCompanion({
    this.id = const Value.absent(),
    this.challengeType = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.question = const Value.absent(),
    this.correctAnswer = const Value.absent(),
    this.wrongAnswers = const Value.absent(),
    this.explanation = const Value.absent(),
    this.category = const Value.absent(),
    this.timesUsed = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChallengeQuestionsCompanion.insert({
    required String id,
    required String challengeType,
    required String difficulty,
    required String question,
    required String correctAnswer,
    this.wrongAnswers = const Value.absent(),
    this.explanation = const Value.absent(),
    this.category = const Value.absent(),
    this.timesUsed = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       challengeType = Value(challengeType),
       difficulty = Value(difficulty),
       question = Value(question),
       correctAnswer = Value(correctAnswer);
  static Insertable<ChallengeQuestionsData> custom({
    Expression<String>? id,
    Expression<String>? challengeType,
    Expression<String>? difficulty,
    Expression<String>? question,
    Expression<String>? correctAnswer,
    Expression<String>? wrongAnswers,
    Expression<String>? explanation,
    Expression<String>? category,
    Expression<int>? timesUsed,
    Expression<DateTime>? lastUsed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (challengeType != null) 'challenge_type': challengeType,
      if (difficulty != null) 'difficulty': difficulty,
      if (question != null) 'question': question,
      if (correctAnswer != null) 'correct_answer': correctAnswer,
      if (wrongAnswers != null) 'wrong_answers': wrongAnswers,
      if (explanation != null) 'explanation': explanation,
      if (category != null) 'category': category,
      if (timesUsed != null) 'times_used': timesUsed,
      if (lastUsed != null) 'last_used': lastUsed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChallengeQuestionsCompanion copyWith({
    Value<String>? id,
    Value<String>? challengeType,
    Value<String>? difficulty,
    Value<String>? question,
    Value<String>? correctAnswer,
    Value<String?>? wrongAnswers,
    Value<String?>? explanation,
    Value<String?>? category,
    Value<int>? timesUsed,
    Value<DateTime?>? lastUsed,
    Value<int>? rowid,
  }) {
    return ChallengeQuestionsCompanion(
      id: id ?? this.id,
      challengeType: challengeType ?? this.challengeType,
      difficulty: difficulty ?? this.difficulty,
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      explanation: explanation ?? this.explanation,
      category: category ?? this.category,
      timesUsed: timesUsed ?? this.timesUsed,
      lastUsed: lastUsed ?? this.lastUsed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (challengeType.present) {
      map['challenge_type'] = Variable<String>(challengeType.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (correctAnswer.present) {
      map['correct_answer'] = Variable<String>(correctAnswer.value);
    }
    if (wrongAnswers.present) {
      map['wrong_answers'] = Variable<String>(wrongAnswers.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (timesUsed.present) {
      map['times_used'] = Variable<int>(timesUsed.value);
    }
    if (lastUsed.present) {
      map['last_used'] = Variable<DateTime>(lastUsed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChallengeQuestionsCompanion(')
          ..write('id: $id, ')
          ..write('challengeType: $challengeType, ')
          ..write('difficulty: $difficulty, ')
          ..write('question: $question, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('wrongAnswers: $wrongAnswers, ')
          ..write('explanation: $explanation, ')
          ..write('category: $category, ')
          ..write('timesUsed: $timesUsed, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class AppSettings extends Table with TableInfo<AppSettings, AppSettingsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  AppSettings(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> settingKey = GeneratedColumn<String>(
    'setting_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  late final GeneratedColumn<String> settingValue = GeneratedColumn<String>(
    'setting_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    settingKey,
    settingValue,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettingsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      settingKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}setting_key'],
      )!,
      settingValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}setting_value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  AppSettings createAlias(String alias) {
    return AppSettings(attachedDatabase, alias);
  }
}

class AppSettingsData extends DataClass implements Insertable<AppSettingsData> {
  final String id;
  final String settingKey;
  final String settingValue;
  final DateTime updatedAt;
  const AppSettingsData({
    required this.id,
    required this.settingKey,
    required this.settingValue,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['setting_key'] = Variable<String>(settingKey);
    map['setting_value'] = Variable<String>(settingValue);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      settingKey: Value(settingKey),
      settingValue: Value(settingValue),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSettingsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsData(
      id: serializer.fromJson<String>(json['id']),
      settingKey: serializer.fromJson<String>(json['settingKey']),
      settingValue: serializer.fromJson<String>(json['settingValue']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'settingKey': serializer.toJson<String>(settingKey),
      'settingValue': serializer.toJson<String>(settingValue),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSettingsData copyWith({
    String? id,
    String? settingKey,
    String? settingValue,
    DateTime? updatedAt,
  }) => AppSettingsData(
    id: id ?? this.id,
    settingKey: settingKey ?? this.settingKey,
    settingValue: settingValue ?? this.settingValue,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppSettingsData copyWithCompanion(AppSettingsCompanion data) {
    return AppSettingsData(
      id: data.id.present ? data.id.value : this.id,
      settingKey: data.settingKey.present
          ? data.settingKey.value
          : this.settingKey,
      settingValue: data.settingValue.present
          ? data.settingValue.value
          : this.settingValue,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsData(')
          ..write('id: $id, ')
          ..write('settingKey: $settingKey, ')
          ..write('settingValue: $settingValue, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, settingKey, settingValue, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsData &&
          other.id == this.id &&
          other.settingKey == this.settingKey &&
          other.settingValue == this.settingValue &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSettingsData> {
  final Value<String> id;
  final Value<String> settingKey;
  final Value<String> settingValue;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.settingKey = const Value.absent(),
    this.settingValue = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String id,
    required String settingKey,
    required String settingValue,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       settingKey = Value(settingKey),
       settingValue = Value(settingValue),
       updatedAt = Value(updatedAt);
  static Insertable<AppSettingsData> custom({
    Expression<String>? id,
    Expression<String>? settingKey,
    Expression<String>? settingValue,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (settingKey != null) 'setting_key': settingKey,
      if (settingValue != null) 'setting_value': settingValue,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? id,
    Value<String>? settingKey,
    Value<String>? settingValue,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      settingKey: settingKey ?? this.settingKey,
      settingValue: settingValue ?? this.settingValue,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (settingKey.present) {
      map['setting_key'] = Variable<String>(settingKey.value);
    }
    if (settingValue.present) {
      map['setting_value'] = Variable<String>(settingValue.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('settingKey: $settingKey, ')
          ..write('settingValue: $settingValue, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class SyncLogs extends Table with TableInfo<SyncLogs, SyncLogsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SyncLogs(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> syncType = GeneratedColumn<String>(
    'sync_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<bool> success = GeneratedColumn<bool>(
    'success',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("success" IN (0, 1))',
    ),
  );
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<int> notesSynced = GeneratedColumn<int>(
    'notes_synced',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> transactionsSynced = GeneratedColumn<int>(
    'transactions_synced',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<bool> progressSynced = GeneratedColumn<bool>(
    'progress_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("progress_synced" IN (0, 1))',
    ),
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> conflictsFound = GeneratedColumn<int>(
    'conflicts_found',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression(
      'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncType,
    success,
    errorMessage,
    notesSynced,
    transactionsSynced,
    progressSynced,
    conflictsFound,
    durationMs,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_logs';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncLogsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncLogsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      syncType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_type'],
      )!,
      success: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}success'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      notesSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notes_synced'],
      )!,
      transactionsSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transactions_synced'],
      )!,
      progressSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}progress_synced'],
      )!,
      conflictsFound: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}conflicts_found'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      ),
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      )!,
    );
  }

  @override
  SyncLogs createAlias(String alias) {
    return SyncLogs(attachedDatabase, alias);
  }
}

class SyncLogsData extends DataClass implements Insertable<SyncLogsData> {
  final String id;
  final String syncType;
  final bool success;
  final String? errorMessage;
  final int notesSynced;
  final int transactionsSynced;
  final bool progressSynced;
  final int conflictsFound;
  final int? durationMs;
  final DateTime syncedAt;
  const SyncLogsData({
    required this.id,
    required this.syncType,
    required this.success,
    this.errorMessage,
    required this.notesSynced,
    required this.transactionsSynced,
    required this.progressSynced,
    required this.conflictsFound,
    this.durationMs,
    required this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sync_type'] = Variable<String>(syncType);
    map['success'] = Variable<bool>(success);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['notes_synced'] = Variable<int>(notesSynced);
    map['transactions_synced'] = Variable<int>(transactionsSynced);
    map['progress_synced'] = Variable<bool>(progressSynced);
    map['conflicts_found'] = Variable<int>(conflictsFound);
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<int>(durationMs);
    }
    map['synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  SyncLogsCompanion toCompanion(bool nullToAbsent) {
    return SyncLogsCompanion(
      id: Value(id),
      syncType: Value(syncType),
      success: Value(success),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      notesSynced: Value(notesSynced),
      transactionsSynced: Value(transactionsSynced),
      progressSynced: Value(progressSynced),
      conflictsFound: Value(conflictsFound),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
      syncedAt: Value(syncedAt),
    );
  }

  factory SyncLogsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncLogsData(
      id: serializer.fromJson<String>(json['id']),
      syncType: serializer.fromJson<String>(json['syncType']),
      success: serializer.fromJson<bool>(json['success']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      notesSynced: serializer.fromJson<int>(json['notesSynced']),
      transactionsSynced: serializer.fromJson<int>(json['transactionsSynced']),
      progressSynced: serializer.fromJson<bool>(json['progressSynced']),
      conflictsFound: serializer.fromJson<int>(json['conflictsFound']),
      durationMs: serializer.fromJson<int?>(json['durationMs']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'syncType': serializer.toJson<String>(syncType),
      'success': serializer.toJson<bool>(success),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'notesSynced': serializer.toJson<int>(notesSynced),
      'transactionsSynced': serializer.toJson<int>(transactionsSynced),
      'progressSynced': serializer.toJson<bool>(progressSynced),
      'conflictsFound': serializer.toJson<int>(conflictsFound),
      'durationMs': serializer.toJson<int?>(durationMs),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  SyncLogsData copyWith({
    String? id,
    String? syncType,
    bool? success,
    Value<String?> errorMessage = const Value.absent(),
    int? notesSynced,
    int? transactionsSynced,
    bool? progressSynced,
    int? conflictsFound,
    Value<int?> durationMs = const Value.absent(),
    DateTime? syncedAt,
  }) => SyncLogsData(
    id: id ?? this.id,
    syncType: syncType ?? this.syncType,
    success: success ?? this.success,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    notesSynced: notesSynced ?? this.notesSynced,
    transactionsSynced: transactionsSynced ?? this.transactionsSynced,
    progressSynced: progressSynced ?? this.progressSynced,
    conflictsFound: conflictsFound ?? this.conflictsFound,
    durationMs: durationMs.present ? durationMs.value : this.durationMs,
    syncedAt: syncedAt ?? this.syncedAt,
  );
  SyncLogsData copyWithCompanion(SyncLogsCompanion data) {
    return SyncLogsData(
      id: data.id.present ? data.id.value : this.id,
      syncType: data.syncType.present ? data.syncType.value : this.syncType,
      success: data.success.present ? data.success.value : this.success,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      notesSynced: data.notesSynced.present
          ? data.notesSynced.value
          : this.notesSynced,
      transactionsSynced: data.transactionsSynced.present
          ? data.transactionsSynced.value
          : this.transactionsSynced,
      progressSynced: data.progressSynced.present
          ? data.progressSynced.value
          : this.progressSynced,
      conflictsFound: data.conflictsFound.present
          ? data.conflictsFound.value
          : this.conflictsFound,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncLogsData(')
          ..write('id: $id, ')
          ..write('syncType: $syncType, ')
          ..write('success: $success, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('notesSynced: $notesSynced, ')
          ..write('transactionsSynced: $transactionsSynced, ')
          ..write('progressSynced: $progressSynced, ')
          ..write('conflictsFound: $conflictsFound, ')
          ..write('durationMs: $durationMs, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncType,
    success,
    errorMessage,
    notesSynced,
    transactionsSynced,
    progressSynced,
    conflictsFound,
    durationMs,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncLogsData &&
          other.id == this.id &&
          other.syncType == this.syncType &&
          other.success == this.success &&
          other.errorMessage == this.errorMessage &&
          other.notesSynced == this.notesSynced &&
          other.transactionsSynced == this.transactionsSynced &&
          other.progressSynced == this.progressSynced &&
          other.conflictsFound == this.conflictsFound &&
          other.durationMs == this.durationMs &&
          other.syncedAt == this.syncedAt);
}

class SyncLogsCompanion extends UpdateCompanion<SyncLogsData> {
  final Value<String> id;
  final Value<String> syncType;
  final Value<bool> success;
  final Value<String?> errorMessage;
  final Value<int> notesSynced;
  final Value<int> transactionsSynced;
  final Value<bool> progressSynced;
  final Value<int> conflictsFound;
  final Value<int?> durationMs;
  final Value<DateTime> syncedAt;
  final Value<int> rowid;
  const SyncLogsCompanion({
    this.id = const Value.absent(),
    this.syncType = const Value.absent(),
    this.success = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.notesSynced = const Value.absent(),
    this.transactionsSynced = const Value.absent(),
    this.progressSynced = const Value.absent(),
    this.conflictsFound = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncLogsCompanion.insert({
    required String id,
    required String syncType,
    required bool success,
    this.errorMessage = const Value.absent(),
    this.notesSynced = const Value.absent(),
    this.transactionsSynced = const Value.absent(),
    this.progressSynced = const Value.absent(),
    this.conflictsFound = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       syncType = Value(syncType),
       success = Value(success);
  static Insertable<SyncLogsData> custom({
    Expression<String>? id,
    Expression<String>? syncType,
    Expression<bool>? success,
    Expression<String>? errorMessage,
    Expression<int>? notesSynced,
    Expression<int>? transactionsSynced,
    Expression<bool>? progressSynced,
    Expression<int>? conflictsFound,
    Expression<int>? durationMs,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncType != null) 'sync_type': syncType,
      if (success != null) 'success': success,
      if (errorMessage != null) 'error_message': errorMessage,
      if (notesSynced != null) 'notes_synced': notesSynced,
      if (transactionsSynced != null) 'transactions_synced': transactionsSynced,
      if (progressSynced != null) 'progress_synced': progressSynced,
      if (conflictsFound != null) 'conflicts_found': conflictsFound,
      if (durationMs != null) 'duration_ms': durationMs,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? syncType,
    Value<bool>? success,
    Value<String?>? errorMessage,
    Value<int>? notesSynced,
    Value<int>? transactionsSynced,
    Value<bool>? progressSynced,
    Value<int>? conflictsFound,
    Value<int?>? durationMs,
    Value<DateTime>? syncedAt,
    Value<int>? rowid,
  }) {
    return SyncLogsCompanion(
      id: id ?? this.id,
      syncType: syncType ?? this.syncType,
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
      notesSynced: notesSynced ?? this.notesSynced,
      transactionsSynced: transactionsSynced ?? this.transactionsSynced,
      progressSynced: progressSynced ?? this.progressSynced,
      conflictsFound: conflictsFound ?? this.conflictsFound,
      durationMs: durationMs ?? this.durationMs,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (syncType.present) {
      map['sync_type'] = Variable<String>(syncType.value);
    }
    if (success.present) {
      map['success'] = Variable<bool>(success.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (notesSynced.present) {
      map['notes_synced'] = Variable<int>(notesSynced.value);
    }
    if (transactionsSynced.present) {
      map['transactions_synced'] = Variable<int>(transactionsSynced.value);
    }
    if (progressSynced.present) {
      map['progress_synced'] = Variable<bool>(progressSynced.value);
    }
    if (conflictsFound.present) {
      map['conflicts_found'] = Variable<int>(conflictsFound.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncLogsCompanion(')
          ..write('id: $id, ')
          ..write('syncType: $syncType, ')
          ..write('success: $success, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('notesSynced: $notesSynced, ')
          ..write('transactionsSynced: $transactionsSynced, ')
          ..write('progressSynced: $progressSynced, ')
          ..write('conflictsFound: $conflictsFound, ')
          ..write('durationMs: $durationMs, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class DatabaseAtV2 extends GeneratedDatabase {
  DatabaseAtV2(QueryExecutor e) : super(e);
  late final Categories categories = Categories(this);
  late final Notes notes = Notes(this);
  late final ChallengeHistory challengeHistory = ChallengeHistory(this);
  late final ChaosEvents chaosEvents = ChaosEvents(this);
  late final PointTransactions pointTransactions = PointTransactions(this);
  late final UserProgress userProgress = UserProgress(this);
  late final Achievements achievements = Achievements(this);
  late final ActiveEffects activeEffects = ActiveEffects(this);
  late final Themes themes = Themes(this);
  late final DailyChallenges dailyChallenges = DailyChallenges(this);
  late final ChallengeQuestions challengeQuestions = ChallengeQuestions(this);
  late final AppSettings appSettings = AppSettings(this);
  late final SyncLogs syncLogs = SyncLogs(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categories,
    notes,
    challengeHistory,
    chaosEvents,
    pointTransactions,
    userProgress,
    achievements,
    activeEffects,
    themes,
    dailyChallenges,
    challengeQuestions,
    appSettings,
    syncLogs,
  ];
  @override
  int get schemaVersion => 2;
}
