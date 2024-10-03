import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class SplashScreen1 extends StatefulWidget {
   SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

int index = 0;
class _SplashScreen1State extends State<SplashScreen1>
{
  final PageController _pageViewController = PageController();

  _onPageViewChange(int page) {
    setState(() {
      index = page;
    });

  }
  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: wid,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: wid,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 18.0),
                      child: GestureDetector(
                        onTap: () {
                          _pageViewController.animateToPage(index = index - 1,
                              duration:  Duration(milliseconds: 800),
                              curve: Curves.fastOutSlowIn);
                        },
                        child: Text(index >= 1 ? "Back".tr : "",
                            style:  TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            )),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(right: 18.0),
                      child: GestureDetector(
                        onTap: () {
                          _pageViewController.animateToPage(3,
                              duration:  Duration(milliseconds: 1900),
                              curve: Curves.fastOutSlowIn);
                        },
                        child: Text(index >= 3 ? "" : "Skip".tr,
                            style:  TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                margin:  EdgeInsets.all(0),
                width: wid,
                height: wid >= 800 ? 900 : 500,
                child: PageView(
                  pageSnapping: true,
                  controller: _pageViewController,
                  onPageChanged: _onPageViewChange,
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,

                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/pic1.svg",
                              width: wid/2,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: wid - 50,
                          child:  Column(
                            children: [
                              Text(
                                "TRAVEL".tr,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ), Padding(
                                padding:  EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Travel on multiple trips through our app".tr,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/pic2.svg",
                              width: wid/2,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: wid - 50,
                          child: Column(
                            children: [
                              Text(
                                "EXPLORE".tr,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ), Padding(
                                padding:  EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Explore the world and regions \n through our application".tr,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/pic3.svg",
                              width: wid,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: wid - 50,
                          child:  Column(
                            children: [
                              Text(
                                "NATURE".tr,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ), Padding(
                                padding:  EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Comfortable natural  \n environment for our users".tr,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/pic4.svg",
                              width: wid-50,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: wid - 50,
                          child:  Text(
                            "In conclusion, I am very happy to use our application to book your trips .  \n \n Please Login Or Creat Account".tr,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),



                  ],
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: (wid / 4) - 30,
                  height: 60,
                  child: SmoothPageIndicator(
                    controller: _pageViewController,
                    count: 4,
                    effect:  SwapEffect(
                        activeDotColor: Theme.of(context).primaryColor,
                        dotWidth: 10,
                        dotHeight: 10,
                        type: SwapType.zRotation),
                  ),
                ),
                index >= 3
                    ? SizedBox(
                  width: wid,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0 , right: 8.0),
                        child: TextButton(
                          onPressed: () {
                          context.push('/login');
                          },
                          style: ButtonStyle(
                              backgroundColor:
                               MaterialStatePropertyAll(Theme.of(context).primaryColor),
                              minimumSize:
                              MaterialStatePropertyAll(Size(wid / 2 - 50, 55)),
                              overlayColor:  MaterialStatePropertyAll(Color(
                                  0x24FFFFFF)),
                              shape:  MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:  BorderRadius.all(
                                          Radius.circular(15)
                                        )))
                          ), child:  Text(
                          "Login Account".tr,
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0 , right: 8.0),
                        child: TextButton(
                          onPressed: () {
                            context.push('/createaccount');
                          },
                          style: ButtonStyle(
                              backgroundColor:
                               MaterialStatePropertyAll(Theme.of(context).primaryColor),
                              minimumSize:
                              MaterialStatePropertyAll(Size(wid / 2 - 50, 55)),
                              overlayColor:  MaterialStatePropertyAll(Color(
                                  0x1510353C)),
                              shape:  MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)
                                         ),side: BorderSide(color: Colors.white)))
                          ), child:  Text(
                          "Create Account".tr,
                          style: TextStyle(color: Colors.white),
                        ),
                        ),
                      )
                    ],
                  ),
                )
                    : TextButton(
                  onPressed: () {

                    _pageViewController.animateToPage(index = index + 1,
                        duration:  Duration(milliseconds: 1500),
                        curve: Curves.fastOutSlowIn);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                     MaterialStatePropertyAll(Theme.of(context).primaryColor),
                    minimumSize:
                    MaterialStatePropertyAll(Size(wid * 0.7, 55)),
                    overlayColor:  MaterialStatePropertyAll(Color(
                        0x12046d80)),
                  ),
                  child: Text((index >= 2) ? "Get Started".tr : "Next Page".tr,
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
