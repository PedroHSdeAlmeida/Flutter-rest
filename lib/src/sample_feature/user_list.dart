import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<dynamic> users = [];

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body);
      });
    } else {
      print('Erro na requisição: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuários'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          // Alterna as cores de fundo
          final backgroundColor = index % 2 == 0 ? Colors.grey[200] : Colors.white;

          return Container(
            color: backgroundColor,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome: ${user['name']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Email: ${user['email']}'),
                Text('Telefone: ${user['phone']}'),
                Text('Website: ${user['website']}'),
                const SizedBox(height: 10),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
