import 'package:demo_alayn_bloc/Data/model/home/home_model.dart';
import 'package:demo_alayn_bloc/business_logic/home/home_cubit.dart';
import 'package:demo_alayn_bloc/constants/enum_constant.dart';
import 'package:demo_alayn_bloc/constants/my_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).getContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: const WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus? mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  const Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  const CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = const Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
              body = const Text("release to load more");
            }
            else{
              body = const Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: BlocConsumer<HomeCubit,HomeState>(
          builder: (context,state){
            if(state is HomeInitial){
              return loading();
            }
            else if(state is HomeComplete){
              return form(model : state.model);
            }
            else if(state is HomeLoading){
              return loading();
            }
            else if(state is HomeError){
              return failed(retry);
            }
            else{
              return noData();
            }
          },
          listener: (context, state) {},
        ),
      )
    );
  }

  void _onRefresh(){
    BlocProvider.of<HomeCubit>(context).getContent();
    _refreshController.refreshCompleted();
  }

  void retry(){
    BlocProvider.of<HomeCubit>(context).getContent();
  }

  Widget form({HomeModel? model}){
    return model == null ? noData() :
      const Center(child: Text('Home'),);
  }
}
