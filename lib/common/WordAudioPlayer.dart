
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:study/common/VolumeAnimation.dart';

class WordAudioPlayer extends StatelessWidget{

  final GlobalKey<VolumeAnimationState> _controller = new GlobalKey<VolumeAnimationState>();

  final Widget child;
  final String url;
  final double size;
  final Color color;
  WordAudioPlayer(
      this.url,
      {
        this.child,
        this.size = 20,
        this.color
      });

  @override
  Widget build(BuildContext context) {
    return url!=null?InkWell(
      onTap: () async {
        AudioPlayer audioPlayer = AudioPlayer();
        int result = await audioPlayer.play(url);
        if(result == 1){
          _controller.currentState.startAnimation();
        }
        audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
          if(s == AudioPlayerState.COMPLETED){
            print("播放结束");
            _controller.currentState.stopAnimation();
            audioPlayer.dispose();
          }
        });
        audioPlayer.onPlayerCompletion.listen((event) {
          print("播放结束");
          _controller.currentState.stopAnimation();
          audioPlayer.dispose();
        });
      },
      child:Row(
        children: [
          VolumeAnimation(
            _controller,
            size: size,
            color: color,
          ),
          child??Container()
        ],
      )
    ):Container();
  }
}


