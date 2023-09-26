class Pengeluaran {
  int? id;
  late int valuePengeluaran;
  late String description;
  late String date;

  Pengeluaran({
    this.id,
    required this.valuePengeluaran,
    required this.description,
    required this.date,
  });

  factory Pengeluaran.fromMap(Map<String, dynamic> map) {
    return Pengeluaran(
      id: map['id'],
      valuePengeluaran: map['value_pengeluaran'],
      description: map['description'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    var mapping = <String, dynamic>{};
    if (id != null) {
      mapping['id'] = id;
    }
    mapping['value_pengeluaran'] = valuePengeluaran;
    mapping['description'] = description;
    mapping['date'] = date;

    return mapping;
  }
}
