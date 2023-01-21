import 'package:bloc/bloc.dart';
import 'package:demo_alayn_bloc/Data/model/home/home_model.dart';
import 'package:demo_alayn_bloc/Data/repository/home/home_repository.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository repository;

  HomeCubit(this.repository) : super(HomeInitial());

  Future<void> getContent() async{
    try{
      emit(HomeLoading());
      var res = await repository.getContent();
      emit(HomeComplete(res));
    }catch(ex){
      emit(HomeError(ex.toString()));
    }
  }
}
