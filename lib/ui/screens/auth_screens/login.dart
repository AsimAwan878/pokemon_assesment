import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pokemon/bloc/app_bloc.dart';
import 'package:pokemon/ui/custom_widget/custom_text_form_field.dart';
import 'package:pokemon/ui/custom_widget/cutom_button.dart';
import 'package:pokemon/utils/constants/constants.dart';
import 'package:pokemon/utils/constants/image_path.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pokemon/utils/pref_utils/prefs_keys.dart';
import 'package:pokemon/utils/pref_utils/shared_prefs.dart';
import 'package:pokemon/utils/routes/route_names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController? _userEmailController, _userPassController;

  @override
  void initState() {
    _userEmailController = TextEditingController();
    _userPassController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _userEmailController!.dispose();
    _userPassController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return  Scaffold(
              body: state.isLoading
                  ? Center(
                  child: CircularProgressIndicator(
                    color: defaultDarkColor,
                  ))
                  :Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  clipBehavior: Clip.none,
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    width: screenWidth(context, 1),
                    height: screenHeight(context, 1),
                    child: Padding(
                      padding: globalHorizontalPadding36(context),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(
                            flex: 1,
                          ),
                          //Logo
                          Image.asset(
                            ImagePath.appLogo,
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          SizedBox(
                            child: Text(
                              "Enter Email and\nPassword to Login",
                              style: text28p500(
                                  context, color: defaultDarkColor),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: screenHeight(context, 0.01)),
                            child: _dataField(
                              context,
                              fieldName: "User Email",
                              hintText: "Enter Your Email",
                              controller: _userEmailController!,
                              validator: FormBuilderValidators.compose([
                                // Makes this field required
                                FormBuilderValidators.required(),
                                // makes this field perfect for email
                                FormBuilderValidators.email(),
                              ]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: screenHeight(context, 0.01)),
                            child: _dataField(
                                context,
                                fieldName: "User Password",
                                hintText: "Enter Your Password",
                                controller: _userPassController!,
                                isObscure: true,
                                isPassField: true,
                                validator: FormBuilderValidators.required(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: screenHeight(context, 0.01)),
                            child: CustomButton(
                              onTap: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (_formKey.currentState!.validate()) {
                                  try{
                                    context.read<AppBloc>().add(
                                        AppEventLogIn(
                                            email: _userEmailController!.text,
                                            password: _userPassController!.text));
                                    Prefs.setBool(UserInfoKeys.oneTimeLogin, true);
                                    Navigator.pushReplacementNamed(context, RouteNames.homeRoute);
                                  }catch(e){
                                    print("Exception2 = $e");
                                    Fluttertoast.showToast(
                                      msg: e.toString(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP_LEFT,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: defaultColor,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }

                                }
                              },
                              buttonText: 'Login',
                              textColor: defaultDarkColor,
                              fillColor: defaultColor,
                              buttonHeight: screenHeight(context, 0.062),
                              buttonWidth: screenWidth(context, 1),
                              textFontSize: 14,
                              textFontWeight: FontWeight.w400,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, RouteNames.signUpScreenRoute);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context, 0.02)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: "Don't have an Account?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: defaultDarkColor),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: ' signup',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration
                                                    .underline,
                                                color: defaultDarkColor)),
                                      ],
                                    ),


                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
        }
    ),
          );
  }

  Future<bool> onWillPop() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: defaultDarkColor,
        content: const Text(
          'Are you sure you want to exit?',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: "Segoe UI",
              color: Colors.white),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () async {
              exit(0);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )),
              backgroundColor: MaterialStateProperty.all(
                Colors.white,
              ),
            ),
            child: Container(
              width: 60,
              height: 40,
              alignment: Alignment.center,
              child: const Text(
                "Yes",
                style: TextStyle(
                    color: defaultDarkColor,
                    fontFamily: "Segoe UI",
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'No',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ).then((x) => x ?? false);
  }

  Widget _dataField(
      BuildContext context, {
        required String fieldName,
        required String hintText,
        required TextEditingController controller,
        required String? Function(String?)? validator,
        bool isObscure = false,
        bool isPassField = false,
      }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: fieldName,
          ),
        ),
        CustomTextFormField(
          textFieldColor: Colors.white,
          hintText: hintText,
          keyBoardType: TextInputType.name,
          validator: validator,
          controller: controller,
          textStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
          hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
          isObscure: isObscure,
          isPassField: isPassField,
        ),
      ],
    );
  }
}
