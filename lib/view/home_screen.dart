import 'package:flutter/material.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_mvvm/utils/utils.dart';
import 'package:flutter_mvvm/view_model/homeview_view_model.dart';
import 'package:flutter_mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import '../data/response/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeviewViewModel homeviewViewModel = HomeviewViewModel();
  @override
  void initState() {
    homeviewViewModel.fetchMoviesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final moviesPref = Provider.of<HomeviewViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
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
      body: ChangeNotifierProvider<HomeviewViewModel>(
        create: (context) => homeviewViewModel,
        child: Consumer<HomeviewViewModel>(builder: (context, value, child) {
          switch (value.moviesList.status) {
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.ERROR:
              return Center(
                child: Text(value.moviesList.message.toString()),
              );
            case Status.COMPLETED:
              return ListView.builder(
                itemCount: value.moviesList.data!.movies!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(
                      value.moviesList.data!.movies![index].posterurl
                          .toString(),
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.error,
                          color: Colors.red,
                        );
                      },
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                        value.moviesList.data!.movies![index].title.toString()),
                    subtitle: Text(
                        value.moviesList.data!.movies![index].year.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(Utils.averageRating(
                                value.moviesList.data!.movies![index].ratings!)
                            .toStringAsFixed(1)),
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  );
                },
              );
            default:
              return Container();
          }
        }),
      ),
    );
  }
}
