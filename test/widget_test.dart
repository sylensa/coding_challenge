// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

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
}
