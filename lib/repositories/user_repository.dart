import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  /* UserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance; */

  UserRepository() : _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithCredential(
      String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    /* try {
      UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User firebaseUser = result.user;
      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    } */
  }

  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }
/*
  bool isSignedIn() {
    final currentUser = _firebaseAuth.currentUser;
    print("SUDAH SIGN IN: " + (currentUser != null).toString());
    return currentUser != null;
  }

  User getUser() {
    return _firebaseAuth.currentUser;
  } */

  Future<bool> isSignedIn() async {
    //final currentUser = await _firebaseAuth.currentUser;
    final currentUser = _firebaseAuth.currentUser;
    //print("SUDAH SIGN IN: " + (currentUser != null).toString());
    return currentUser != null;
  }

  //GOOGLE SIGN IN
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    //return await FirebaseAuth.instance.signInWithCredential(credential);

    UserCredential result =
        await _firebaseAuth.signInWithCredential(credential);

    //User firebaseUser = result.user;

    return result;
  }

  Future<User> getUser() async {
    //return await _firebaseAuth.currentUser;
    return _firebaseAuth.currentUser;
  }

  void updateDisplayName(displayName) {
    _firebaseAuth.currentUser.updateProfile(displayName: displayName);
  }
}
