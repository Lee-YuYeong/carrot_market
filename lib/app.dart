import 'package:fast_app_base/auth.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/fcm/fcm_manager.dart';
import 'package:fast_app_base/common/route/transition/fade_transition_page.dart';
import 'package:fast_app_base/common/theme/custom_theme_app.dart';
import 'package:fast_app_base/common/widget/w_round_button.dart';
import 'package:fast_app_base/entity/post/vo_simple_product_post.dart';
import 'package:fast_app_base/screen/main/s_main.dart';
import 'package:fast_app_base/screen/main/tab/tab_item.dart';
import 'package:fast_app_base/screen/post_detail/s_post_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'common/theme/custom_theme.dart';

class App extends ConsumerStatefulWidget {
  ///light, dark 테마가 준비되었고, 시스템 테마를 따라가게 하려면 해당 필드를 제거 하시면 됩니다.
  static const defaultTheme = CustomTheme.dark;
  static bool isForeground = true;
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();


  const App({super.key});

  @override
  ConsumerState<App> createState() => AppState();
}

class AppState extends ConsumerState<App> with  WidgetsBindingObserver, Nav {

  final ValueKey<String> _scaffoldKey = const ValueKey<String>('App scaffold');
   final _auth = DaangnAuth();
   @override
    GlobalKey<NavigatorState> get navigatorKey => App.navigatorKey;

  @override
  void initState() {
    super.initState();
    FcmManager.requestPermission();
    FcmManager.initialize(ref);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomThemeApp(
      child: Builder(builder: (context) {
        return DaangnAuthScope(
          notifier: _auth,
          child: MaterialApp.router(
            scaffoldMessengerKey: App.scaffoldMessengerKey,
            routerConfig: _router,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'Image Finder',
            theme: context.themeType.themeData,
            debugShowCheckedModeBanner: false,
          ),
        );
      }),
    );
  }

  late final GoRouter _router = GoRouter(
    navigatorKey: App.navigatorKey,
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        redirect: (_, __) => '/main',
      ),
      GoRoute(
        path: '/signin',
        pageBuilder: (BuildContext context, GoRouterState state) =>
        FadeTransitionPage(
          key: state.pageKey,
          child: Container(
            color: Colors.amber,
            child: Center(child: RoundButton(text: '로그인', onTap: () => _auth.signIn('rz', '1234'))),
          )
        ),
      ),
      GoRoute(
        path: '/main',
        redirect: (_, __) => '/main/home',
      ),
      GoRoute(
        path: '/productPost/:postId',
        redirect: (BuildContext context, GoRouterState state) =>
            '/main/home/${state.pathParameters['postId']}',
      ),
      GoRoute(
        path: '/main/:kind(home|localLife|nearMy|chat|my)',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            FadeTransitionPage(
          key: _scaffoldKey,
          child: MainScreen(
            firstTab: TabItem.find(state.pathParameters['kind'])
          ),
        ),
        routes: <GoRoute>[
          GoRoute(
            path: ':postId',
            builder: (BuildContext context, GoRouterState state) {
              final String postId = state.pathParameters['postId']!;
              if (state.extra != null) {
              final post = state.extra as SimpleProductPost;
              return PostDetailScreen(simpleProductPost: post, int.parse(postId));
              } else {
              return PostDetailScreen(int.parse(postId));
              }
            },
          ),
        ],
      ),
    ],
    // redirect: _auth.guard,
    refreshListenable: _auth,
    debugLogDiagnostics: true,
  );


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        App.isForeground = true;
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        App.isForeground = false;
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
  
 
}
