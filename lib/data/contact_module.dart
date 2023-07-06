// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ContactModule {
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? message;
  ContactModule({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.message,
  });

  ContactModule copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    String? message,
  }) {
    return ContactModule(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (uid != null) 'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'message': message,
    };
  }

  factory ContactModule.fromMap(Map<String, dynamic> map) {
    return ContactModule(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModule.fromJson(String source) =>
      ContactModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ContactModule(uid: $uid, name: $name, email: $email, phone: $phone, message: $message)';
  }

  @override
  bool operator ==(covariant ContactModule other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.message == message;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        message.hashCode;
  }
}
