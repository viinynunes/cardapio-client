import 'package:cardapio/modules/login/errors/login_errors.dart';
import 'package:cardapio/modules/login/infra/datasources/i_logged_user_datasource.dart';
import 'package:cardapio/modules/login/infra/datasources/i_login_datasource.dart';
import 'package:cardapio/modules/login/infra/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatasource implements ILoginDatasource {
  final ILoggedUserDatasource _loggedUserDatasource;

  FirebaseDatasource(this._loggedUserDatasource);

  final _auth = FirebaseAuth.instance;

  User? _firebaseUser;
  Map<String, dynamic> _userData = {};

  @override
  Future<UserModel> login(String email, String password) async {
    final signInResult = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) => throw LoginError('Incorrect email or password'));
    _firebaseUser = signInResult.user;

    await _loadCurrentUser();

    final user = await _loggedUserDatasource
        .saveLoggedUser(UserModel.fromMap(_userData))
        .catchError((e) => throw LoginError('Erro ao salvar o usuário'));

    return user;
  }

  @override
  Future<bool> logout() async {
    try {
      await _auth.signOut();
      _firebaseUser = null;
      _userData = {};

      return await _loggedUserDatasource.logout();
    } catch (e) {
      throw LoginError(e.toString());
    }
  }

  Future<void> _loadCurrentUser() async {
    _firebaseUser = _auth.currentUser;

    if (_firebaseUser != null) {
      if (_userData['name'] == null) {
        final docUser = await FirebaseFirestore.instance
            .collection('users')
            .doc(_firebaseUser!.uid)
            .get();

        _userData = docUser.data() as Map<String, dynamic>;
      }
    }
  }
}
