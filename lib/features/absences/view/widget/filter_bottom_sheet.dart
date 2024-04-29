import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:coding_challenge/core/helper/helper.dart';
import 'package:coding_challenge/core/utils/colors_utils.dart';
import 'package:coding_challenge/features/absences/controller/absences_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
String? absencesType;
DateTime? selectedDate;
marketPlaceFilter(BuildContext context){

  final state = Get.put(AbsencesController());
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent ,
      isScrollControlled: true,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder: (BuildContext context,StateSetter stateSetter){
            return Container(
              height: 400,
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  sText("Select Absences Type",size: 18, weight: FontWeight.w700),
                  SizedBox(height: 20,),
                  MaterialButton(
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      stateSetter(() {
                        absencesType = "vacation";
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(7),
                              decoration:  BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Color(0XFFD8DADC))
                              ),
                              child:  Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: absencesType ==  "vacation" ? linearGradient : null

                                ),
                              )
                          ),
                          const SizedBox(width: 10,),
                          sText("Vacation",weight: FontWeight.w500,size: 18,color: Colors.black,)
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      stateSetter(() {
                        absencesType = "sickness";
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(7),
                              decoration:  BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Color(0XFFD8DADC))
                              ),
                              child:  Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient:  absencesType == "sickness" ? linearGradient : null

                                ),
                              )
                          ),
                          const SizedBox(width: 10,),
                          sText("Sickness",weight: FontWeight.w500,size: 18,color: Colors.black,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                  InkWell(
                    onTap: () async {
                      final dateSelected =
                      await showCalendarDatePicker2Dialog(
                        value: [selectedDate ?? DateTime.now()],
                        context: context,
                        config:
                        CalendarDatePicker2WithActionButtonsConfig(
                            currentDate: selectedDate,
                            calendarType:
                            CalendarDatePicker2Type.single),
                        dialogSize: const Size(325, 400),
                        // value: _dates,
                        borderRadius: BorderRadius.circular(15),
                      );
                      if (dateSelected != null) {
                        stateSetter(() {
                          if (dateSelected.isNotEmpty) {
                            selectedDate = dateSelected.first;
                          }
                        });
                      }

                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                      decoration: BoxDecoration(
                        gradient: linearGradient,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: sText(selectedDate == null ? "Select date" : dateFormat(selectedDate!),color: Colors.white)),
                    ),
                  ),
                    Spacer(),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if(selectedDate != null  || selectedDate != null){
                        state.filterAbsences(absencesType ?? "", selectedDate != null ? dateFormat(selectedDate!) : "");
                      }
                    },
                    style: buttonStyle(buttonColor: absencesType != null  || selectedDate != null ? appMainColor : Colors.grey),
                    child: sText("Apply filters", color: Colors.white),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  InkWell(
                    onTap: () {
                      stateSetter(() {
                        Navigator.pop(context);
                        selectedDate = null;
                        absencesType = null;
                        state.filterAbsences(absencesType ?? "", selectedDate != null ? dateFormat(selectedDate!) : "");

                      });
                    },
                    child:Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: appMainColor,width: 2)
                              )
                          ),
                          child:  sText(
                              'Clear',
                              align: TextAlign.left,
                              color: appMainColor,
                              weight: FontWeight.w600,
                              size: 16
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          },

        );
      }
  );
}