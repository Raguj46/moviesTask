import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../model/movielistmodel.dart';
import '../widget/constantvalue.dart';
part 'movielist_state.dart';

class MovielistCubit extends Cubit<MovielistState> {
  MovielistCubit() : super(MovielistInitial());
  List<MovieListModel> datalist=[];
  Future<void> GetmovieList() async {
    emit(MovielistLoading());
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/4/list/1'),
      // Send authorization headers to the backend.
      headers: {
        "Authorization" : Constantsvlaue.Authorization,
        "Content-Type" : Constantsvlaue.ContentType,
      },
    );
    Map<String,dynamic> responseJson = jsonDecode(response.body);
    print(responseJson);
    List<dynamic> data =responseJson['results'];

    data.forEach((element) {
      MovieListModel val =MovieListModel.fromJson(element);
      datalist.add(val);
    });
 emit(MovielistLoaded(datalist: datalist));
  }

  void search(String query){
    emit(MovielistLoading());
    List<MovieListModel> searchedData=[];
    datalist.forEach((element) {
      if(element.title!.toLowerCase().contains(query.toLowerCase()) || element.originalTitle!.toLowerCase().contains(query.toLowerCase())){
        searchedData.add(element);
      }
    });
    emit(MovielistLoaded(datalist: List.of(searchedData)));

  }

  void sort(int sort){

    if(sort==1) {
      datalist.sort((a,b)=>a.popularity!.compareTo(b.popularity!.toInt()));
      emit(MovielistLoaded(datalist: datalist));
    }else{
      datalist.sort((b,a)=>a.popularity!.compareTo(b.popularity!.toInt()));
      emit(MovielistLoaded(datalist: datalist));
    }
  }

}
