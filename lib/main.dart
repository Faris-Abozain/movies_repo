import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/bloc/auth/auth_cubit.dart';
import 'modules/repository/auth_repository.dart';
import 'modules/routes/app_routes.dart';
import 'modules/routes/app_routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(AuthRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutesName.splash,
        routes: AppRoutes.routes,
      ),
    );
  }
}
