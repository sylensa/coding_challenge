import 'package:coding_challenge/core/helper/helper.dart';
import 'package:coding_challenge/features/absences/controller/absences_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// custom smart refresh for UI pagination
class SmartRefresh extends StatefulWidget {
  final Widget child;
  final Function onLoading;
  final Function onRefresh;
  const SmartRefresh({super.key, required this.child, required this.onLoading, required this.onRefresh});

  @override
  State<SmartRefresh> createState() => _SmartRefreshState();
}

class _SmartRefreshState extends State<SmartRefresh> {
  final RefreshController _refreshController =  RefreshController(initialRefresh: false);

  // pull to refresh the UI data
  void _onRefresh() async{
    setState(() {
      widget.onRefresh();
    });
    _refreshController.refreshCompleted();
  }

  // scroll to paginate the data on the UI
  void _onLoading() async{
    setState(() {
      widget.onLoading();
    });
    _refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
    final state = Get.put(AbsencesController());

    return SmartRefresher(
      reverse: false,
      enablePullDown: true,
      enablePullUp: true,
      footer: CustomFooter(
        builder: (BuildContext context,LoadStatus? mode){
          Widget body ;
          if(state.paginationLoading.value){
            body =  const CupertinoActivityIndicator();
          }
          else  if(mode==LoadStatus.idle){
            body =  sText("No more Data");
          }
          else if(mode == LoadStatus.failed){
            body = sText("Load Failed!Click retry!");
          }
          else if(mode == LoadStatus.canLoading){
            body = sText("release to load more");
          }
          else{
            body = const Text("No more Data");
          }
          return SizedBox(
            height: 55.0,
            child: Center(child:body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: widget.child,
    );
  }
}
