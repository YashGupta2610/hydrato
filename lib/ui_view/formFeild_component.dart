import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../fitness_app_theme.dart';

class FormFieldCustom {
  Widget MyAccountUpdateForm(String title, Function(String?) onSaved,
      animationController, Animation<double> aniamtionOpc) {
    return AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: aniamtionOpc,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 5),
              child: TextFormField(
                decoration: InputDecoration(
                  // hoverColor: FitnessAppTheme.nearlyBlue,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 8,
                        color: FitnessAppTheme.nearlyDarkBlue,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  counterStyle: FitnessAppTheme.subtitle,
                  hintText: title,
                  // contentPadding: EdgeInsets.all(15.0),
                  // border: InputBorder.none,
                  filled: true,
                  fillColor: FitnessAppTheme.nearlyWhite,
                ),
                onSaved: onSaved,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Text is empty';
                  }
                  return null;
                },

              ),
            ),
          );
        }
    );
  }
}
