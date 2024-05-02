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

  // function called once the controller is instantiated
  @override
  onReady() {
    super.onReady();
    // start all controller defaults
    start();
  }

  // function to call these getAbsencesData(),getMembersData() concurrently
  Future start({updateLoader = false}) async {
    return Future.wait([getAbsencesData(),getMembersData()]);
  }

  // function to fetch Absences information through an api
  Future<void> getAbsencesData({int limit = 10, int offset = 0})async{
    AbsencesModel? absencesModel;
    errorMessage.value = "";
   try{
     // make a call to the absence api
     var response  =  await _http.getRequest("${AppUrl.absences}&limit=$limit&offset=$offset");
     absencesModel = AbsencesModel.fromJson(response);
     // check if the api call was successful
     if(absencesModel.message?.toUpperCase() == AppResponseCodes.success){
       // if the call is successful, it then append to listAbsences and unFilteredListAbsences
       listAbsences.value.addAll(absencesModel.payload!);
       unFilteredListAbsences.value.addAll(absencesModel.payload!);
     }else{
       // if the api call fails, then the error message is passed to errorMessage
       errorMessage.value = absencesModel.message!;
     }
   }catch(e){
     // this block catches any error message when the call fails un expectedly
     errorMessage.value = absencesModel!.message!;
   }
    // data refresh and th UI is rebuild
    refreshData();
  }

  // function to fetch members information through an api
  Future<void> getMembersData()async{
    MembersModel? membersModel;
   try{
     // make a call to the members api
     var response  =  await _http.getRequest(AppUrl.members);
     membersModel = MembersModel.fromJson(response);
     // check if the api call was successful
     if(membersModel.message?.toUpperCase() == AppResponseCodes.success){
       // if the call is successful, it then append to listMembers
       listMembers.value.addAll(membersModel.membersPayload!);
     }else{
       // if the api call fails, then the error message is passed to errorMessage
       errorMessage.value = membersModel.message!;
     }
   }catch(e){
     // this block catches any error message when the call fails un expectedly
     errorMessage.value = membersModel!.message!;
   }
    // data refresh and th UI is rebuild
    refreshData();
  }

  // function to refresh the list view
  void onRefresh()async{
    paginationLoading.value = true;
    paginationLoading.refresh();
    listAbsences.value.clear();
    unFilteredListAbsences.value.clear();
    await getAbsencesData(limit: 10,offset: 0);
    // data refresh and th UI is rebuild
    refreshData();
    refreshController.loadComplete();
  }
  // function to handle pagination while scrolling
  void onLoading()async{
    paginationLoading.value = true;
    paginationLoading.refresh();
    await getAbsencesData(limit: 10,offset:  listAbsences.value.length);
    // data refresh and th UI is rebuild
    refreshData();
    refreshController.refreshCompleted();
  }

  // function for searching using in the onChange function
  onSearchChanged(String value){
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 0), (){
      if(value.isNotEmpty){
        // if the value is not empty, then i check if the value contains in the various variables
        listAbsences.value.clear();
        listAbsences.value = unFilteredListAbsences.value.where((element) => element.type!.toLowerCase().contains(value.toLowerCase()) || element.startDate!.toLowerCase().contains(value.toLowerCase())
            || element.createdAt!.toLowerCase().contains(value.toLowerCase()) || element.confirmedAt!.toLowerCase().contains(value.toLowerCase())
            || element.rejectedAt!.toLowerCase().contains(value.toLowerCase())  || element.endDate!.toLowerCase().contains(value.toLowerCase())
        ).toList();
      }else{
        // if the value is empty then i append the previous list called unFilteredListAbsences
        listAbsences.value.addAll(unFilteredListAbsences.value);
      }
    });
    // data refresh and th UI is rebuild
    refreshData();
  }

  // filter absences by type and date
  filterAbsences(String type,String date){
      if(type.isNotEmpty  || date.isNotEmpty){
        listAbsences.value.clear();
        // comparing the filtered values when at least one is not empty
        listAbsences.value = unFilteredListAbsences.value.where((element) => element.type!.toLowerCase().contains(type.toLowerCase()) || element.startDate!.toLowerCase().contains(date.toLowerCase())
            || element.endDate!.toLowerCase().contains(date.toLowerCase())
        ).toList();
      }else{
        // when the filter is cleared then the list is reset
        listAbsences.value.addAll(unFilteredListAbsences.value);
      }
// data refresh and th UI is rebuild
    refreshData();
  }

 String? getMembersName(int userId){
  try{
    return listMembers.value.where((element) => element.userId == userId).toList().first.name;
  }catch(e){
    return null;
  }
  }
  // refreshing and rebuild the UI when there is a change in data
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

  // check the status of the absences
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

