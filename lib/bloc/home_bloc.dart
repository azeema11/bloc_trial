import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  HomeBloc() : super(HomeInitialState());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if(event is DataLoadEvent){
      try{
        yield HomeLoadingState();
        var response = await http.get("http://15.206.66.115/item/view/");
        if(response.statusCode == 200)
          yield HomeCompleteState(response.body);
        else{
          var x = json.decode(response.body);
          yield HomeFailureState(x['detail']);
        }
      } catch(e){
        yield HomeFailureState(e.toString());
      }
    }
  }
}
