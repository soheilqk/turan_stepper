import 'package:flutter/material.dart';
import 'package:turan_stepper/turan_step.dart';

class TuranStepper extends StatefulWidget {
  final currentStep;
  final List<TuranStep> steps;
  final Function(int stepIndex) onStepTapped;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? dividerColor;
  final List<Widget> buttons;

  const TuranStepper({
    this.currentStep = 0,
    required this.steps,
    required this.onStepTapped,
    this.primaryColor = const Color(0xFF03C7C3),
    this.secondaryColor = Colors.white,
    this.dividerColor = const Color(0xFF03C7C3),
    required this.buttons,
  });

  @override
  _TuranStepperState createState() => _TuranStepperState();
}

class _TuranStepperState extends State<TuranStepper> {
  Widget buildSteps() {
    final List<Widget> numberings = [];
    final List<Widget> titles = [];
    widget.steps.forEach((element) {
      numberings.add(
        element.numbering(
          index: widget.steps.indexOf(element),
          currentStep: widget.currentStep,
          onStepTapped: widget.onStepTapped,
          primaryColor: widget.primaryColor!,
          secondaryColor: widget.secondaryColor!,
        ),
      );

      if (widget.steps.length - 1 != widget.steps.indexOf(element)) {
        numberings.add(
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10, left: 18, right: 18),
              child: Divider(color: widget.dividerColor),
            ),
          ),
        );
      }
    });
    widget.steps.forEach((element) {
      titles.add(
        element.titles(
          index: widget.steps.indexOf(element),
          currentStep: widget.currentStep,
          onStepTapped: widget.onStepTapped,
        ),
      );

      if (widget.steps.length - 1 != widget.steps.indexOf(element)) {
        titles.add(Expanded(child: Container()));
      }
    });
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: numberings,
          ),
        ),
        Row(children: titles)
      ],
    );
  }

  List<Widget> get contents {
    return widget.steps.map((e) => e.content).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: buildSteps(),
        ),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: IndexedStack(
              children: contents,
              index: widget.currentStep,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8),
          child: Row(
            children: widget.buttons,
          ),
        ),
      ],
    );
  }
}
