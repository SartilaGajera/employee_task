import 'package:employee_task/config/app_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final hiveService = HiveService();
  await hiveService.init();

  runApp(MyApp(hiveService: hiveService));
}

class MyApp extends StatelessWidget {
  final HiveService hiveService;
  const MyApp({super.key, required this.hiveService});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => EmployeeBloc(hiveService)..add(LoadEmployees()))],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          title: AppConstant.appTitle,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundColor,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor, primary: AppColors.primaryColor),
            useMaterial3: true,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontWeight: FontWeight.w700),
              bodyMedium: TextStyle(),
              bodySmall: TextStyle(),
              labelLarge: TextStyle(),
              labelMedium: TextStyle(),
              labelSmall: TextStyle(),
              titleLarge: TextStyle(fontWeight: FontWeight.w600),
              titleMedium: TextStyle(),
              titleSmall: TextStyle(),
              displayLarge: TextStyle(),
              displayMedium: TextStyle(),
              displaySmall: TextStyle(),
            ).apply(bodyColor: AppColors.primaryColor, fontFamily: AppConstant.fontFamily),
          ),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
