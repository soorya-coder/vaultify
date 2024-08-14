// ignore_for_file: constant_identifier_names, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaultify/object/vault.dart';

import '../constant/functions.dart';
import '../service/authHelper.dart';

class VaultHelper {

  static CollectionReference<Map<String, dynamic>> colvlt = FirebaseFirestore
      .instance
      .collection('/users/${AuthHelper.myuser!.uid}/vault');

  Stream<List<Vault>> getvaults() {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
    colvlt.orderBy('id').snapshots();
    Stream<List<Vault>> data = snapshots.map(
          (snapshot) => snapshot.docs
          .map((snapshot) => Vault.fromMap(snapshot.data()))
          .toList(),
    );
    return data;
  }

  Stream<Vault> getvault(String id) {
    DocumentReference<Map<String, dynamic>> docrefer = colvlt.doc(id);
    return docrefer.snapshots().map((data) => Vault.fromMap(data.data()!));
  }

  Future<void> addvault(Vault vault) async {
    vault.id = timenow;
    DocumentReference<Map<String, dynamic>> docrefer = colvlt.doc(vault.id);
    await docrefer.set(vault.toMap());
  }

  Future<void> editvault(Vault vault) async {
    DocumentReference<Map<String, dynamic>> docrefer = colvlt.doc(vault.id);
    await docrefer.update(vault.toMap());
  }

  Future<void> delvault(String id) async {
    DocumentReference<Map<String, dynamic>> docrefer = colvlt.doc(id);
    await docrefer.delete();
  }

}
