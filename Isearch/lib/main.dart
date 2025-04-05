import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';

import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_page.dart';

final _log = Logger('MainApp'); // ✅ Scoped logger

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Setup logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
  });

  // ✅ Initialize Firebase
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyB07eQfa5TOxrh8PSWWKNyZ9XQ2gBIij-U",
          authDomain: "isearch-a8d14.firebaseapp.com",
          projectId: "isearch-a8d14",
          storageBucket: "isearch-a8d14.firebasestorage.app",
          messagingSenderId: "1024788827328",
          appId: "1:1024788827328:web:0518993811244f60277125",
          measurementId: "G-2DP5BPDBR1",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }

    _log.info('✅ Firebase initialized successfully');
  } catch (e) {
    _log.severe('❌ Firebase initialization failed: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _log.fine("Building MyApp widget");

    return MaterialApp(
      title: 'iSearch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const AuthStatusLogger(child: AuthWrapper()), // ✅ Log status at launch
    );
  }
}

/// ✅ Logs current user status at startup
class AuthStatusLogger extends StatefulWidget {
  final Widget child;
  const AuthStatusLogger({super.key, required this.child});

  @override
  State<AuthStatusLogger> createState() => _AuthStatusLoggerState();
}

class _AuthStatusLoggerState extends State<AuthStatusLogger> {
  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _log.info('✅ Logged in as: ${user.email}');
    } else {
      _log.info('❌ Not logged in');
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// ✅ Routes user based on login state
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    _log.fine("Checking auth state in AuthWrapper");

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          _log.fine("Waiting for auth state...");
          return const SplashScreen();
        } else if (snapshot.hasData) {
          _log.info("User is logged in: ${snapshot.data?.email}");
          return const HomeScreen();
        } else {
          _log.info("User is NOT logged in");
          return const LoginPage();
        }
      },
    );
  }
}
