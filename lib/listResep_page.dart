import 'package:appresep/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'bloc/resep/resep_bloc.dart';

class ListResepPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App Resep'), actions: <Widget>[
        Stack(children: <Widget>[
          IconButton(
              onPressed: () => Get.to(() => FavoritePage()),
              icon: Icon(Icons.favorite)),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Center(
                child: Text("2"),
              ),
            ),
          ),
        ])
      ]),
      body: BlocBuilder<ResepBloc, ResepState>(
        builder: (context, state) {
          if (state is ResepInitial) {
            context.read<ResepBloc>().add(ResepFetch());
            return CircularProgressIndicator();
          } else if (state is ResepLoaded) {
            return ListView.builder(
                itemCount: state.listmodel.length,
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                height: 50.0,
                                width: 50.0,
                                child: Image.network(
                                    state.listmodel[index].imageUrl),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(state.listmodel[index].title),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.alarm,
                                      size: 20.0,
                                    ),
                                    Text(
                                      state.listmodel[index].time + "min",
                                      style: TextStyle(fontSize: 10.0),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite,
                                size: 15.0,
                                color: state.listmodel[index].isFavorite
                                    ? Colors.red
                                    : Colors.grey),
                            onPressed: () {
                              // BlocProvider.of<ResepBloc>(context)
                              //     .add(ResepAdd(state.listmodel[index]));
                              !state.listmodel[index].isFavorite
                                  ? BlocProvider.of<ResepBloc>(context)
                                      .add(ResepAdd(state.listmodel[index]))
                                  : BlocProvider.of<ResepBloc>(context)
                                      .add(ResepDelete(state.listmodel[index]));
                            },
                          ),
                        ],
                      ),
                    ));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
