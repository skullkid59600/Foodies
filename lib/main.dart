import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:foodies/pages/auth/login/login_screen.dart';
import 'package:foodies/pages/index/index.dart';
import 'package:foodies/pages/splash_screen.dart';

import 'bloc/authentication_bloc/authentication_bloc.dart';
import 'bloc/authentication_bloc/authentication_event.dart';
import 'bloc/authentication_bloc/authentication_state.dart';
import 'bloc/simple_bloc_delegate.dart';
import 'data/repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAZSJC42-ONdAGQOQazbO-Yoob7vWVP89M",
      appId: "1:191347492240:android:0ab8ed8d5e3ddbb365df15",
      messagingSenderId: "XXX",
      projectId: "foodies-ac454",
    ),
  );
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final UserRepository userRepository = UserRepository(FirebaseAuth.instance);
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted()),
      child: App(userRepository: userRepository),
    )
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  const App({Key? key, required UserRepository userRepository})
    : _userRepository = userRepository,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return const SplashScreen();
          }
          if (state is Authenticated) {
            return const Index();
          }
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: _userRepository,);
          }
          return Container();
        },
      ),
    );
  }
}