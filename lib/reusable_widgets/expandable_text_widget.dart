import 'package:flutter/material.dart';
import 'package:foodart/reusable_widgets/small_text.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:foodart/utilities/dimensions.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;

  const ExpandableTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late final String firstHalf;
  late final String secondHalf;
  final double allowedtextHeight = Dimensions.height150;
  bool textHidden = true;
  @override
  void initState() {
    super.initState();
    if (widget.text.length > allowedtextHeight) {
      firstHalf = widget.text.substring(0, allowedtextHeight.toInt());
      secondHalf = widget.text
          .substring(allowedtextHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
      child: secondHalf.isEmpty
          ? SmallText(
              text: firstHalf,
              textColor: AppColors.paraColor,
            )
          : Column(children: [
              textHidden
                  ? SmallText(
                      text: firstHalf + "...",
                      textColor: AppColors.paraColor,
                    )
                  : SmallText(
                      text: firstHalf + secondHalf,
                      textColor: AppColors.paraColor,
                    ),
              InkWell(
                onTap: () {
                  setState(() {
                    textHidden = !textHidden;
                  });
                },
                child: Row(children: [
                  SmallText(
                    text: textHidden ? "Show more" : "Show less",
                    textColor: AppColors.mainColor,
                  ),
                  textHidden
                      ? const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.mainColor,
                        )
                      : const Icon(
                          Icons.arrow_drop_up,
                          color: AppColors.mainColor,
                        )
                ]),
              )
            ]),
    );
  }
}
