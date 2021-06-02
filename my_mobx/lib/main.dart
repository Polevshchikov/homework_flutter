import 'package:flutter/material.dart';
import 'package:my_mobx/pages/home_page.dart';
import 'package:my_mobx/pages/job_page.dart';
import 'package:my_mobx/store/job_store.dart';
import 'package:provider/provider.dart';

import 'locator_service.dart';
import 'models/job.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sl.registerSingletonAsync<Services>(() async {
    final _services = Services();
    _services.init();
    return _services;
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<JobStore>(
      create: (context) => JobStore(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            final argument = settings.arguments;

            if (settings.name == '/') {
              return MaterialPageRoute(
                builder: (context) => const HomePage(),
              );
            }

            if (settings.name == '/jobPage') {
              return MaterialPageRoute(
                builder: (context) => JobPage(job: argument as Job),
              );
            }
            return null;
          }),
    );
  }
}
