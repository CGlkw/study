import 'package:flutter/material.dart';

// 音频播放动画
class VolumeAnimation extends StatefulWidget {
  final double size;
  int interval = 200;
  bool start;
  Color color;
  VolumeAnimation(Key key,
      { this.size,
        this.interval,
        this.start = false,
        this.color
      }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VolumeAnimationState();
  }
}

class VolumeAnimationState extends State<VolumeAnimation>
    with SingleTickerProviderStateMixin {
  // 动画控制
  Animation<double> _animation;
  AnimationController _controller;
  AnimationStatusListener listener;
  int interval = 200;
  List<Widget> widgets=[];
  bool stop = false;

  @override
  void initState() {
    super.initState();
    interval = widget.interval ?? 200;
    final int imageCount = 3;
    final int maxTime = interval * imageCount;
    widgets..add(Align(
      widthFactor: 1.2,
      heightFactor: 1,
      alignment: Alignment(0.0,0.0),
      child: Icon(
        Icons.volume_up,
        size: widget.size,
        color: widget.color,
      ),
    ))
      ..add(Align(
        widthFactor: 1.2,
        heightFactor: 1,
        alignment: Alignment(-1.6,0.0),
        child: Icon(Icons.volume_mute,size: widget.size,color: widget.color,),
      ))
      ..add(Align(
        widthFactor: 1.2,
        heightFactor: 1,
        alignment: Alignment(-0.8,0.0),
        child: Icon(Icons.volume_down,size: widget.size,color: widget.color,),
      ));
    // 启动动画controller
    _controller = new AnimationController(
        duration: Duration(milliseconds: maxTime), vsync: this);
    _controller.addStatusListener((AnimationStatus status) {
      if(status == AnimationStatus.completed) {
        if(!stop){
          _controller.forward(from: 0.0); // 完成后重新开始
        }
      }
    });
    _animation = new Tween<double>(begin: 0, end: imageCount.toDouble()).animate(_controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    if (widget.start) {
      _controller.forward();
    }
  }
  void startAnimation() {
    _controller.reset();
    stop = false;
    _controller.forward();
  }
  void stopAnimation() => stop = true;
  void reStartAnimation(){
    _controller.reset();
    _controller.forward();
  }
  @override
  void didUpdateWidget(VolumeAnimation oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget called");
    if (widget.start) {
      _controller.forward();
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int ix = _animation.value.floor() % 3;
    return widgets[ix];
  }
}