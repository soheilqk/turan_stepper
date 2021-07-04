import 'package:flutter/material.dart';
import 'package:turan_stepper/turan_step.dart';

class TuranStepper extends StatefulWidget {
  final currentStep;
  final List<TuranStep> steps;
  final Function(int stepIndex) onStepTapped;
  final void Function() onContinue;
  final void Function() onSubmit;
  final void Function() onClose;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? dividerColor;
  final TStepButtonTexts? buttonTexts;

  const TuranStepper({
    this.currentStep = 0,
    required this.steps,
    required this.onStepTapped,
    required this.onContinue,
    required this.onSubmit,
    required this.onClose,
    this.primaryColor = const Color(0xFF03C7C3),
    this.secondaryColor = Colors.white,
    this.dividerColor = const Color(0xFF03C7C3),
    this.buttonTexts = const TStepButtonTexts(),
  });

  @override
  _TuranStepperState createState() => _TuranStepperState();
}

class _TuranStepperState extends State<TuranStepper> {
  Widget buildSteps() {
    final List<Widget> numberings = [];
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
              margin: EdgeInsets.only(top: 12, left: 18, right: 18),
              child: Divider(color: widget.dividerColor),
            ),
          ),
        );
      }
    });
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: numberings,
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
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.steps.length - 1 > widget.currentStep) {
                        widget.onStepTapped(widget.currentStep + 1);
                        widget.onContinue();
                      } else
                        widget.onSubmit();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(widget.primaryColor),
                    ),
                    child: Text(
                      widget.steps.length - 1 > widget.currentStep ? widget.buttonTexts!.forward : widget.buttonTexts!.submit,
                      style: TextStyle(color: widget.secondaryColor),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.currentStep == 0) {
                        widget.onClose();
                      } else
                        widget.onStepTapped(widget.currentStep - 1);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(widget.primaryColor),
                    ),
                    child: Text(
                      widget.currentStep == 0 ? widget.buttonTexts!.close : widget.buttonTexts!.back,
                      style: TextStyle(color: widget.secondaryColor),
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 10,
              )
            ],
          ),
        ),
      ],
    );
  }
}

//

class TStepButtonTexts {
  final String forward;
  final String submit;
  final String back;
  final String close;

  const TStepButtonTexts({
    this.forward = 'ادامه',
    this.submit = 'تایید',
    this.back = 'بازگشت',
    this.close = 'بستن',
  });
}
