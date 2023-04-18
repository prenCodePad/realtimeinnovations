import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String id;
  final String name;
  final String role;
  final DateTime from;
  final DateTime? to;

  const Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.from,
    this.to,
  });

  Employee.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        role = json['role'],
        from = DateTime.parse(json['from']),
        to = json['to'] == null ? null : DateTime.parse(json['to']);

  Map<String, dynamic> toJson() =>
      {'name': name, 'role': role, 'from': from.toIso8601String(), 'to': to?.toIso8601String(), 'id': id};
  @override
  List<Object?> get props => [id];
}
