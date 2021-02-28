import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lime/models/store.dart';
import 'package:lime/values/theme.dart';
import 'package:lime/views/dashboard.dart';
import 'package:lime/views/login.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';
import 'package:shared_preferences/shared_preferences.dart';

SentryClient sentry;
String token;
Future<void> _reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');
  if (kDebugMode) {
    print(stackTrace);
  } else {
    try {
      final SentryResponse response = await sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
      if (response.isSuccessful) {
        print('Success! Event ID: ${response.eventId}');
      } else {
        print('Sending to Sentry.io was not successful: ${response.error}');
      }
    } catch (e) {
      print('An error prevented sending report to Sentry.io: $e');
    }
  }
}

_loadState() async {
  try {
    token = await App.getToken();
    await DotEnv(env: appStore.env).load();
  } catch (e, t) {
    _reportError(e, t);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _loadState();
  sentry = SentryClient(dsn: appStore.env['SENTRY_DSN'] ?? "fakeDsn");

  // handle flutter specific errors
  FlutterError.onError =
      (FlutterErrorDetails details, {bool forceReport = false}) {
    if (kDebugMode) {
      // Also use Flutter's pretty error logging to the device's console.
      FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  return await runZoned<Future<void>>(
    () async => runApp(App(token: token)),
    onError: _reportError,
  );
}

class App extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  final StoreModel store;
  final String token;

  const App({Key key, this.store, this.token}) : super(key: key);

  @override
  _AppState createState() => _AppState();

  static Future pushPageRoute(
    Widget view, {
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) {
    return navigatorKey.currentState.push(
      MaterialPageRoute(
        builder: (context) => view,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
        maintainState: maintainState,
      ),
    );
  }

  static Future<String> getToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }

  static Future<bool> setToken(String token) async {
    var prefs = await SharedPreferences.getInstance();
    return await prefs.setString('token', token);
  }

  static Future<String> getUname() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('uname') ?? "";
  }

  static Future<bool> setUname(String uname) async {
    var prefs = await SharedPreferences.getInstance();
    return await prefs.setString('uname', uname);
  }

  static Future pushNamed(String name, {Object arguments}) {
    return navigatorKey.currentState.pushNamed(name, arguments: arguments);
  }

  static pop<T extends Object>([T result]) {
    navigatorKey.currentState.pop(result);
  }
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    (widget.store ?? appStore).onChangePlatformBrightness(
        WidgetsBinding.instance.window.platformBrightness ??
            (widget.store ?? appStore).brightness);
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StoreModel>(create: (context) => StoreModel()),
      ],
      child: Consumer<StoreModel>(
        builder: (context, store, child) => MaterialApp(
          title: 'Lime',
          theme: theme(context),
          darkTheme: darkTheme(context),
          themeMode: store.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          navigatorKey: App.navigatorKey,
          debugShowCheckedModeBanner: false,
          home: token.isEmpty ? LoginView() : DashboardView(),
          supportedLocales: const [Locale('en')],
          localizationsDelegates: [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
