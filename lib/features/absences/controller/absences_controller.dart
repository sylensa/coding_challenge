import 'dart:developer';

import 'package:coding_challenge/core/http/http_client_wrapper.dart';
import 'package:coding_challenge/core/utils/app_url.dart';
import 'package:coding_challenge/features/absences/model/absences_model.dart';
import 'package:get/get.dart';



class AbsencesController extends GetxController{
  final HttpClientWrapper _http = HttpClientWrapper();

  final Rx<List<AbsencesModel>> listAbsences = Rx<List<AbsencesModel>>([]);

  @override
  void onInit() {
    super.onInit();
    getAbsencesData();

  }
  getAbsencesData()async{
    List<dynamic> response  =  await _http.getRequest(AppUrl.absences);
    listAbsences.value = response.map((e) => AbsencesModel.fromJson(e)).toList();
    log("response:${listAbsences.value}");
  }

  getMembersData()async{
    List<dynamic> response  =  await _http.getRequest(AppUrl.members);
    listAbsences.value = response.map((e) => AbsencesModel.fromJson(e)).toList();
    log("response:${listAbsences.value}");
  }


}

