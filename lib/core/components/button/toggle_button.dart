import 'package:flutter/material.dart';
import 'package:flutter_mood_tracker/core/consts/decoration/shadow.dart';


class ToggleButton extends StatefulWidget {
  const ToggleButton({
    Key? key, 
    required this.onpressed,
    required Color notSelectedColor,
    required Color selectedColor,
    required Widget notSelectedChild,
    required Widget selectedChild,
    Color? borderColor,
    double? width,
    double? heigth,
    double? borderRadius,
    }):
      _notSelectedColor = notSelectedColor,
      _selectedColor = selectedColor,
      _child = notSelectedChild,
      _selectedChild = selectedChild,
      _width = width ?? 100,
      _height = heigth ?? 100,
      _borderRadius = borderRadius ?? 10.0,
      _borderColor = borderColor ?? Colors.black12,
      super(key: key);

  final void Function(bool isSelected) onpressed;
  final Widget _child;
  final Widget _selectedChild;
  final double _width;
  final double _height;
  final Color _selectedColor;
  final Color _notSelectedColor;
  final double _borderRadius;
  final Color _borderColor;


  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  
  bool _isSelected = false;
  bool _isTapDown = false;

  void _onPressed(){
    widget.onpressed.call(_isSelected);
    setState(() {
      _isSelected = !_isSelected;    
    });
  }

  void _isTapDownChange(){
      setState(() {
        _isTapDown = !_isTapDown;
      });
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: widget._width,
      height: widget._height,
      child: Center(
        child: button(),
        ),
      );
  }

  AnimatedContainer button(){
    return AnimatedContainer(
          duration: ToggleButtonConsts().animationDuration,
          width: _isTapDown ? widget._width - (widget._width) * ToggleButtonConsts().smallerPercent : widget._width, 
          height: _isTapDown ? widget._height - (widget._height) * ToggleButtonConsts().smallerPercent  : widget._height,
          child: GestureDetector(
            onTap: _onPressed,
            onTapDown: (details) {_isTapDownChange();},
            onTapCancel: _isTapDownChange,
            child: AnimatedContainer(
              duration: ToggleButtonConsts().animationDuration,
              decoration: BoxDecoration(
              border: _isTapDown ? 
              Border.fromBorderSide(BorderSide(color: widget._borderColor.withOpacity(0.2))):
              Border.fromBorderSide(BorderSide(color: widget._borderColor.withOpacity(0.08))),
              color: _isSelected ? widget._selectedColor : widget._notSelectedColor, 
              borderRadius: BorderRadiusDirectional.all(Radius.circular(widget._borderRadius)),
              boxShadow: [
                _isTapDown ?  const BoxShadow() : simpleBoxShadow,
              ],
            ),
            //For sizing child., wrap with padding your child widget. 
            child: SizedBox(width: double.infinity, height: double.infinity, 
              child: FittedBox(fit: BoxFit.fitHeight,
                child: _isSelected ? widget._selectedChild : widget._child
              ),
            )
              ),
          ),
        );
  }
}

class ToggleButtonConsts {
  final Duration animationDuration = const Duration(milliseconds: 100);
  final double smallerPercent = 0.05;
}