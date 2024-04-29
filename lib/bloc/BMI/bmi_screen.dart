import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:provider/provider.dart';
import 'package:ruler_scale_picker/ruler_scale_picker.dart';
import 'package:urlshortener/bloc/BMI/bmi_provider.dart';

const String kmale = 'assets/icons/male.png';
const String kFemale = 'assets/icons/femenine.png';

TextStyle _titleStyle = const TextStyle(
  fontSize: 16,
  color: Colors.black,
  fontWeight: FontWeight.w600,
);

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  SlidingUpPanelController panelController = SlidingUpPanelController();
  NumericRulerScalePickerController _numericRulerScalePickerController =
      NumericRulerScalePickerController(
    initialValue: 0,
    lastValue: 1000,

    // interval: 10,
  );
  NumericRulerScalePickerController _weightContoller =
      NumericRulerScalePickerController(
    initialValue: 0,
    lastValue: 200,

    // interval: 10,
  );

  bool showPerformance = false;

  double minBound = 0;

  double upperBound = 1.0;

  bool show = true;

  @override
  void initState() {
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double scrnwdth = MediaQuery.sizeOf(context).width;
    double wdth = MediaQuery.sizeOf(context).width / 2;

    final bmiProv = Provider.of<BmiProvider>(context);
    final bmiFalseProv = Provider.of<BmiProvider>(context, listen: false);

    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: false,
            title: const Text("BMI Calculator"),
            // actions: <Widget>[
            //   // IconButton(
            //   //   icon: Icon(Icons.settings),
            //   //   onPressed: () {
            //   //     setState(() {
            //   //       showPerformance = !showPerformance;
            //   //     });
            //   //     // widget.onSetting?.call();
            //   //   },
            //   // )
            // ],
          ),
          body: Container(
            child: Column(
              children: [
                _buildgenderSelector(bmiFalseProv, bmiProv, scrnwdth),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16)
                      .copyWith(top: 24),
                  decoration: BoxDecoration(
                      border: Border.all(
                          // width: GenderType.female == bmiProv.gender ? 2 : 1,
                          color: Colors.grey),
                      borderRadius: BorderRadius.circular(16)

                      // color: Colors.grey,
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Height(in cm)',
                          style: _titleStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        // NumericRulerScalePicker(
                        //   controller: NumericRulerScalePickerController(),
                        // )
                        SizedBox(
                          width: scrnwdth,
                          height: 100,
                          child: Expanded(
                            child: NumericRulerScalePicker(
                              controller: _numericRulerScalePickerController,
                              // valueDisplayBuilder: (context, value) {
                              //   return Text("data");
                              // },

                              scaleIndicatorBuilder:
                                  (context, orientation, value,
                                      {required isMajorIndicator}) {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (value % 2 == 0 ||
                                        value ==
                                            _numericRulerScalePickerController
                                                .index)
                                      Text(
                                        '$value',
                                        style: TextStyle(
                                          height: value ==
                                                  _numericRulerScalePickerController
                                                      .index
                                              ? 1
                                              : 1.6,
                                          color: value ==
                                                  _numericRulerScalePickerController
                                                      .index
                                              ? Colors.black
                                              : Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: value ==
                                                  _numericRulerScalePickerController
                                                      .index
                                              ? 18
                                              : 12,
                                        ),
                                      ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      width: 2,
                                      height: 50,
                                      color: Colors.grey,
                                    ),
                                  ],
                                );
                              },
                              scaleMarkerBuilder: (context, orientation) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 70,
                                      color: Colors.black,
                                    ),
                                  ],
                                );
                              },
                              options: RulerScalePickerOptions(
                                showControls: false,
                                majorIndicatorInterval: 10,
                                indicatorExtend: 36,
                              ),
                            ),
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     SizedBox(
                        //       width: scrnwdth,
                        //       child: NumericRulerScalePicker(
                        //         options: RulerScalePickerOptions(
                        //           majorIndicatorInterval: 2,
                        //           indicatorExtend: 70,
                        //         ),
                        //       ),
                        //     ),
                        //     Text('data'),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                )

                //
                ,
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildWeight(context, scrnwdth, _weightContoller),
                      _buildAgeSelector(context, scrnwdth),
                    ],
                  ),
                ),

                // Center(
                //   child: Text('This is content'),
                // ),
              ],
            ),
          ),
        ),
        SlidingUpPanelWidget(
          controlHeight: 80,
          anchor: 0.5,
          elevation: 1,
          // upperBound: 500,
          onStatusChanged: (status) {
            print("status===>>>");
            print(status);
          },
          panelController: panelController,
          onTap: () {
            ///Customize the processing logic
            if (SlidingUpPanelStatus.expanded == panelController.status) {
              panelController.collapse();
            } else {
              panelController.expand();
            }
          }, //Pass a onTap callback to customize the processing logic when user click control bar.
          enableOnTap: true, //Enable the onTap callback for control bar.
          dragDown: (details) {
            show = true;
            setState(() {});
            // print('dragDown');
            // if (details.localPosition.distance > 250) {
            //   show = false;
            // } else {

            // }

            print(details.localPosition.distance);
          },
          dragStart: (details) {
            if (details.localPosition.distance > 250) {
              show = false;
            }
            setState(() {});
            print('dragStart');
          },
          dragCancel: () {
            print('dragCancel');
          },
          dragUpdate: (details) {
            print(details.globalPosition);
            // if (details.globalPosition > 250) {
            //   show = false;
            // }
            // else {
            //   show = true;
            // }
            setState(() {});

            print(
                'dragUpdate,${panelController.status == SlidingUpPanelStatus.dragging ? 'dragging' : ''}');
          },
          dragEnd: (details) {
            // print('dragEnd');
            // print(details.velocity);
          },
          // minimumBound: 100,
          // upperBound: 200,
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 15.0),
            decoration: const ShapeDecoration(
              // color: Colors.white,
              // shadows: [
              //   BoxShadow(
              //       blurRadius: 5.0,
              //       spreadRadius: 2.0,
              //       color: const Color(0x11000000))
              // ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // BottomAppBar(
                //   color: Colors.blue,
                //   child: Row(
                //     children: [
                //       Text("data"),
                //       Text("data"),
                //     ],
                //   ),
                // ),
                // Text("${panelController.hasListeners}"),
                // SizedBox(
                //   height: 50,
                // ),
                Container(
                  // color: Colors.blue,
                  // alignment: Alignment.center,
                  height: 80,
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    // backgroundColor: Colors.blue,
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: FloatingActionButton(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        child:
                            (!show) ? Icon(Icons.replay_outlined) : Text('BMI'),
                        shape: CircleBorder(),
                        onPressed: () {}),
                    bottomNavigationBar: Builder(builder: (context) {
                      return ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24)),
                        child: BottomAppBar(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shadowColor: Colors.transparent,
                          height: 80,
                          surfaceTintColor: Colors.blue,
                          shape: CircularNotchedRectangle(),
                          color: Colors.blue,
                          // notchMargin: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _getBottomIcon(wdth,
                                  icon: Icons.line_axis_rounded,
                                  title: "ACTIVITY"),
                              _getBottomIcon(wdth,
                                  icon: Icons.person_2_outlined,
                                  title: "PROFILE"),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                // Divider(
                //   height: 0.5,
                //   color: Colors.grey[300],
                // ),
                Flexible(
                  child: Container(
                    child: Column(
                      children: [
                        // SizedBox(
                        //   height: 12,
                        // ),
                        Text(
                          "Your BMI is",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "19.6 kg/m2",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20)
                              .copyWith(top: 24, bottom: 24),
                          child: Text(
                            'A BMI of 18.5 - 24.9 indicates that you are at a healthy weight for your height. By maintaining a healthy weight, you lower your risk of developing serious health problems.',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bookmark,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Icon(
                              Icons.share,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ],
                    ),

                    //  ListView.separated(
                    //   controller: scrollController,
                    //   physics: ClampingScrollPhysics(),
                    //   itemBuilder: (context, index) {
                    //     return ListTile(
                    //       title: Text('list item $index'),
                    //     );
                    //   },
                    //   separatorBuilder: (context, index) {
                    //     return Divider(
                    //       height: 0.5,
                    //     );
                    //   },
                    //   shrinkWrap: true,
                    //   itemCount: 20,
                    // ),

                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    // Scaffold(
    //   appBar: AppBar(
    //     title: Text('BMI Calculator'),
    //   ),
    //   body: Scaffold(
    //     bottomNavigationBar: BottomNavigationBar(
    //       items: const <BottomNavigationBarItem>[
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.home),
    //           label: 'Home',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.business),
    //           label: 'Business',
    //         ),
    //       ],
    //     ),
    //     body: Center(
    //       child: ElevatedButton(
    //         child: Text('Show/Hide Modal Bottom Sheet'),
    //         onPressed: () => _showOrHide(!_showModal),
    //       ),
    //     ),
    //   ),
    // );
  }
}

_buildWeight(context, scrnwdth, NumericRulerScalePickerController controller) {
  final bmiFalseProv = Provider.of<BmiProvider>(context, listen: false);
  final bmiProv = Provider.of<BmiProvider>(context);
  return Container(
    padding: const EdgeInsets.only(top: 16),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(16)

        // color: Colors.grey,
        ),
    // color: Colors.amber,
    width: (scrnwdth - 52) / 2,
    height: (scrnwdth - 52) / 2,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // SizedBox(),
        const Text(
          "Weight(in kg)",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.6), width: 2),
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24)),
          width: ((scrnwdth - 52) / 2) - 36,
          height: 80,
          child: Expanded(
            child: NumericRulerScalePicker(
              controller: controller,
              // valueDisplayBuilder: (context, value) {
              //   return Text("data");
              // },

              scaleIndicatorBuilder: (context, orientation, value,
                  {required isMajorIndicator}) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // if (value % 2 == 0 || value == controller.index)
                    Text(
                      '$value',
                      style: TextStyle(
                        height: value == controller.index ? 1 : 1.6,
                        color: value == controller.index
                            ? Colors.black
                            : Colors.grey,
                        fontWeight: value == controller.index
                            ? FontWeight.bold
                            : FontWeight.w400,
                        fontSize: value == controller.index ? 22 : 18,
                      ),
                    ),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    // Container(
                    //   width: 2,
                    //   height: 50,
                    //   color: Colors.grey,
                    // ),
                  ],
                );
              },
              scaleMarkerBuilder: (context, orientation) {
                return Align(
                  alignment: Alignment.topCenter,
                  child:
                      // Container(
                      //   width: 4,
                      //   height: 15,
                      //   color: Colors.black,
                      // ),
                      Icon(
                    CupertinoIcons.arrowtriangle_down_fill,
                    size: 22,
                  ),
                );

                // Column(
                //   // mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     // Text(data)
                //     Icon(
                //       Icons.arrow_drop_down,
                //       size: 32,
                //     ),
                // Container(
                //   width: 4,
                //   height: 15,
                //   color: Colors.black,
                // ),
                //   ],
                // );
              },
              options: RulerScalePickerOptions(
                showControls: false,
                majorIndicatorInterval: 10,
                indicatorExtend: 46,
              ),
            ),
          ),
        ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     IconButton(
        //       onPressed: () {
        //         bmiFalseProv.selectAge(AgeMode.sub);
        //       },
        //       icon: Icon(CupertinoIcons.minus_square),
        //     ),
        //     Text(
        //       bmiProv.age.toString(),
        //       style: TextStyle(
        //         fontSize: 32,
        //         color: Colors.black,
        //         fontWeight: FontWeight.w700,
        //       ),
        //     ),
        //     IconButton(
        //       onPressed: () {
        //         bmiFalseProv.selectAge(AgeMode.add);
        //       },
        //       icon: Icon(CupertinoIcons.plus_square),
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: 12,
        // ),
        SizedBox(
          height: 24,
        ),
      ],
    ),
  );
}

_buildAgeSelector(context, scrnwdth) {
  final bmiFalseProv = Provider.of<BmiProvider>(context, listen: false);
  final bmiProv = Provider.of<BmiProvider>(context);
  return Container(
    padding: const EdgeInsets.only(top: 16),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(16)

        // color: Colors.grey,
        ),
    // color: Colors.amber,
    width: (scrnwdth - 52) / 2,
    height: (scrnwdth - 52) / 2,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // SizedBox(),
        const Text(
          "Age",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                bmiFalseProv.selectAge(AgeMode.sub);
              },
              icon: Icon(CupertinoIcons.minus_square),
            ),
            Text(
              bmiProv.age.toString(),
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            IconButton(
              onPressed: () {
                bmiFalseProv.selectAge(AgeMode.add);
              },
              icon: Icon(CupertinoIcons.plus_square),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        SizedBox(
          height: 24,
        ),
      ],
    ),
  );
}

_buildgenderSelector(bmiFalseProv, bmiProv, scrnwdth) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            bmiFalseProv.selectGender(GenderType.male);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    width: GenderType.male == bmiProv.gender ? 2 : 1,
                    color: GenderType.male == bmiProv.gender
                        ? Colors.black
                        : Colors.grey),
                borderRadius: BorderRadius.circular(16)

                // color: Colors.grey,
                ),
            // color: Colors.amber,
            width: (scrnwdth - 52) / 2,
            height: (scrnwdth - 52) / 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  kmale,
                  color: Colors.amber,
                  width: (scrnwdth - 52) / 4,
                  height: (scrnwdth - 52) / 4,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Male",
                  style: TextStyle(
                    fontSize: 16,
                    color: GenderType.male == bmiProv.gender
                        ? Colors.black
                        : Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            bmiFalseProv.selectGender(GenderType.female);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    width: GenderType.female == bmiProv.gender ? 2 : 1,
                    color: GenderType.female == bmiProv.gender
                        ? Colors.black
                        : Colors.grey),
                borderRadius: BorderRadius.circular(16)

                // color: Colors.grey,
                ),
            // color: Colors.amber,
            width: (scrnwdth - 52) / 2,
            height: (scrnwdth - 52) / 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  kFemale,
                  color: Colors.pink,
                  width: (scrnwdth - 52) / 4,
                  height: (scrnwdth - 52) / 4,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Female",
                  style: TextStyle(
                    fontSize: 16,
                    color: GenderType.female == bmiProv.gender
                        ? Colors.black
                        : Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

_getBottomIcon(size, {IconData? icon, required String title}) {
  return Container(
    width: size,
    child: Column(
      children: [
        Icon(
          icon ?? Icons.line_axis_outlined,
          color: Colors.white,
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
