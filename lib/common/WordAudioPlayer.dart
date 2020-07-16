
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:study/common/VolumeAnimation.dart';

class WordAudioPlayer extends StatefulWidget{
  final Widget child;
  final String url;
  final double size;
  final Color color;
  final bool autoPlay;

  WordAudioPlayer(
      this.url,
      {
        Key key,
        this.child,
        this.size = 20,
        this.color,
        this.autoPlay = false
      }):super(key: key);

  @override
  State<StatefulWidget> createState() => WordAudioPlayerState();

}


class WordAudioPlayerState extends State<WordAudioPlayer>{

  final GlobalKey<VolumeAnimationState> _controller = new GlobalKey<VolumeAnimationState>();
  AudioPlayer _audioPlayer = AudioPlayer();


  @override
  Widget build(BuildContext context) {
    return widget.url!=null?Container(
      child: InkWell(
        onTap: () {
          playAudio();
        },
        child:Row(
          mainAxisSize:MainAxisSize.min,
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            VolumeAnimation(
              _controller,
              size: widget.size,
              color: widget.color,
            ),
            widget.child??Container()
          ],
        ),
      ),
    ):Container();
  }

  playAudio() async {
    int result = await _audioPlayer.play(widget.url);
    if(result == 1){
      _controller.currentState.startAnimation();
    }
    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      if(s == AudioPlayerState.COMPLETED){
        _controller.currentState.stopAnimation();
        _audioPlayer.dispose();
      }
    });
    _audioPlayer.onPlayerCompletion.listen((event) {
      _controller.currentState.stopAnimation();
      _audioPlayer.dispose();
    });
  }
}


