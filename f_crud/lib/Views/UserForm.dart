import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:f_crud/Models/User.dart';
import 'package:f_crud/Provider/UsersProvider.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User user){
    if(user != null){
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final User user = ModalRoute.of(context).settings.arguments;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New member"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){
              if(_form.currentState.validate()){
                _form.currentState.save();
                
                Provider.of<UsersProvider>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    name: _formData['name'],
                    email: _formData['email'],
                    avatarUrl: _formData['avatarUrl'],
                  ),
                );
                
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(15),
        
        child: Form(
          key: _form,
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              initialValue: _formData['name'],
              
              validator: (value) { 
                if(value == null || value.isEmpty) {
                  return 'Nome inválido!';
                }

                return null; 
              }, 

              onSaved: (value) => _formData['name'] = value,
            ),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'E-mail'),
              initialValue: _formData['email'],

              validator: (value) { 
                if(value == null || value.isEmpty) {
                  return "E-mail inválido!";
                }
                return null; 
              }, 
              
              onSaved: (value) => _formData['email'] = value,
            ),

            TextFormField(
              decoration: InputDecoration(labelText: 'Avatar URL'),
              initialValue: _formData['avatarUrl'],
              
              onSaved: (value) => _formData['avatarUrl'] = value,
            ),

          ],),
        
        ),
      ),
    
    );
  }
}