part of 'login_bloc.dart';

/* abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}
 */

class LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState({
    this.isEmailValid,
    this.isPasswordValid,
    this.isSubmitting,
    this.isSuccess,
    this.isFailure,
    this.errorMessage,
  });

  //https://dart.dev/guides/language/language-tour#constructors
  //Use the factory keyword when implementing a constructor that doesn’t always create a new instance of its class
  //factory constructors is initializing a final variable using logic that can’t be handled in the initializer list.
  //A factory constructor is generally used to control the instance creation.
  //A factory Constructor does not have access to 'this' object
  //A factory constructor can return value from cache or from an instance of a sub-type.
  //A factory constructors are like static methods whose return type is the class itself.
  //A factory function is a function that returns an instance of a class.
  //Proper use case of factory constructor:
  //- Use factory constructor when creating a new instance of an existing class is too expensive
  //- Creating only one instance of the class.
  //- For returning sub-class instance of the class instead of the class itself.
  //this is factory function
  factory LoginState.initial() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: "",
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      errorMessage: "",
    );
  }

  factory LoginState.failure(String errorMessage) {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      errorMessage: "",
    );
  }

  LoginState update({
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: "",
    );
  }

  LoginState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    String errorMessage,
  }) {
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
