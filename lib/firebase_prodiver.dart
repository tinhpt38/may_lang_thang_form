import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider {
  static FirebaseProvider _intances = FirebaseProvider._internal();

  FirebaseProvider._internal();

  factory FirebaseProvider() => _intances;
}
