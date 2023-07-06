// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CompanyModule {
  String? uid;
  String? name;
  String? logoAsset;
  CompanyModule({
    this.uid,
    this.name,
    this.logoAsset,
  });

  CompanyModule copyWith({
    String? uid,
    String? name,
    String? logoAsset,
  }) {
    return CompanyModule(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      logoAsset: logoAsset ?? this.logoAsset,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'logoAsset': logoAsset,
    };
  }

  factory CompanyModule.fromMap(Map<String, dynamic> map) {
    return CompanyModule(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      logoAsset: map['logoAsset'] != null ? map['logoAsset'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModule.fromJson(String source) =>
      CompanyModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CompanyModule(uid: $uid, name: $name, logoAsset: $logoAsset)';

  @override
  bool operator ==(covariant CompanyModule other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.logoAsset == logoAsset;
  }

  @override
  int get hashCode => uid.hashCode ^ name.hashCode ^ logoAsset.hashCode;
}
