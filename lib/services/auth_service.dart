import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier
{
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _fireBaseToken = 'apikey';

  final storage = new FlutterSecureStorage();

  Future <String?> createUser(String email, String password) async
  {
    final Map<String, dynamic> authData =
    {
      'email'   : email,
      'password': password,
      'returnSecureToken' : true
    };

    final url = Uri.https(_baseUrl,'/v1/accounts:signUp',{'key' : _fireBaseToken});

    final resp = await http.post(url, body : json.encode(authData));

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if(decodeResp.containsKey('idToken'))
    {
      //return decodeResp['idToken'];
      storage.write(key: 'idtoken', value: decodeResp['idToken']);
      return null;
    }else
    {
      return decodeResp['error']['message'];
    }
  }
   Future <String?> login(String email, String password) async
  {
    final Map<String, dynamic> authData =
    {
      'email'   : email,
      'password': password,
      'returnSecureToken' : true
    };

    final url = Uri.https(_baseUrl,'/v1/accounts:signInWithPassword',{'key' : _fireBaseToken});

    final resp = await http.post(url, body : json.encode(authData));

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if(decodeResp.containsKey('idToken'))
    {
      //return decodeResp['idToken'];
      storage.write(key: 'idtoken', value: decodeResp['idToken']);
      return null;
    }else
    {
      return decodeResp['error']['message'];
    }
  }

  Future logout()async{

    await storage.delete(key: 'idtoken');
    return;
  }

  Future<String> readToken()async
  {
    return await storage.read(key: 'idtoken') ?? '';
  }


}