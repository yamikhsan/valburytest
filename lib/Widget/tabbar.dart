import 'package:flutter/material.dart';
import 'package:valburytestapp/Widget/list_item.dart';
import 'package:valburytestapp/repository.dart';

class Tabbar extends StatefulWidget {
  final String type;
  const Tabbar({Key? key,required this.type,}) : super(key: key);

  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> with TickerProviderStateMixin {

  TabController? _controller;
  AnimationController? _animationControllerOn;
  AnimationController? _animationControllerOff;
  Animation? _colorTweenBackgroundOn;
  Animation? _colorTweenBackgroundOff;
  Animation? _colorTweenForegroundOn;
  Animation? _colorTweenForegroundOff;
  int _currentIndex = 0;
  int _prevControllerIndex = 0;
  double _aniValue = 0.0;
  double _prevAniValue = 0.0;
  List<String> _title = ['SEMUA'];
  List<Widget> listWidget = List.empty(growable: true);

  Color _foregroundOn = Colors.white;
  Color _foregroundOff = Colors.black;
  Color _backgroundOn = Colors.blue;
  Color _backgroundOff = Colors.white;
  ScrollController _scrollController = new ScrollController();
  List _keys = [];
  bool _buttonTap = false;

  @override
  void initState() {
    super.initState();
    dummyData.forEach((element) {
      if(element['type'] == widget.type){
        _title.add(element['category'].toString());
      }
    });
    _title = _title.toSet().toList();
    _title.forEach((element) {
      Widget? listItem = MyListItem(type: widget.type, category: element,);
      listWidget.add(listItem);
    });

    for (int index = 0; index < _title.length; index++) {
      _keys.add(new GlobalKey());
    }
    _controller = TabController(vsync: this, length: _title.length);
    _controller?.animation?.addListener(_handleTabAnimation);
    _controller?.addListener(_handleTabChange);

    _animationControllerOff =
        AnimationController(vsync: this, duration: Duration(milliseconds: 75));
    _animationControllerOff?.value = 1.0;
    _colorTweenBackgroundOff =
        ColorTween(begin: _backgroundOn, end: _backgroundOff)
            .animate(_animationControllerOff!);
    _colorTweenForegroundOff =
        ColorTween(begin: _foregroundOn, end: _foregroundOff)
            .animate(_animationControllerOff!);

    _animationControllerOn =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _animationControllerOn?.value = 1.0;
    _colorTweenBackgroundOn =
        ColorTween(begin: _backgroundOff, end: _backgroundOn)
            .animate(_animationControllerOn!);
    _colorTweenForegroundOn =
        ColorTween(begin: _foregroundOff, end: _foregroundOn)
            .animate(_animationControllerOn!);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(children: <Widget>[
            Container(
                height: 49.0,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: _title.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          key: _keys[index],
                          padding: EdgeInsets.all(6.0),
                          child: ButtonTheme(
                              child: AnimatedBuilder(
                                animation: _colorTweenBackgroundOn!,
                                builder: (context, child) => FlatButton(
                                    color: _getBackgroundColor(index),
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black),
                                        borderRadius: new BorderRadius.circular(7.0)),
                                    onPressed: () {
                                      setState(() {
                                        _buttonTap = true;
                                        _controller?.animateTo(index);
                                        _setCurrentIndex(index);
                                        _scrollTo(index);
                                      });
                                    },
                                  child: Text(
                                    _title[index],
                                    style: TextStyle(color: _getForegroundColor(index)),
                                  ),
                                ),
                              )));
                    })),
            Flexible(
                child: TabBarView(
                  controller: _controller,
                  children: listWidget,
                )),
          ]),
        ));
  }

  _handleTabAnimation() {
    _aniValue = _controller!.animation!.value;
    if (!_buttonTap && ((_aniValue - _prevAniValue).abs() < 1)) {
      // set the current tab index
      _setCurrentIndex(_aniValue.round());
    }

    _prevAniValue = _aniValue;
  }

  _handleTabChange() {
    if (_buttonTap) _setCurrentIndex(_controller!.index);

    if ((_controller!.index == _prevControllerIndex) ||
        (_controller!.index == _aniValue.round())) _buttonTap = false;

    _prevControllerIndex = _controller!.index;
  }

  _setCurrentIndex(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });

      _triggerAnimation();
      _scrollTo(index);
    }
  }

  _triggerAnimation() {
    _animationControllerOn?.reset();
    _animationControllerOff?.reset();

    _animationControllerOn?.forward();
    _animationControllerOff?.forward();
  }

  _scrollTo(int index) {
    double screenWidth = MediaQuery.of(context).size.width;

    RenderBox renderBox = _keys[index].currentContext.findRenderObject();
    double size = renderBox.size.width;
    double position = renderBox.localToGlobal(Offset.zero).dx;
    double offset = (position + size / 2) - screenWidth / 2;

    if (offset < 0) {
      renderBox = _keys[0].currentContext.findRenderObject();
      position = renderBox.localToGlobal(Offset.zero).dx;
      if (position > offset) offset = position;
    } else {
      renderBox = _keys[_title.length - 1].currentContext.findRenderObject();
      position = renderBox.localToGlobal(Offset.zero).dx;
      size = renderBox.size.width;
      if (position + size < screenWidth) screenWidth = position + size;

      if (position + size - offset < screenWidth) {
        offset = position + size - screenWidth;
      }
    }

    _scrollController.animateTo(offset + _scrollController.offset,
        duration: new Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  _getBackgroundColor(int index) {
    if (index == _currentIndex) {
      return _colorTweenBackgroundOn?.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenBackgroundOff?.value;
    } else {
      return _backgroundOff;
    }
  }

  _getForegroundColor(int index) {
    if (index == _currentIndex) {
      return _colorTweenForegroundOn?.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenForegroundOff?.value;
    } else {
      return _foregroundOff;
    }
  }
}