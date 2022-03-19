import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  // final String imagePath;
  final String id;
  final String email;
  final String name;
  final String nis;
  final int denda;

  const UserModel({
    // required this.imagePath,
    required this.id,
    required this.email,
    required this.denda,
    required this.nis,
    required this.name,
  });

  @override
  List<Object?> get props => [id, email, nis, denda, name];
}
