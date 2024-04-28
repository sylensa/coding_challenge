import 'package:coding_challenge/core/helper/helper.dart';
import 'package:coding_challenge/features/absences/view/widget/absences_list_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coding_challenge/features/absences/controller/absences_controller.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AbsencesPage extends StatelessWidget {
   AbsencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.put(AbsencesController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Absences"),
        actions: const [

        ],
      ),
      body: Column(
        children: [
          Obx(() =>  Expanded(
            child: SmartRefresher(
      reverse: false,
      enablePullDown: true,
      enablePullUp: true,
      footer: CustomFooter(
        builder: (BuildContext context,LoadStatus? mode){
          Widget body ;
          if(mode==LoadStatus.idle){
            body =  sText("No more Data");
          }
          else if(mode==LoadStatus.loading){
            body =  const CupertinoActivityIndicator();
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
      controller: state.refreshController,
      onRefresh: state.onRefresh,
      onLoading: state.onLoading,
      child: ListView.builder(
          itemCount: state.listAbsences.value.length,
          itemBuilder: (BuildContext context, int index){
            return  Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(() => HomeViewWidget(absencesPayload: state.listAbsences.value[index],)),
            );

          }),
    )

            ,
          ))

        ],
      ),
    );
  }
}
