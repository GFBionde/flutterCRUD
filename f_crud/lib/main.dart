import 'package:flutter/material.dart';
import 'package:f_crud/Provider/UsersProvider.dart';
import 'package:provider/provider.dart';
import 'Routes/AppRoutes.dart';
import 'Views/HomePage.dart';
import 'Views/UserForm.dart';

void main() {
  runApp(MyApp());
}

// This widget is the root of my application.
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => new UsersProvider(),
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,  
        
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        routes: {
          AppRoutes.HOME: (_) => HomePage(),
          AppRoutes.USER_FORM: (_) => UserForm(),
        }
      )
    );
  }

}
