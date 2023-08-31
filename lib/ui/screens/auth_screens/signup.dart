
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pokemon/bloc/app_bloc.dart';
import 'package:pokemon/ui/custom_widget/custom_text_form_field.dart';
import 'package:pokemon/ui/custom_widget/cutom_button.dart';
import 'package:pokemon/utils/constants/constants.dart';
import 'package:pokemon/utils/constants/image_path.dart';
import 'package:pokemon/utils/routes/route_names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController? _userEmailController, _userPassController, _userConfirmPassController;

  @override
  void initState() {
    _userEmailController = TextEditingController();
    _userPassController = TextEditingController();
    _userConfirmPassController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _userEmailController!.dispose();
    _userPassController!.dispose();
    _userConfirmPassController!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return Scaffold(
              body: state.isLoading
                  ? Center(
                  child: CircularProgressIndicator(
                    color: defaultDarkColor,
                  ))
                  : Form(
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              child: _dataField(
                                context,
                                fieldName: "Confirm Password",
                                hintText: "Confirm your Password",
                                controller: _userConfirmPassController!,
                                validator: _validatePasswordMatch,
                                isObscure: true,
                                isPassField: true,
                              )
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: screenHeight(context, 0.01)),
                            child: CustomButton(
                              onTap: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (_formKey.currentState!.validate()) {
                                  try{
                                    context.read<AppBloc>().add(AppEventRegister(
                                        email: _userEmailController!.text,
                                        password: _userPassController!.text));
                                    Navigator.pushReplacementNamed(context, RouteNames.loginScreenRoute);
                                  }catch(e){
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
                              buttonText: 'Sign Up',
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
                                  context, RouteNames.loginScreenRoute);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context, 0.02)),
                              child: RichText(
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: "Already have an Account?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: defaultDarkColor),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' Login',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration
                                                .underline,
                                            color: defaultDarkColor)),
                                  ],
                                ),


                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 2,
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
    Navigator.pushReplacementNamed(context, RouteNames.loginScreenRoute);
    return Future.value(true);
  }



  String? _validatePasswordMatch(String? value) {
    if (value != _userPassController!.text) {
      return 'Password do not match';
    }
    return null;
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

