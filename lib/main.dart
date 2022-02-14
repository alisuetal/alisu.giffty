import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giffty_flutter/components/bottom_modal_widget.dart';
import 'package:giffty_flutter/components/dropdown_widget.dart';
import 'package:giffty_flutter/models/event.dart';
import 'package:giffty_flutter/screens/dark_pairs_screen.dart';
import 'package:giffty_flutter/screens/end_screen.dart';
import 'package:giffty_flutter/screens/event_details_screen.dart';
import 'package:giffty_flutter/screens/guests_screen.dart';
import 'package:giffty_flutter/screens/home_screen.dart';
import 'package:giffty_flutter/screens/instructions_screen.dart';
import 'package:giffty_flutter/screens/pair_reveal_screen.dart';
import 'package:giffty_flutter/utils/app_routes.dart';
import 'package:giffty_flutter/utils/palette.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'components/modal_widget.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: PaletteColor.secondary,
      systemNavigationBarColor: PaletteColor.secondary,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void _openHeaderModal(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return const ModalWidget(
          content: BottomModalWidget(),
        );
      },
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      constraints: const BoxConstraints(
        maxHeight: 580.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Event(),
      child: MaterialApp(
        title: 'Giffty',
        theme: ThemeData(
          fontFamily: "Coolvetica",
          primarySwatch: PaletteColor.palette,
          backgroundColor: PaletteColor.secondary,
          brightness: Brightness.dark,
          textTheme: TextTheme(
            headline1: const TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
            headline2: TextStyle(
              fontSize: 30,
              color: Colors.white.withOpacity(0.44),
            ),
            headline3: const TextStyle(
              fontSize: 24,
            ),
            headline4: const TextStyle(
              fontSize: 28,
            ),
            headline5: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        home: HomeScreen(
          headerFunction: (BuildContext context) => _openHeaderModal(context),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.HOME,
        routes: {
          AppRoutes.EVENT_DETAILS: (context) => EventDetailsScreen(
              initialPrice: Provider.of<Event>(context, listen: false).price,
              headerFunction: (BuildContext context) =>
                  _openHeaderModal(context)),
          AppRoutes.GUESTS: (context) => GuestsScreen(
              headerFunction: (BuildContext context) =>
                  _openHeaderModal(context)),
          AppRoutes.DARK_PAIRS: (context) => DarkPairsScreen(
              headerFunction: (BuildContext context) =>
                  _openHeaderModal(context)),
          AppRoutes.INSTRUCTIONS: (context) => InstructionsScreen(
              headerFunction: (BuildContext context) =>
                  _openHeaderModal(context)),
          AppRoutes.PAIR_REVEAL: (context) => PairRevealScreen(
              headerFunction: (BuildContext context) =>
                  _openHeaderModal(context),
              pairs: Provider.of<Event>(context, listen: false).pairs),
          AppRoutes.END: (context) => EndScreen(
              headerFunction: (BuildContext context) =>
                  _openHeaderModal(context))
        },
      ),
    );
  }
}
