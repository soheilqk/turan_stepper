import 'package:flutter/material.dart';

class TuranStep {
  final Widget? title;
  final Widget? subtitle;
  final Widget content;

  const TuranStep({
    this.title,
    this.subtitle,
    required this.content,
  });

  Widget numbering({
    required int index,
    required int currentStep,
    required Function(int stepIndex) onStepTapped,
    required Color primaryColor,
    required Color secondaryColor,
  }) {
    final backgroundColor = index != currentStep ? secondaryColor : primaryColor;
    final contentColor = index != currentStep ? primaryColor : secondaryColor;
    return MouseRegion(
      cursor: index > currentStep ? MouseCursor.defer : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: index > currentStep ? null : () => onStepTapped(index),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12, spreadRadius: 3)],
              ),
              child: CircleAvatar(
                child: index < currentStep
                    ? Icon(
                        Icons.check,
                        color: contentColor,
                      )
                    : Text(
                        '${index + 1}',
                        style: TextStyle(color: contentColor, fontWeight: FontWeight.w600),
                      ),
                backgroundColor: backgroundColor,
              ),
            ),
            if (title != null) ...[
              SizedBox(height: 6),
              title!,
            ],
            if (subtitle != null) ...[
              SizedBox(height: 6),
              subtitle!,
            ]
          ],
        ),
      ),
    );
  }
}

class TStepButtonTexts{
  final String? forward;
  final String? submit;
  final String? back;
  final String? close;

  TStepButtonTexts({this.forward, this.submit, this.back, this.close,});

}
