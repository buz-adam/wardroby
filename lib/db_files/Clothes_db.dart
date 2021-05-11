import 'package:wardroby/models/model.dart';

class Clothes_DB extends Model {
  int id;
  String address;
  String type;
  String note;

  static String table = 'Clothes_table';

  Clothes_DB({this.id, this.address, this.type, this.note});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {'address': address, 'type': type, 'note': note};

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static Clothes_DB fromMap(Map<String, dynamic> map) {
    return Clothes_DB(
        id: map['id'],
        address: map['address'],
        type: map['type'],
        note: map['note']);
}
}

