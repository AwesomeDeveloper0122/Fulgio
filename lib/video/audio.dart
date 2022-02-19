import 'package:Fuligo/screens/keizersgracht.dart';
import 'package:Fuligo/screens/route_screen.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/utils/font_style.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

var themeNotifier = ValueNotifier<ThemeVariation>(
  const ThemeVariation(Colors.blue, Brightness.light),
);

class ThemeVariation {
  const ThemeVariation(this.color, this.brightness);
  final MaterialColor color;
  final Brightness brightness;
}

class AudioScreen extends StatefulWidget {
  Map mediadata;
  AudioScreen({Key? key, required this.mediadata}) : super(key: key);
  @override
  AudioScreenState createState() => AudioScreenState();
}

class AudioScreenState extends State<AudioScreen> {
  late AudioPlayer _player;

  String url = '';
  late Stream<DurationState> _durationState;
  final _isShowingWidgetOutline = false;
  final _labelLocation = TimeLabelLocation.above;
  final _labelType = TimeLabelType.totalTime;

  final _labelPadding = 0.0;
  final _barHeight = 5.0;
  final _barCapShape = BarCapShape.round;
  List<Widget> child = [];

  Color? _thumbGlowColor;
  final _thumbCanPaintOutsideBar = true;

  @override
  void initState() {
    url = widget.mediadata["audio"];

    super.initState();
    _player = AudioPlayer();
    _durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        _player.positionStream,
        _player.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration,
            ));
    _init();
  }

  Future<void> _init() async {
    try {
      await _player.setUrl(url);
    } catch (e) {
      debugPrint('An error occured $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map mediadata = widget.mediadata;
    List imgList = widget.mediadata["image"];
    var mq = MediaQuery.of(context).size;
    for (var i = 0; i < imgList.length; i++) {
      child.add(
        Image.network(
          imgList[i],
          fit: BoxFit.fill,
        ),
      );
    }
    return Scaffold(
      body: Container(
        width: mq.width,
        height: mq.height,
        child: SafeArea(
          child: Stack(children: [
            CarouselSlider(
              items: child,

              //Slider Container properties
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 0.8,
                // enlargeCenterPage: true,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            ClearButton(context),
            Positioned(
              top: 65,
              right: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Keizersgrachi",
                    style: font_13_white,
                    textAlign: TextAlign.center,
                  ),
                  RatingBar.builder(
                    initialRating: mediadata["rating"]!,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20.0,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.favorite,
                      color: whiteColor,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Keizersgracht(
                                      infodata: mediadata,
                                    ),
                                  ),
                                ),
                              },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 66.0,
                              semanticLabel: 'Route',
                            ),
                          )),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _playButton(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RouteScreen(),
                                  ),
                                ),
                              },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              Icons.power_settings_new_sharp,
                              color: Colors.white,
                              size: 66.0,
                              semanticLabel: 'Route',
                            ),
                          )),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  decoration: _widgetBorder(),
                  child: _progressBar(),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  BoxDecoration _widgetBorder() {
    return BoxDecoration(
      border: _isShowingWidgetOutline
          ? Border.all(color: Colors.red)
          : Border.all(color: Colors.transparent),
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
      stream: _durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(
          progress: progress,
          buffered: buffered,
          total: total,
          onSeek: (duration) {
            _player.seek(duration);
          },
          onDragUpdate: (details) {
            debugPrint('${details.timeStamp}, ${details.localPosition}');
          },
          barHeight: _barHeight,
          baseBarColor: whiteColor.withOpacity(0.24),
          bufferedBarColor: whiteColor.withOpacity(0.24),
          progressBarColor: whiteColor,
          thumbColor: whiteColor,
          thumbGlowColor: _thumbGlowColor,
          barCapShape: _barCapShape,
          thumbRadius: 8,
          thumbCanPaintOutsideBar: _thumbCanPaintOutsideBar,
          timeLabelLocation: _labelLocation,
          timeLabelType: _labelType,
          timeLabelTextStyle: TextStyle(color: whiteColor),
          timeLabelPadding: _labelPadding,
        );
      },
    );
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: 32.0,
            height: 32.0,
            child: const CircularProgressIndicator(),
          );
        } else if (playing != true) {
          return IconButton(
            icon: const Icon(Icons.play_circle_outline),
            iconSize: 100.0,
            color: Colors.white,
            onPressed: _player.play,
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: const Icon(Icons.pause_circle_outline),
            iconSize: 100,
            color: Colors.white,
            onPressed: _player.pause,
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.replay_circle_filled_outlined),
            iconSize: 100,
            onPressed: () => _player.seek(Duration.zero),
          );
        }
      },
    );
  }
}

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration? total;
}
