import 'package:coding_challenge/core/helper/helper.dart';
import 'package:coding_challenge/core/widget/custom_text_field.dart';
import 'package:coding_challenge/features/absences/view/widget/absences_list_view_widget.dart';
import 'package:coding_challenge/features/absences/view/widget/smart_refresh.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: CustomTextField(
              placeholder: "Search",
              onChange: state.onSearchChanged,
            ),
          ),
         Obx(() =>  Expanded(
           child: SmartRefresh(
             onLoading: state.onLoading,
             onRefresh: state.onRefresh,
             child: ListView.builder(
                 itemCount: state.listAbsences.value.length,
                 itemBuilder: (BuildContext context, int index){
                   return  Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                     child: HomeViewWidget(absencesPayload: state.listAbsences.value[index],),
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
