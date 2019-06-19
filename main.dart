import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(LogoApp());

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

// SingleTickerProviderStateMixin, it tells Flutter that there is some animation
// in this widget and this widget needs to notified about the animation frames of flutter.
class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController controller;


  @override
  void initState(){
    super.initState();
    controller = 
      AnimationController(duration: const Duration(seconds: 1), vsync: this);   //the vsync is needed for SingleTickerProviderStateMixin 
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addStatusListener((status){
        if (status == AnimationStatus.completed){
          controller.reverse();
        }
        else if(status == AnimationStatus.dismissed){
          controller.forward();
        }
      })
      ..addStatusListener((state) => print('$state'));
          
      controller.forward();    
      AnimationStatus.forward;
      AnimationStatus.completed;                                                                                                                                           
  }
  
  @override
  Widget build(BuildContext context) => GrowTransition(
    child: LogoWidget(),
    animation: animation,
  );
  



  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
}





class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: FlutterLogo(),
    );
  }
}



class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Container(
          height: animation.value,
          width: animation.value,
          child: child,
        ),

        child: child,

      ),
    );
  }
}
