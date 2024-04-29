import 'dart:async';
import 'dart:developer';

import 'package:coding_challenge/core/http/http_client_wrapper.dart';
import 'package:coding_challenge/core/utils/app_url.dart';
import 'package:coding_challenge/core/utils/response_codes.dart';
import 'package:coding_challenge/features/absences/model/absences_model.dart';
import 'package:coding_challenge/features/absences/model/members_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';



class AbsencesController extends GetxController{
  final HttpClientWrapper _http = HttpClientWrapper();
  final RefreshController refreshController =  RefreshController(initialRefresh: false);
  Timer? _debounce;
  final Rx<List<AbsencesPayload>> listAbsences = Rx<List<AbsencesPayload>>([]);
  final Rx<List<AbsencesPayload>> unFilteredListAbsences = Rx<List<AbsencesPayload>>([]);
  final Rx<List<MembersPayload>> listMembers = Rx<List<MembersPayload>>([]);
  final Rx<String> errorMessage = Rx<String>("");
  final Rx<bool> loading = Rx<bool>(true);
  final Rx<bool> paginationLoading = Rx<bool>(false);

  @override
  onReady() {
    super.onReady();
    // start all controller defaults
    start();
  }

  Future start({updateLoader = false}) async {
    return Future.wait([getAbsencesData(),getMembersData()]);
  }
  Future<void> getAbsencesData({int limit = 10, int offset = 0})async{
    AbsencesModel? absencesModel;
    errorMessage.value = "";
   try{
     var response  =  await _http.getRequest("${AppUrl.absences}&limit=$limit&offset=$offset");
     absencesModel = AbsencesModel.fromJson(response);
     if(absencesModel.message?.toUpperCase() == AppResponseCodes.success){
       listAbsences.value.addAll(absencesModel.payload!);
       unFilteredListAbsences.value.addAll(absencesModel.payload!);
     }else{
       errorMessage.value = absencesModel.message!;
     }
   }catch(e){
     errorMessage.value = absencesModel!.message!;
   }
    refreshData();
  }

  Future<void> getMembersData()async{
    MembersModel? membersModel;
   try{
     var response  =  await _http.getRequest(AppUrl.members);
     membersModel = MembersModel.fromJson(response);
     if(membersModel.message?.toUpperCase() == AppResponseCodes.success){
       listMembers.value.addAll(membersModel.membersPayload!);
     }else{
       errorMessage.value = membersModel.message!;
     }
   }catch(e){
     errorMessage.value = membersModel!.message!;
   }
    refreshData();
  }

  void onRefresh()async{
    paginationLoading.value = true;
    paginationLoading.refresh();
    listAbsences.value.clear();
    unFilteredListAbsences.value.clear();
    await getAbsencesData(limit: 10,offset: 0);
    refreshData();
    refreshController.loadComplete();
  }
  void onLoading()async{
    paginationLoading.value = true;
    paginationLoading.refresh();
    await getAbsencesData(limit: 10,offset:  listAbsences.value.length);
    refreshData();
    refreshController.refreshCompleted();
  }

  onSearchChanged(String value){
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 0), (){
      if(value.isNotEmpty){
        listAbsences.value.clear();
        listAbsences.value = unFilteredListAbsences.value.where((element) => element.type!.toLowerCase().contains(value.toLowerCase()) || element.startDate!.toLowerCase().contains(value.toLowerCase())
            || element.createdAt!.toLowerCase().contains(value.toLowerCase()) || element.confirmedAt!.toLowerCase().contains(value.toLowerCase())
            || element.rejectedAt!.toLowerCase().contains(value.toLowerCase())  || element.endDate!.toLowerCase().contains(value.toLowerCase())
        ).toList();
      }else{
        listAbsences.value.addAll(unFilteredListAbsences.value);
      }
    });
    refreshData();
  }
  filterAbsences(String type,String date){
      if(type.isNotEmpty  || date.isNotEmpty){
        listAbsences.value.clear();
        listAbsences.value = unFilteredListAbsences.value.where((element) => element.type!.toLowerCase().contains(type.toLowerCase()) || element.startDate!.toLowerCase().contains(date.toLowerCase())
            || element.endDate!.toLowerCase().contains(date.toLowerCase())
        ).toList();
      }else{
        listAbsences.value.addAll(unFilteredListAbsences.value);
      }

    refreshData();
  }

 String? getMembersName(int userId){
  try{
    return listMembers.value.where((element) => element.userId == userId).toList().first.name;
  }catch(e){
    return null;
  }
  }
  refreshData(){
    listMembers.refresh();
    listAbsences.refresh();
    errorMessage.refresh();
    unFilteredListAbsences.refresh();
    loading.value = false;
    loading.refresh();
    paginationLoading.value = false;
    paginationLoading.refresh();
  }

  absencesStatus(AbsencesPayload absencesPayload){
    if(absencesPayload.confirmedAt!.isNotEmpty){
      return "Confirmed";
    }else if(absencesPayload.rejectedAt!.isNotEmpty){
      return "Rejected";
    }else {
      return "Requested";
    }

  }
}

