import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coding_challenge/features/absences/controller/absences_controller.dart';
import 'package:coding_challenge/features/absences/model/absences_model.dart';
import 'package:get/get.dart';

class HomeViewWidget extends StatelessWidget {
  final AbsencesModel absencesModel;
  const HomeViewWidget({super.key, required this.absencesModel});

  @override
  Widget build(BuildContext context) {
    final state = Get.put(AbsencesController());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [


      ],
    );
  }
}
