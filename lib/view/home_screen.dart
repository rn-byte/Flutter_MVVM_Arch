import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: <Widget>[
          Consumer<UserViewModel>(
            builder: (context, value, child) {
              return Container(
                margin: const EdgeInsets.only(right: 10),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                      onTap: () {
                        value.remove().then((value) {
                          Navigator.pushReplacementNamed(
                              context, RoutesName.login);
                        });
                      },
                      child: const Icon(Icons.logout_rounded)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
