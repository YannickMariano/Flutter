// lib/models/scanned_code.dart
class ScannedCode {
  final int? id;
  final String code;

  ScannedCode({this.id, required this.code});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
    };
  }

  @override
  String toString() {
    return 'ScannedCode{id: $id, code: $code}';
  }

  // Factory method to create a ScannedCode instance from a map
  factory ScannedCode.fromMap(Map<String, dynamic> map) {
    return ScannedCode(
      id: map['id'],
      code: map['code'],
    );
  }
}
