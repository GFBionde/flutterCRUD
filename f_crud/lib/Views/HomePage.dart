import 'package:flutter/material.dart';
import 'package:f_crud/Components/UserTile.dart';
import 'package:f_crud/Provider/UsersProvider.dart';
import 'package:f_crud/Routes/AppRoutes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final UsersProvider users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Fellowship Members"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: (){
            Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
          }),
        ],
      ),
      
      /* Lista de Exibição. */
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
      ),

    );
  }

}