part of 'pages.dart';

class WellcomePage extends StatefulWidget {
  const WellcomePage({super.key});

  @override
  State<WellcomePage> createState() => _WellcomePageState();
}

class _WellcomePageState extends State<WellcomePage> {
  //bool isHidden = true;
  //bool isHiddenCourse = true;
  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
            bottom: false,
            child: ListView(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Image.asset('assets/images/welcome.png',
                      height: 333, fit: BoxFit.fill),
                  // SizedBox(
                  // height: 15,
                  //),
                  //Text("welcome", style: dangerTextStyle,
                  // textAlign: TextAlign.center,
                  //),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Welcome to App Monitoring Perum Gajah Asri",
                    style: dangerTextStyle,
                    //fontFamily: 'NunitoLight',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 61,
                  ),
                  Container(
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      width: MediaQuery.of(context).size.width - 1 * 50,
                      child: 
                      ElevatedButton(
                          onPressed: () {
                            // NOted tampilkan modal register
                            showModalBottomSheet(
                              // isScrollControlled: true,
                              useRootNavigator: true,
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Wrap(
                                      children: [
                                        // bagian modal
                                        Container(
                                            color: Colors.transparent,
                                            child: Container(
                                              height: MediaQuery.of(context).size.height / 2,
                                              decoration: BoxDecoration(
                                                  color: dangerColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  40),
                                                          topLeft:
                                                              Radius.circular(
                                                                  40))),
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal:
                                                          defaultMargin),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      // jarak

                                                      SizedBox(
                                                        height: 25,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text(
                                                                "Helloo...",
                                                                style: whiteTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            20,
                                                                        color:
                                                                            whiteColor),
                                                              ),
                                                              Text(
                                                                "Register",
                                                                style: whiteTextStyle.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        30,
                                                                    color:
                                                                        whiteColor),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Center(
                                                            child: InkWell(
                                                              onTap: () {
                                                                //ketika icon ditekan
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/close.jpg',
                                                                height: 30,
                                                                width: 30,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),

                                                      SizedBox(
                                                        height: 25,
                                                      ),

                                                      // note : username
                                                      TextField(
                                                          //obscureText: isHidden,
                                                          decoration:
                                                              InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        hintText: "username",
                                                        labelText: "usename",
                                                      )),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      // note : course
                                                      TextField(
                                                          //obscureText: isHiddenCourse,
                                                          decoration:
                                                              InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        hintText: "email",
                                                        labelText: "E-mail",
                                                      )),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      // note : password
                                                      TextField(
                                                          obscureText:
                                                              isHiddenPassword,
                                                          decoration:
                                                              InputDecoration(
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  filled: true,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  hintText:
                                                                      "password",
                                                                  labelText:
                                                                      "password",
                                                                  suffixIcon:
                                                                      InkWell(
                                                                          onTap:
                                                                              _tootlesPasswordView,
                                                                          //ketika icon ditekan
                                                                          child: Icon(isHiddenPassword
                                                                              ? Icons.lock_outline
                                                                              : Icons.lock_open_outlined)))),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      // note : confirm password
                                                      TextField(
                                                          obscureText:
                                                              isHiddenConfirmPassword,
                                                          decoration:
                                                              InputDecoration(
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  filled: true,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  hintText:
                                                                      "confirm password",
                                                                  labelText:
                                                                      "confirm password",
                                                                  suffixIcon:
                                                                      InkWell(
                                                                          onTap:
                                                                              _tootlesConfirmPasswordView,
                                                                          //ketika icon ditekan
                                                                          child: Icon(isHiddenConfirmPassword
                                                                              ? Icons.lock_outline
                                                                              : Icons.lock_open_outlined)))),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                          height: 50,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      40),
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              1 * 5,
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                 Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                'Register',
                                                                style: whiteTextStyle.copyWith(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color:
                                                                        secondaryColor),
                                                              ),
                                                              style: ElevatedButton.styleFrom(
                                                                  primary:
                                                                      treColor,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15))))),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                              "Already have account? ",
                                                              style: whiteTextStyle
                                                                  .copyWith(
                                                                      color:
                                                                          primaryColor,
                                                                      fontSize:
                                                                          14)),
                                                          Text("Login",
                                                              style: whiteTextStyle
                                                                  .copyWith(
                                                                      color:
                                                                          primaryColor,
                                                                      fontSize:
                                                                          14))
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: defaultMargin,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Text(
                            'Register',
                            style: whiteTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: primaryColor),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: secondaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))))),
                  SizedBox(
                    height: 41,
                  ),
                  Container(
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      width: MediaQuery.of(context).size.width - 1 * 50,
                      child: ElevatedButton(
                          onPressed: () {
                            // NOted tampilkan modal register
                            showModalBottomSheet(
                              // isScrollControlled: true,
                              useRootNavigator: true,
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Wrap(
                                      children: [
                                        // bagian modal
                                        Container(
                                            color: Colors.transparent,
                                            child: Container(
                                              height: 600,
                                              decoration: BoxDecoration(
                                                  color: dangerColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  40),
                                                          topLeft:
                                                              Radius.circular(
                                                                  40))),
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal:
                                                          defaultMargin),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      // jarak

                                                      SizedBox(
                                                        height: 25,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text(
                                                                "Welcome Back!",
                                                                style: whiteTextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            20,
                                                                        color:
                                                                            whiteColor),
                                                              ),
                                                              Text(
                                                                "Login",
                                                                style: whiteTextStyle.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        30,
                                                                    color:
                                                                        whiteColor),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Center(
                                                            child: InkWell(
                                                              onTap: () {
                                                                //ketika icon ditekan
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/close.jpg',
                                                                height: 30,
                                                                width: 30,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),

                                                      SizedBox(
                                                        height: 25,
                                                      ),

                                                      // note : username
                                                      TextField(
                                                          //obscureText: isHidden,
                                                          decoration:
                                                              InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        hintText: "username",
                                                        labelText: "usename",
                                                      )),
                                                      // SizedBox(
                                                      //   height: 20,
                                                      // ),
                                                      // // note : course
                                                      // TextField(
                                                      //     //obscureText: isHiddenCourse,
                                                      //     decoration:
                                                      //         InputDecoration(
                                                      //   fillColor: Colors.white,
                                                      //   filled: true,
                                                      //   border:
                                                      //       OutlineInputBorder(
                                                      //     borderRadius:
                                                      //         BorderRadius
                                                      //             .circular(10),
                                                      //   ),
                                                      //   hintText: "password",
                                                      //   labelText: "Password",
                                                      // )),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      // note : password
                                                      TextField(
                                                          obscureText:
                                                              isHiddenPassword,
                                                          decoration:
                                                              InputDecoration(
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  filled: true,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  hintText:
                                                                      "password",
                                                                  labelText:
                                                                      "password",
                                                                  suffixIcon:
                                                                      InkWell(
                                                                          onTap:
                                                                              _tootlesPasswordView,
                                                                          //ketika icon ditekan
                                                                          child: Icon(isHiddenPassword
                                                                              ? Icons.lock_outline
                                                                              : Icons.lock_open_outlined)))),
                                                      // SizedBox(
                                                      //   height: 20,
                                                      // ),
                                                      // // note : confirm password
                                                      // TextField(
                                                      //     obscureText:
                                                      //         isHiddenConfirmPassword,
                                                      //     decoration:
                                                      //         InputDecoration(
                                                      //             fillColor:
                                                      //                 Colors
                                                      //                     .white,
                                                      //             filled: true,
                                                      //             border:
                                                      //                 OutlineInputBorder(
                                                      //               borderRadius:
                                                      //                   BorderRadius.circular(
                                                      //                       10),
                                                      //             ),
                                                      //             hintText:
                                                      //                 "confirm password",
                                                      //             labelText:
                                                      //                 "confirm password",
                                                      //             suffixIcon:
                                                      //                 InkWell(
                                                      //                     onTap:
                                                      //                         _tootlesConfirmPasswordView,
                                                      //                     //ketika icon ditekan
                                                      //                     child: Icon(isHiddenConfirmPassword
                                                      //                         ? Icons.lock_outline
                                                      //                         : Icons.lock_open_outlined)))),
                                                      SizedBox(
                                                        height: 50,
                                                      ),
                                                      Container(
                                                          height: 50,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      40),
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              1 * 10,
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                Route route =
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                HomePage());
                                                                Navigator.push(
                                                                    context,
                                                                    route);
                                                              },
                                                              child: Text(
                                                                'Login',
                                                                style: whiteTextStyle.copyWith(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color:
                                                                        secondaryColor),
                                                              ),
                                                              style: ElevatedButton.styleFrom(
                                                                  primary:
                                                                      treColor,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15))))),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text("Lupa Password?",
                                                              style: whiteTextStyle
                                                                  .copyWith(
                                                                      color:
                                                                          primaryColor,
                                                                      fontSize:
                                                                          14)),
                                                          // Text("Login",
                                                          //     style: whiteTextStyle
                                                          //         .copyWith(
                                                          //             color:
                                                          //                 primaryColor,
                                                          //             fontSize:
                                                          //                 14))
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: defaultMargin,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Text(
                            'Login',
                            style: whiteTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: primaryColor),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: secondaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))))),
                  SizedBox(
                    height: 36,
                  ),
                  Text(
                    'All Right Reserved',
                    textAlign: TextAlign.center,
                    style: whiteTextStyle.copyWith(
                        color: secondaryColor, fontSize: 11),
                  ),
                ])));
  }

  // void _tootlesUsernameView(){
  //   setState(() {
  //     isHidden = !isHidden;
  //   });
  // }
  //   void _tootlesCourseView(){
  //   setState(() {
  //     isHiddenCourse = !isHiddenCourse;
  //   });
  //   }
  void _tootlesPasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void _tootlesConfirmPasswordView() {
    setState(() {
      isHiddenConfirmPassword = !isHiddenConfirmPassword;
    });
  }
}
