import 'package:flutter/material.dart';

import '../../consts/size.dart';

class HeaderTextWidget extends StatelessWidget {
  const HeaderTextWidget({
    Key? key,
    required this.text,
    }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
            fontSize: FontSizes.header.value(),
            fontWeight: FontWeights.header.value()));
  }
}
