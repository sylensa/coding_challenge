import 'dart:developer';

import 'package:coding_challenge/core/http/http_client_wrapper.dart';
import 'package:coding_challenge/core/utils/app_url.dart';
import 'package:coding_challenge/features/absences/model/absences_model.dart';
import 'package:coding_challenge/features/absences/model/members_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';



class AbsencesController extends GetxController{
  final HttpClientWrapper _http = HttpClientWrapper();
  final RefreshController refreshController =  RefreshController(initialRefresh: false);

  final Rx<List<AbsencesPayload>> listAbsences = Rx<List<AbsencesPayload>>([]);
  final Rx<List<MembersPayload>> listMembers = Rx<List<MembersPayload>>([]);

  @override
  void onInit() {
    super.onInit();
    getAbsencesData();

  }
  getAbsencesData({int limit = 10, int offset = 0})async{
    List<dynamic> response  =  await _http.getRequest(AppUrl.absences);
   List<AbsencesPayload> payloads = response.map((e) => AbsencesPayload.fromJson(e)).toList();
    listAbsences.value.addAll(payloads);
    log("response:${listAbsences.value}");
  }

  getMembersData()async{
    List<dynamic> response  =  await _http.getRequest(AppUrl.members);
    listMembers.value = response.map((e) => MembersPayload.fromJson(e)).toList();
  }

  void onRefresh({int limit = 10, int offset = 0})async{
    listAbsences.value.clear();
    await getAbsencesData(limit: limit,offset: offset);
    listAbsences.refresh();
    refreshController.loadComplete();
  }
  void onLoading({int limit = 10, int offset = 0})async{
    await getAbsencesData(limit: limit,offset: offset);
    listAbsences.refresh();
    refreshController.refreshCompleted();
  }
}

