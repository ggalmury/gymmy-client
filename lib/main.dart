import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmy_client/bloc/routine_bloc.dart';
import 'package:gymmy_client/bloc/selected_date_bloc.dart';
import 'package:gymmy_client/properties/app_color.dart';
import 'package:gymmy_client/repositories/hive_provider.dart';
import 'package:gymmy_client/widgets/screens/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveProvider().init();
}

void main() async {
  await init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SelectedDateBloc(),
        ),
        BlocProvider(
          create: (context) => RoutineBloc(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko'),
        ],
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: AppColor.appColor,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
        ),
        home: const Index(),
      ),
    );
  }
}
