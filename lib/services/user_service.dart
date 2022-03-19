import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pintas_app/models/user_model.dart';

class UserService {
  CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'name': user.name,
        'nis': user.nis,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return UserModel(
          id: id,
          email: snapshot['email'],
          nis: snapshot['nis'],
          name: snapshot['name'],
          denda: 0);
    } catch (e) {
      throw e;
    }
  }
}
