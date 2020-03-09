import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lime_mobile_app/components/button.dart';
import 'package:lime_mobile_app/components/card.dart';
import 'package:lime_mobile_app/components/scaffold.dart';
import 'package:lime_mobile_app/models/project.dart';
import 'package:lime_mobile_app/models/store.dart';
import 'package:lime_mobile_app/values/colors.dart';
import 'package:lime_mobile_app/values/strings.dart';
import 'package:lime_mobile_app/values/theme.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';

SentryClient sentry;

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
    await DotEnv(env: appStore.env).load();
  } catch (e, t) {
    _reportError(e, t);
  }
}

void main() async {
  await _loadState();
  sentry = SentryClient(dsn: appStore.env['SENTRY_DSN']);

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
    () async => runApp(App()),
    onError: _reportError,
  );
}

class App extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  final StoreModel store;

  const App({Key key, this.store}) : super(key: key);

  @override
  _AppState createState() => _AppState();

  static Future pushPageRoute(
    Widget view, {
    String title,
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
        ChangeNotifierProvider<StoreModel>(
            create: (context) => widget.store ?? appStore),
      ],
      child: Consumer<StoreModel>(
        builder: (context, store, child) => MaterialApp(
          title: 'Lime',
          theme: theme(context),
          darkTheme: darkTheme(context),
          themeMode: store.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          navigatorKey: App.navigatorKey,
          debugShowCheckedModeBanner: false,
          home: HomeView(title: 'Lime Home Page'),
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

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _checked = false;

  bool get checked => _checked;

  @override
  Widget build(BuildContext context) {
    return LScaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Column(
                children: <Widget>[
                  LMiniButton('Mini Button', onPressed: null),
                  LMiniButton('Mini Button', onPressed: () {}),
                  LMiniButton(
                    'Mini Button',
                    onPressed: null,
                    icon: Icon(Icons.add, size: 16),
                  ),
                  LMiniButton(
                    'Mini Button',
                    onPressed: () {},
                    icon: Icon(Icons.add, size: 16),
                  ),
                  LMiniFlatButton('Mini Flat Button', onPressed: null),
                  LMiniFlatButton('Mini Flat Button', onPressed: () {}),
                  LCard(child: Text('Plain Card')),
                  LCheckCard(
                    checked,
                    (bool value) {
                      setState(() {
                        _checked = value;
                      });
                    },
                    label: 'LAPL - Project SVG',
                  ),
                  LCard(
                    flush: true,
                    onTap: () {},
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: checked,
                          onChanged: (bool value) {
                            setState(() {
                              _checked = value;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            'Plain Card',
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: LProjectCard(
                          ProjectModel(label: 'SAPS Project'),
                          context: context,
                        ),
                      ),
                      Expanded(
                        child: LProjectCard(
                          ProjectModel(label: 'Operations VC'),
                          context: context,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: LProjectCard(
                          ProjectModel(
                            label: 'Market research product testing',
                          ),
                          context: context,
                          iconData: Icons.assignment,
                          iconColor: LColors.purpleColor,
                        ),
                      ),
                      Expanded(
                        child: LProjectCard(
                          ProjectModel(label: 'Operations VC'),
                          context: context,
                          iconData: Icons.content_paste,
                          iconColor: LColors.purpleColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: LButtonCard(
                          label: 'New Responses goes here',
                          context: context,
                          color: LColors.primaryLightColor,
                          trailing: Text(
                            '20',
                            style: TextStyle(
                              fontFamily: Strings.app.font,
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              height: 1.33,
                              color: LColors.grayColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: LButtonCard(
                          label: 'SAPS Project',
                          context: context,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: LSummaryCard(
                          label: 'Total\nSurveys',
                          context: context,
                          color: LColors.primaryLightColor,
                          value: '20',
                        ),
                      ),
                      Expanded(
                        child: LSummaryCard(
                          label: 'Active Surveys',
                          context: context,
                          color: LColors.primaryLightColor,
                          value: '20',
                        ),
                      ),
                      Expanded(
                        child: LSummaryCard(
                          label: 'Draft Surveys',
                          context: context,
                          color: LColors.primaryLightColor,
                          value: '20',
                        ),
                      ),
                    ],
                  ),
                  LProjectDetailsCard(
                    ProjectModel(
                      label: 'Operations VC',
                      country: 'Nigeria',
                      dateCreated: '10th of January 2020',
                      description:
                          'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
                    ),
                    context: context,
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
