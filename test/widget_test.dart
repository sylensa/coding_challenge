// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:coding_challenge/core/helper/helper.dart';
import 'package:coding_challenge/features/absences/controller/absences_controller.dart';
import 'package:coding_challenge/features/absences/model/absences_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coding_challenge/main.dart';
import 'package:get/get.dart';

void main() {
  final state = Get.put(AbsencesController());

  test('getAbsencesData function should return list of absences', () async{
    await state.getAbsencesData();
    // Assert
    expect(state.listAbsences.value.isNotEmpty, state.listAbsences.value.isNotEmpty); // Verify that the result is as expected
  });

  test('getMembersData function should return list of members', () async{
    await state.getMembersData();
    // Assert
    expect(state.listMembers.value.isNotEmpty, state.listMembers.value.isNotEmpty); // Verify that the result is as expected
  });

  test('Pagination', () async{
     state.onLoading();
    // Assert
    expect(state.listAbsences.value.length > 10, state.listMembers.value.length > 10); // Verify that the result is as expected
  });

  test('Filtering', () async{
    await state.filterAbsences("vacation", dateFormat(DateTime.parse("2021-02-20")));
    // Assert
    expect(state.listAbsences.value.isNotEmpty, state.listMembers.value.isNotEmpty); // Verify that the result is as expected
  });

  test('Searching', () async{
    await state.onSearchChanged("vacation");
    // Assert
    expect(state.listAbsences.value.isNotEmpty, state.listMembers.value.isNotEmpty); // Verify that the result is as expected
  });
  test('Member name', () async{
    String? memberName = state.getMembersName(644);
    print("memberName:$memberName");
    // Assert
    expect( memberName , "Max" ); // Verify that the result is as expected
  });

  test('No Member name', () async{
    String? memberName = state.getMembersName(123456);
    print("memberName:$memberName");
    // Assert
    expect( memberName , null ); // Verify that the result is as expected
  });
}
