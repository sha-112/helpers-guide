import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebase user
  User? _userFromFirebaseUser(User? user)
  {
    // ignore: unnecessary_null_comparison
    return user;
  }

  //auth change user stream

  Stream<User?> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
    //.map((User? user) => _userFromFirebaseUser(user));
  }

  //sign in with email and password
  Future registerWithEmailAndPassword(String email, String password, String name) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      //create a new document for the user with id
      await user!.updateDisplayName(name);
      return _userFromFirebaseUser(user);
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }
  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch(e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }
}