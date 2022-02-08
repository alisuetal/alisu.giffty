import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giffty_flutter/models/event.dart';
import 'package:giffty_flutter/screens/event_details_page.dart';
import 'package:giffty_flutter/screens/home_screen.dart';
import 'package:giffty_flutter/utils/app_routes.dart';
import 'package:giffty_flutter/utils/palette.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF000000),
      systemNavigationBarColor: Color(0xFF000000),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Event(),
      child: MaterialApp(
        title: 'Giffty',
        theme: ThemeData(
          fontFamily: "Mirage",
          primarySwatch: palette,
          backgroundColor: palette.shade900,
          brightness: Brightness.dark,
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            headline2: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
            headline3: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            headline4: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: palette,
            ),
            headline5: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.HOME,
        routes: {
          AppRoutes.EVENT_DETAILS: (context) => EventDetailsPage(
              initialPrice: Provider.of<Event>(context, listen: false).price),
        },
      ),
    );
  }
}
