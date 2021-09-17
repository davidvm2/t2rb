import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class T2RAppFirebaseUser {
  T2RAppFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

T2RAppFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<T2RAppFirebaseUser> t2RAppFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<T2RAppFirebaseUser>((user) => currentUser = T2RAppFirebaseUser(user));
