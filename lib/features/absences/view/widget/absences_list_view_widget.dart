import 'package:coding_challenge/core/helper/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coding_challenge/features/absences/controller/absences_controller.dart';
import 'package:coding_challenge/features/absences/model/absences_model.dart';
import 'package:get/get.dart';

class HomeViewWidget extends StatelessWidget {
  final AbsencesPayload absencesPayload;
  const HomeViewWidget({super.key, required this.absencesPayload});

  @override
  Widget build(BuildContext context) {
    final state = Get.put(AbsencesController());

    return  Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.grey[100]!)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sText("Member Nam: ${state.getMembersName(absencesPayload.userId!)}",),
                sText("Absence Type: ${absencesPayload.type}",),

              ],
            ),
          const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sText("Period",),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sText("Start Date: ${absencesPayload.startDate}",),
                        sText("End Date: ${absencesPayload.endDate}",),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          const SizedBox(height: 5,),
          sText("Status: ",),
          const SizedBox(height: 5,),
          sText("Member Note: ${absencesPayload.memberNote}",),
          const SizedBox(height: 5,),
          sText("Admitter Note: ${absencesPayload.admitterNote}",),
        ],
      ),
    );
  }
}
