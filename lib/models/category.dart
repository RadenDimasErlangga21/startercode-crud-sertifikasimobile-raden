class Category {
  int? id; // Use int? to indicate that id can be nullable
  late String name;
  late String description;

  categoryMap() {
    var mapping = <String, dynamic>{};
    if (id != null) {
      mapping['id'] = id;
    }
    mapping['name'] = name;
    mapping['description'] = description;

    return mapping;
  }
}
