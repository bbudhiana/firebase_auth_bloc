import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc/authentication/authentication_bloc.dart';
import './bloc/simple_bloc_observer.dart';
import './repositories/user_repository.dart';
import './screens/home_screen.dart';
import './screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //UNTUK DAPAT MENGGUNAKAN FIREBASE MAKA PERLU INISIALISASI, pasang paketnya firebase_core.dart
  await Firebase.initializeApp();
  //buat observasi
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();

  //Ketika program RUN langsung eksekusi event AuthenticationStarted()
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: userRepository)
        ..add(AuthenticationStarted()),
      child: MyApp(
        userRepository: userRepository,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  MyApp({UserRepository userRepository}) : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff6a515e),
        cursorColor: Color(0xff6a515e),
        /* primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity, 
        */
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (_, state) {
          if (state is AuthenticationFailure) {
            return LoginScreen(
              userRepository: _userRepository,
            );
          }
          if (state is AuthenticationSuccess) {
            return HomeScreen(
              user: state.firebaseUser,
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text("Loading"),
            ),
            body: Container(
              child: Center(
                child: Text("Loading"),
              ),
            ),
          );
        },
      ),
    );
  }
}
