import 'package:coding_challenge/core/helper/helper.dart';
import 'package:coding_challenge/core/utils/colors_utils.dart';
import 'package:coding_challenge/features/absences/controller/ican_controller.dart';
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
                Expanded(child: sText("Member Nam: ${state.getMembersName(absencesPayload.userId!)}",)),
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
                    sText("Period:${calculateDateDifference(convertToDateTime(absencesPayload.startDate!),convertToDateTime(absencesPayload.endDate!))} day(s)",color: appMainColor),
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
          sText("Status: ${state.absencesStatus(absencesPayload)}",),
          if(absencesPayload.memberNote.isNullOrBlank == false)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: sText("Member Note: ${absencesPayload.memberNote}",),
          ),
          if(absencesPayload.admitterNote.isNullOrBlank == false)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: sText("Admitter Note: ${absencesPayload.admitterNote}",),
          ),
          const SizedBox(height: 10,),
          InkWell(
            onTap: (){
              IcaController().launchOutlookEventButtonPressed(convertToDateTime(absencesPayload.startDate!),convertToDateTime(absencesPayload.endDate!));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              decoration: BoxDecoration(
                gradient: linearGradient,
                borderRadius: BorderRadius.circular(10)
              ),
              child: sText("ADD TO CALENDAR",color: Colors.white,size: 16,weight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
