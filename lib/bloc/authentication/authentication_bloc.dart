import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  //Dalam Dart, colon atau ':' merupakan operator yang spesial
  //fungsinya adalah inisialisasi fields dalam kelas kita dengan input dari constructor
  //dalam hal ini, nilai _userRepository kelas di inisialisasi dengan userRepository yang merupakan input constructor dari kelas
  //colon ':' di constructor ini dinamakana 'Initializer list', dimana akan di run lebih dibanding superclass constructor dan main class constructor, urutannya:
  //1. Initializer list
  //2. super class constructor (super(AuthenticationInitial()))
  //3. main class constructor
  AuthenticationBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState();
    }
  }

  //AuthenticationLoggetOut
  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState() async* {
    yield AuthenticationFailure();
    _userRepository.signOut();
  }

  //AuthenticationLoggedIn
  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
    yield AuthenticationSuccess(await _userRepository.getUser());
    //yield AuthenticationSuccess(_userRepository.getUser());
  }

  //AuthenticationStarted :
  //1. periksa apakah session Login masih ada (isSignedIn)
  //2. Jika masih Sign In maka ambil current user dan kembalikan state AuthenticationSuccess, di main.dart akan tampilkan HomeScreen
  //3. Selain itu, kembalikan state Failure, dimana ditangkap main.dart akan tampilkan LoginScreen
  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    //final isSignedIn = _userRepository.isSignedIn();
    if (isSignedIn) {
      final firebaseuser = await _userRepository.getUser();
      //final firebaseuser = _userRepository.getUser();
      yield AuthenticationSuccess(firebaseuser);
    } else {
      yield AuthenticationFailure();
    }
  }
}
