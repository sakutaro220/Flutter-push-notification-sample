import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification/notification_handler.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 5,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

Future<void> backgroundHandler(RemoteMessage message) async {
  // ここでメッセージを処理します
  logger.d('background message ${message.data}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  FirebaseMessaging.instance.getToken().then((String? token) {
    assert(token != null);
    logger.d('FCM Token: $token');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Push Notification Sample',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    NotificationHandler.init();
    listenNotifications();
  }

  void listenNotifications() {
    _firebaseMessaging.getInitialMessage().then((message) {
      if (message != null) {
        NotificationHandler.handleMessage(context, message);
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      NotificationHandler.handleMessage(context, message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      NotificationHandler.handleMessage(context, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text(
          'Welcome to Flutter Push Notification Sample!',
        ),
      ),
    );
  }
}
