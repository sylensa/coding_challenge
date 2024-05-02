import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// custom text filed widget
class CustomTextField extends StatefulWidget {
  final String placeholder;
   bool? obscureText;
   bool? readOnly;
  final bool? checkMark;
  final String? prefixImage;
  final int? maxLines;
  final TextDirection? textDirection;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSubmit;

   CustomTextField({Key? key, required this.placeholder, this.onChange, this.obscureText,this.onSubmit, this.controller,this.inputFormatters = const[], this.checkMark,this.textDirection = TextDirection.ltr , this.prefixImage, this.maxLines,this.readOnly = false})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String languageCode = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      textDirection:widget.textDirection,
      controller: widget.controller,
      onChanged: widget.onChange,
      onSubmitted: widget.onSubmit,
      readOnly: widget.readOnly!,
      prefix: widget.prefixImage != null ?
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset("assets/images/${widget.prefixImage}",width: 20,height: 20,),
      ) : const SizedBox.shrink(),
      padding: const EdgeInsets.all(18),
      placeholder: widget.placeholder,
      inputFormatters:widget.inputFormatters ,
      obscureText: widget.obscureText ?? false,
      placeholderStyle: const TextStyle(
        color: Color(0xFF999999),
        fontSize: 15,
      ),
      // textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,

      ),
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0XFFD8DADC)),
      ),
      suffix:
      widget.obscureText != null ?
        InkWell(
          splashColor: Colors.transparent,
          onTap: (){
            setState(() {
              widget.obscureText = !widget.obscureText!;
            });
          },
          child: Padding(
          padding: const EdgeInsets.all(18),
          child: Icon(widget.obscureText! ? Icons.visibility_off :Icons.visibility  ,color: const Color(0xFF879EA4),),
                ),
        ) : const SizedBox.shrink()
      ,
    );
  }
}

