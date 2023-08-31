
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Function() onTap;
  final String buttonText;
  final double? buttonHeight, buttonWidth;
  final Border? buttonBorder;
  final Color? fillColor;
  final Color textColor;
  final double textFontSize;
  final FontWeight textFontWeight;
  final bool disableButton;
  final BorderRadius? borderRadius;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.buttonBorder,
    this.fillColor,
    this.textColor = Colors.white,
    this.textFontSize = 16,
    this.textFontWeight = FontWeight.w700,
    this.buttonHeight,
    this.buttonWidth,
    this.disableButton = false,
    this.borderRadius,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      // onTap: null,
      child: Container(
        height: widget.buttonHeight,
        width: widget.buttonWidth,
        decoration: BoxDecoration(
          border: widget.buttonBorder,
          color: widget.disableButton
              ? widget.fillColor!.withOpacity(0.4)
              : widget.fillColor,
          // gradient: widget.showGradiantFill! ? gradientColor : null,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
          // gradient: LinearGradient()
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: widget.buttonText,
                    style: TextStyle(
                      color: widget.disableButton
                          ? widget.textColor.withOpacity(0.4)
                          : widget.textColor,
                      // fontSize: screenHeight(context, widget.textFontSize),
                      fontWeight: widget.textFontWeight,
                      fontSize: widget.textFontSize,
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}