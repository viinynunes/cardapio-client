import 'package:cardapio/modules/login/errors/login_errors.dart';
import 'package:cardapio/modules/login/infra/datasources/i_logged_client_datasource.dart';
import 'package:cardapio/modules/login/infra/datasources/i_login_datasource.dart';
import 'package:cardapio/modules/login/infra/models/client_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginFirebaseDatasource implements ILoginDatasource {
  final ILoggedClientDatasource _loggedClientDatasource;

  LoginFirebaseDatasource(this._loggedClientDatasource);

  final _auth = FirebaseAuth.instance;

  User? _firebaseUser;
  Map<String, dynamic> _clientData = {};

  @override
  Future<ClientModel> login(String email, String password) async {
    final signInResult = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) => throw LoginError('Email ou senha incorreta'));
    _firebaseUser = signInResult.user;

    _clientData = {};

    await _loadCurrentUser();

    final user = await _loggedClientDatasource
        .saveLoggedClient(ClientModel.fromMap(_clientData))
        .catchError((e) => throw LoginError('Erro ao salvar o usuário'));

    return user;
  }

  @override
  Future<bool> logout() async {
    try {
      await _auth.signOut();
      _firebaseUser = null;
      _clientData = {};

      return await _loggedClientDatasource.logout();
    } catch (e) {
      throw LoginError(e.toString());
    }
  }

  Future<void> _loadCurrentUser() async {
    _firebaseUser = _auth.currentUser;

    if (_firebaseUser != null) {
      if (_clientData['name'] == null) {
        final docUser = await FirebaseFirestore.instance
            .collection('clients')
            .doc(_firebaseUser!.uid)
            .get();

        _clientData = docUser.data() as Map<String, dynamic>;
        _clientData['id'] = docUser.id;
      }
    }
  }
}
