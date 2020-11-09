import 'package:bloc_trial/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeBloc homeBloc;
  @override
  Widget build(BuildContext context){
    homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      body: BlocBuilder<HomeBloc,HomeState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is HomeInitialState){
            return buildInitalUi();
          }
          else if(state is HomeLoadingState){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(state is HomeCompleteState){
            return buildDataLoadUi(state.data);
          }
          else if(state is HomeFailureState){
            return buildFailedUi(state.message);
          }
        },
      ),
    );
  }
  Widget buildInitalUi() {
    return Center(
      child: FlatButton(
        color: Colors.blue,
        child: Text("Load Data"),
        onPressed: () {
          homeBloc.add(DataLoadEvent());
        },
      ),
    );
  }
  Widget buildDataLoadUi(String data) {
    return Container(
      color: Colors.green,
      alignment: Alignment.center,
      child: Text(data),
    );
  }
  Widget buildFailedUi(String msg) {
    return Center(
      child: Container(
        color: Colors.red,
        child: Text(msg),
      ),
    );
  }
}
