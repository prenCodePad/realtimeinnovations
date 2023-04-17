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
  @override
  List<Object?> get props => [id];
}
