import 'package:flutter/material.dart';
class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> {
  // init the step to 0th position
  int current_step = 0;
  List<Step> mySteps = [
    Step(
      // Title of the Step
        title: Text("Order Place"),
        content: Text("Online Order Placed"),
        isActive: true),
    Step(
        title: Text("PERP"),
        content: Text("View The Product"),
        state: StepState.indexed,
        isActive: true),

    Step(
        title: Text("BAKE"),
        content: Text("Bake Is Done"),
        isActive: true),

    Step(
        title: Text("QUALITY CHECK"),
        content: Text("Enter transaction details..."),
        isActive: true),

    Step(
        title: Text("DELIVERY"),
        content: Text("Purchase done successfully"),
        isActive: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff61CE70),
        title: Text(
          "Track Order",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      // Body
      body: Container(
          child: Theme(
            data: ThemeData(
                accentColor: Color(0xff61CE70),
                primarySwatch: Colors.green,
                colorScheme: ColorScheme.light(
                    primary: Color(0xff61CE70)
                )
            ),
            child: Stepper(

              currentStep: this.current_step,
              steps: mySteps,
              type: StepperType.vertical,

              onStepTapped: (step) {
                setState(() {
                  current_step = step;
                });
                print("onStepTapped : " + step.toString());
              },

              onStepCancel: () {
                setState(() {
                  if (current_step > 0) {
                    current_step = current_step - 1;
                  } else {
                    current_step = 0;
                  }
                });
                print("onStepCancel : " + current_step.toString());
              },

              onStepContinue: () {
                setState(() {
                  if (current_step < mySteps.length - 1) {
                    current_step = current_step + 1;
                  } else {
                    current_step = 0;
                  }
                });
                print("onStepContinue : " + current_step.toString());
              },

            ),
          )),
    );
  }
}