import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import "colors.dart" as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  _VideoInfoState createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List<Video> info = [];
  bool _playArea = false;
  bool is_playing = false;
  VideoPlayerController? controller;
  _initData() async {
    var res =
        await DefaultAssetBundle.of(context).loadString("json/videoinfo.json");
    var resInfo = json.decode(res);
    setState(() {
      info = List<Video>.from(resInfo.map((x) => Video.fromJson(x)));
    });
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: _playArea == false
          ? BoxDecoration(
              gradient: LinearGradient(colors: [
              color.AppColor.gradientFirst.withOpacity(0.9),
              color.AppColor.gradientSecond
            ], begin: FractionalOffset(0.0, 0.4), end: Alignment.topRight))
          : BoxDecoration(color: color.AppColor.gradientSecond),
      child: Column(children: [
        // 2 nut bam ngang
        _playArea == false
            ? Container(
                padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: color.AppColor.secondPageIconColor,
                            ),
                          ),
                          Expanded(child: Container()),
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: color.AppColor.secondPageTitleColor,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          'Legs Toning',
                          style: TextStyle(
                              fontSize: 25,
                              color: color.AppColor.secondPageTitleColor),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'and Glutes Workout',
                        style: TextStyle(
                            fontSize: 25,
                            color: color.AppColor.homePageContainerTextSmall),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Row(
                          children: [
                            Container(
                              width: 90,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [
                                        color.AppColor
                                            .secondPageContainerGradient1stColor,
                                        color.AppColor
                                            .secondPageContainerGradient2ndColor
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topRight)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer,
                                    size: 20,
                                    color: color.AppColor.secondPageIconColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '68 min',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            color.AppColor.secondPageIconColor),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [
                                        color.AppColor
                                            .secondPageContainerGradient1stColor,
                                        color.AppColor
                                            .secondPageContainerGradient2ndColor
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topRight)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.handyman_outlined,
                                    size: 20,
                                    color: color.AppColor.secondPageIconColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Resistent band, kettebell',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            color.AppColor.secondPageIconColor),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              )
            : Container(
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 50, left: 30, right: 30),
                    height: 100,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: color.AppColor.secondPageIconColor,
                          ),
                        ),
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: color.AppColor.secondPageIconColor,
                        )
                      ],
                    ),
                  ),
                  controller != null && controller!.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Center(
                              child: Text(
                            'Being intialized please wait!',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white60),
                          )),
                        )
                      : AspectRatio(
                          aspectRatio: 16 / 9,
                          child: VideoPlayer(controller!),
                        ),
                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    color: color.AppColor.gradientSecond,
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.fast_rewind,
                              size: 36,
                            )),
                        InkWell(
                            onTap: () {
                              if (is_playing == false) {
                                setState(() {
                                  is_playing = true;
                                });
                                controller!.pause();
                              } else {
                                setState(() {
                                  is_playing = false;
                                });
                                controller!.play();
                              }
                            },
                            child: Icon(
                              is_playing == false
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 36,
                            )),
                        InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.fast_forward,
                              size: 36,
                            ))
                      ],
                    ),
                  )
                ]),
              ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(75))),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 30),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      'Circuit 1: Legs Toning',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color.AppColor.circuitsColor),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Icon(
                          Icons.loop,
                          size: 30,
                          color: color.AppColor.loopColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          '3 Sets',
                          style: TextStyle(
                              fontSize: 20, color: color.AppColor.setsColor),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    itemCount: info.length,
                    itemBuilder: (_, int index) {
                      final video_controller = VideoPlayerController.network(
                          info[index].videoUrl ?? "");
                      controller = video_controller;
                      return GestureDetector(
                        onTap: () {
                          video_controller
                            ..initialize().then((_) {
                              video_controller.play();
                            });
                          setState(() {
                            is_playing = false;
                          });
                          setState(() {
                            if (_playArea == false) {
                              _playArea = true;
                            }
                          });
                          controller = video_controller;
                          print(video_controller.dataSource);
                          print('$controller dcmmmm');
                        },
                        child: Container(
                            height: 135,
                            width: 200,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  info[index].thumbnail ?? ""),
                                              fit: BoxFit.cover)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            info[index].title ?? "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0),
                                            child: Text(
                                              info[index].time ?? "",
                                              style: TextStyle(
                                                  color: Colors.grey[500]),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFeaeefc),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            "15s rest",
                                            style: TextStyle(
                                                color: Color(0xFF839fed)),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          for (int i = 0; i < 70; i++)
                                            i.isEven
                                                ? Container(
                                                    width: 3,
                                                    height: 1,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF839fed),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2)),
                                                  )
                                                : Container(
                                                    width: 3,
                                                    height: 1,
                                                    color: Colors.white,
                                                  )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      );
                    }))
          ]),
        ))
      ]),
    ));
  }
}

class Video {
  String? title;
  String? time;
  String? thumbnail;
  String? videoUrl;

  Video({
    this.title,
    this.time,
    this.thumbnail,
    this.videoUrl,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        title: json["title"],
        time: json["time"],
        thumbnail: json["thumbnail"],
        videoUrl: json["videoUrl"],
      );
}
