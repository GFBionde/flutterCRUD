import 'dart:math';

import 'package:flutter/material.dart';
import 'package:f_crud/Data/DummyUser.dart';
import 'package:f_crud/Models/User.dart';

/* Utiliza padrão de Observador. */
class UsersProvider with ChangeNotifier {
  final Map<String, User> _items = {...DUMMY_USER};

  /* Retorna um CLONE da variável items. */
  List<User> get all{
    return [..._items.values];
  }
  
  /* Retorna o tamanho da lista. */
  int get count{
    return _items.length;
  }
  
  /* Retorna um Usuario específico. */
  User byIndex(int i){
    return _items.values.elementAt(i);
  }

  /* Verifica e retorna se um usuário é válido. */
  bool _isValid(User user){
    if(user == null)
      return false;
    
    if(user.name == null || user.email == null)
      return false;

    if(user.name.trim() == '')
      return false;
    
    if(user.email.trim() == '')
      return false;

    return true;
  }

  /* Insere usuário caso não existe, altera usuário caso já existe.*/
  void put(User user){
    if(_isValid(user)){
      // Alterar novo usuário..
      if(_items.containsKey(user.id)){
        _items.update(user.id, (_) => User(
          id: user.id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ));
      }
      else{
        // Adicionar novo usuário..
        String id = Random().nextInt(1024).toString();

        _items.putIfAbsent(id, () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl, 
        ));
      }

      notifyListeners();
    }
  }

  /* Remove um usuário da lista.. */
  void remove(User user){
    if(user != null && user.id != null){
      _items.remove(user.id);
      notifyListeners();
    }
  } 

}