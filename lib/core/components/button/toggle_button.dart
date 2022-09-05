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
    required bool isSelected,
    Color? borderColor,
    double? width,
    double? heigth,
    double? borderRadius,
  })  : _notSelectedColor = notSelectedColor,
        _selectedColor = selectedColor,
        _child = notSelectedChild,
        _selectedChild = selectedChild,
        _isSelected = isSelected,
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
  final bool _isSelected;
  final Color _selectedColor;
  final Color _notSelectedColor;
  final double _borderRadius;
  final Color _borderColor;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  late bool _isSelected;
  final bool _isTapDown = false;
  @override
  void initState() {
    super.initState();
    _isSelected = widget._isSelected;
  }

  @override
  void didUpdateWidget(covariant ToggleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isSelected = widget._isSelected;
  }

  void _onPressed() {
    widget.onpressed.call(_isSelected);
  }

  void _onTap() {
    _isSelectedChange();
  }

  void _isSelectedChange() {
    setState(() {
      _isSelected = !_isSelected;
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

  AnimatedContainer button() {
    return AnimatedContainer(
      duration: ToggleButtonConsts().animationDuration,
      width: (_isSelected)
          ? widget._width -
              (widget._width) * ToggleButtonConsts().smallerPercent
          : widget._width,
      height: (_isSelected)
          ? widget._height -
              (widget._height) * ToggleButtonConsts().smallerPercent
          : widget._height,
      child: GestureDetector(
        onTap: () {},
        onTapDown: (details) {
          _isSelectedChange();
        },
        onTapUp: (details) {
          _onPressed();
        },
        onTapCancel: _isSelectedChange,
        child: AnimatedContainer(
            duration: ToggleButtonConsts().animationDuration,
            decoration: BoxDecoration(
              border: _isTapDown
                  ? Border.fromBorderSide(
                      BorderSide(color: widget._borderColor.withOpacity(0.2)))
                  : Border.fromBorderSide(
                      BorderSide(color: widget._borderColor.withOpacity(0.08))),
              color: _isSelected
                  ? widget._selectedColor
                  : widget._notSelectedColor,
              borderRadius: BorderRadiusDirectional.all(
                  Radius.circular(widget._borderRadius)),
              boxShadow: [
                _isSelected ? const BoxShadow() : simpleBoxShadow,
              ],
            ),
            child: FittedBox(
                fit: BoxFit.fitHeight,
                child: _isSelected ? widget._selectedChild : widget._child)),
      ),
    );
  }
}

class ToggleGroup extends StatefulWidget {
  const ToggleGroup({
    Key? key,

    //When ToggleButton selected => child of button at index = widget in selectedChildList[index].
    required this.selectedChildList,

    //Taking this list and set button's isSelected in initState. Has to be only one true.
    //When a toggle button clicked => isSelectedBoolList[index of clicked button] equals true and rest of it equals false.
    required this.isSelectedBoolList,

    //When toggle button clicked, this function throw back isSelectedBoolList.
    required this.onPressed,

    //When toggle button not selected => child of button at index = widget in notSelectedChildList[index].
    required this.notSelectedChildList,

    //When a button selected => background color of selected button = selectedColor.
    required this.selectedColor,

    //When a button selected => Rest of button's background color = notSelectedColor.
    required this.notSelectedColor,

    //Buttons size attributes.
    required this.buttonWidth,
    required this.buttonHeight,

    //Working like mainAxisAlginment in Column||Row
    AxisAlignment? alignment,

    //Buttons padding.
    EdgeInsets? toggleButtonPadding,

    //You can use this if you want to add padding for only first child.
    EdgeInsets? firstChildButtonPadding,

    //You can change scroll physic of listView.
    ScrollPhysics? scrollPhysics,

    //You can add widget end of toggle button list.
    Widget? lastWidget,

    //Border radius for border shape.
    double? borderRadius,
  })  : toggleButtonPadding = toggleButtonPadding ?? EdgeInsets.zero,
        firstChildButtonPadding =
            firstChildButtonPadding ?? toggleButtonPadding ?? EdgeInsets.zero,
        alignment = alignment ?? AxisAlignment.spaceEvenly,
        scrollPhysics = scrollPhysics ?? const NeverScrollableScrollPhysics(),
        lastWidget = lastWidget ?? const SizedBox.shrink(),
        borderRadius = borderRadius ?? 25,
        super(key: key);

  final Function(List<bool> boolList) onPressed;
  final List<Widget> selectedChildList;
  final List<Widget> notSelectedChildList;
  final Color selectedColor;
  final Color notSelectedColor;
  final List<bool> isSelectedBoolList;
  final double buttonWidth;
  final double buttonHeight;
  final AxisAlignment alignment;
  final EdgeInsets toggleButtonPadding;
  final EdgeInsets firstChildButtonPadding;
  final ScrollPhysics scrollPhysics;
  final Widget lastWidget;
  final double borderRadius;

  @override
  State<ToggleGroup> createState() => _ToggleGroupState();
}

class _ToggleGroupState extends State<ToggleGroup> {
  @override
  void initState() {
    super.initState();

    //Checking isSelectedBoolList has only one true;
    if (!isTrueOnlyOne(widget.isSelectedBoolList)) {
      throw Exception(
          'ToggleGroup construction error: isSelectedBoolList has to be only one true item.');
    }

    //Checking selectedChild and not selectedChild count equals.
    if (widget.selectedChildList.length != widget.notSelectedChildList.length) {
      throw Exception(
          'ToggleGroup construction error: selectedChildList.lenght has to be equals notSelectedChildList.lenght');
    }

    //Checking selectedChild||notSelectedChild and isSelectedBoolList count equals.
    if (widget.selectedChildList.length != widget.isSelectedBoolList.length ||
        widget.notSelectedChildList.length !=
            widget.isSelectedBoolList.length) {
      throw Exception(
          'ToggleGroup construction error: isSelectedBoolList.lenght has to be equals selected/notSelectedChildList.lenght.');
    }
  }

  bool isTrueOnlyOne(List<bool> list) {
    int counter = 0;
    for (var item in list) {
      if (item == true) {
        counter++;
        if (counter >= 2) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.buttonHeight + widget.buttonHeight * 0.3,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return ListView.separated(
            physics: widget.scrollPhysics,
            scrollDirection: Axis.horizontal,
            itemCount: widget.selectedChildList.length + 1,
            itemBuilder: (context, index) {
              return index != widget.selectedChildList.length
                  ? Padding(
                      padding: index == 0
                          ? widget.firstChildButtonPadding
                          : widget.toggleButtonPadding,
                      child: ToggleButton(
                        width: widget.buttonWidth,
                        heigth: widget.buttonHeight,
                        onpressed: (isSelected) {
                          setState(() {
                            widget.isSelectedBoolList.fillRange(
                                0, widget.isSelectedBoolList.length, false);
                            widget.isSelectedBoolList[index] = true;
                            widget.onPressed.call(widget.isSelectedBoolList);
                          });
                        },
                        notSelectedChild: widget.notSelectedChildList[index],
                        notSelectedColor: widget.notSelectedColor,
                        selectedChild: widget.selectedChildList[index],
                        selectedColor: widget.selectedColor,
                        isSelected: widget.isSelectedBoolList[index],
                        borderRadius: widget.borderRadius,
                      ),
                    )
                  : Padding(
                      padding: widget.toggleButtonPadding,
                      child: widget.lastWidget,
                    );
            },
            separatorBuilder: (BuildContext context, int index) {
              //For MainAxisAlignment.spaceevenly effect, calculating space between buttons.
              return (widget.alignment == AxisAlignment.spaceEvenly)
                  ? (index != widget.selectedChildList.length - 1
                      ? SizedBox(
                          width: (constraints.maxWidth -
                                  (widget.buttonWidth *
                                      widget.selectedChildList.length)) /
                              (widget.selectedChildList.length - 1))
                      : const SizedBox.shrink())
                  : (const SizedBox.shrink());
            },
          );
      }),
    );
  }
}

enum AxisAlignment { none, spaceEvenly }

class ToggleButtonConsts {
  final Duration animationDuration = const Duration(milliseconds: 100);
  final double smallerPercent = 0.05;
}
