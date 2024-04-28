import 'package:coding_challenge/features/absences/view/widget/absences_list_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coding_challenge/features/absences/controller/absences_controller.dart';

import 'package:get/get.dart';

class AbsencesPage extends StatelessWidget {
  const AbsencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get.put(AbsencesController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [

        ],
      ),
      body: Column(
        children: [
          Obx(() =>  Expanded(
            child: ListView.builder(
                itemCount: state.listAbsences.value.length,
                itemBuilder: (BuildContext context, int index){
                  return  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Obx(() => HomeViewWidget(absencesModel: state.listAbsences.value[index],)),
                  );


                }),
          ))

        ],
      ),
    );
  }
}
