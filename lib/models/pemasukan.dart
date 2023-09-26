class Pemasukan {
  int? id;
  late int valuePemasukan;
  late String description;
  late String date;

  Pemasukan({
    this.id,
    required this.valuePemasukan,
    required this.description,
    required this.date,
  });

  factory Pemasukan.fromMap(Map<String, dynamic> map) {
    return Pemasukan(
      id: map['id'],
      valuePemasukan: map['value_pemasukan'],
      description: map['description'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    var mapping = <String, dynamic>{};
    if (id != null) {
      mapping['id'] = id;
    }
    mapping['value_pemasukan'] = valuePemasukan;
    mapping['description'] = description;
    mapping['date'] = date;

    return mapping;
  }
}
