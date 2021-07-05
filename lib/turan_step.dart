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
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12, spreadRadius: 3)],
          ),
          child: index < currentStep
              ? CircleAvatar(
                  child: Icon(
                    Icons.check,
                    color: contentColor,
                  ),
                  backgroundColor: backgroundColor,
                )
              : Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(color: contentColor, fontWeight: FontWeight.w600),
                  ),
                ),
        ),
      ),
    );
  }

  Widget titles({
    required int index,
    required int currentStep,
    required Function(int stepIndex) onStepTapped,
  }) {
    return MouseRegion(
      cursor: index > currentStep ? MouseCursor.defer : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: index > currentStep ? null : () => onStepTapped(index),
        child: Column(
          children: [
            if (title != null) ...[
              SizedBox(height: 6),
              SizedBox(width:140,child: FittedBox(fit:BoxFit.scaleDown,child: title!)),
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

