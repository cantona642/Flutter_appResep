import 'package:appresep/bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite')),
      body: BlocBuilder<ResepBloc, ResepState>(
        builder: (context, state) {
          if (state is ResepInitial) {
            context.read<ResepBloc>().add(ResepFetch());
            return CircularProgressIndicator();
          } else if (state is ResepLoaded) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          BlocProvider.of<ResepBloc>(context)
                              .add(ResepDeleteAll());
                        },
                      ),
                      Text("hapus semua")
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: state.favorite.length,
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
                                          state.favorite[index].imageUrl),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(state.favorite[index].title),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.alarm,
                                            size: 20.0,
                                          ),
                                          Text(
                                            state.favorite[index].time,
                                            style: TextStyle(fontSize: 10.0),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    BlocProvider.of<ResepBloc>(context).add(
                                        ResepDelete(state.favorite[index]));
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          )),
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
