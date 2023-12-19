// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// //todo business logic and ui should be separate
// //todo use of bloc and setState together? suggest only use one or just use bloc for better code readability
// //todo try to add comment (//) documentary (///) for each function for better explanation
// //todo OnboardingOtpScreen is a screen for user to wait for their OTP after user insert their phone number (previous screen)
// class OnboardingOtpScreen extends StatefulWidget {
//   OnboardingOtpScreen(
//       {Key? key,
//       required this.mobileNo,
//       required this.userId,
//       required this.email,
//       required this.password,
//       this.userProfileBean,
//       this.registrationBean,
//       this.option = OtpOption.PHONE,
//       this.otpVerifyPurpose = OtpVerifyPurpose.FIRSTTIMELOGIN})
//       : super(key: key);
//   String mobileNo;
//   String userId;
//   String email;
//   String password;
//
//   // For Login
//   UserProfileBean? userProfileBean;//todo data class
//
//   // For Registration
//   RegistrationBean? registrationBean;//todo data class
//   OtpOption option;//todo data class
//   OtpVerifyPurpose otpVerifyPurpose;//todo data class
//
//   @override
//   State<OnboardingOtpScreen> createState() => _OnboardingOtpScreenState();
// }
//
// class _OnboardingOtpScreenState extends State<OnboardingOtpScreen> {
//   late RegistrationBloc _registrationBloc;
//   late UserBloc _userBloc;
//   late OTPBloc _otpBloc;
//   late SendOTPBean _sendOTPBean;
//   SentOTPBean? _sentOTPBean;//todo possible null at line 98
//   late String errorText;
//   String? activationErrorText;//todo unused variable, remove it
//   late OtpFieldController _otpFieldController;
//   bool countingDown = false;
//
//   @override
//   void initState() {
//     super.initState();
//     errorText = "";
//     //todo are RegistrationBloc, OTPBloc, UserBloc already instantiate elsewhere? if yes just call the bloc via BlocProvider.of<XXX>(context)
//     _registrationBloc = RegistrationBloc();//todo combine multiple together using MultiBlocProvider/MultiBlocListener, put it in build method
//     _otpBloc = OTPBloc();//todo combine multiple together using MultiBlocProvider/MultiBlocListener, put it in build method
//     _userBloc = UserBloc();//todo combine multiple together using MultiBlocProvider/MultiBlocListener, put it in build method
//     _otpFieldController = OtpFieldController(onVerify: (otpValue) {
//       verifyOTP(otpValue);
//     });
//     _sendOTPBean = SendOTPBean(mobileNo: widget.mobileNo, userId: widget.userId, option: widget.option.optionName, email: widget.email);
//     if (kReleaseMode) {
//       WidgetsBinding.instance.addPostFrameCallback((_) async {
//         _initSendOtp();
//       });
//     }
//   }
//
//   //todo create a new bloc for this page called OTPScreenBloc, example in build
//   _initSendOtp() async {
//     //TODO: Currently By Pass OTP, OTP Integration Testing Successful. Uncomment this before compile
//     //todo not sure what is the uncomment/comment about, suggest use conditional function instead of doing this manually
//     final loadingDialog = ViewBloc.showLoadingDialog(context, "${mtl("otpSending")}${StringUtil.maskString(widget.mobileNo)}");
//     dynamic result = await _otpBloc.sendOtp(_sendOTPBean);
//     await Future.delayed(const Duration(milliseconds: 80));//todo unnecessary delayed, use addPostFrameCallback
//     loadingDialog.dismiss(() {});
//     // If OTP sent successful, it will return SentOTPBean else it's a error message
//     if (result.runtimeType == SentOTPBean) {
//       _sentOTPBean = result;
//       setState(() {//todo use bloc
//         countingDown = true;
//         errorText = "";
//       });
//     } else {
//       setState(() {//todo use bloc
//         errorText = result.toString();
//       });
//     }
//   }
//
//   //todo use bloc and emit event, bloc state contain errorText, countingDown
// // In debug mode, no OTP is required.
//   Future<void> verifyOTP(String otpValue) async {
//     bool verifyResult = true;
// // If it's in release mode, this should be execute to verify the OTP
//     if (kReleaseMode) {
//       final loadingDialog = ViewBloc.showLoadingDialog(context, mtl("otpVerifying"));
//       //todo if _sentOTPBean is null, SentOTPBean is default value and the result will always be false?
//       verifyResult = await _otpBloc.verifyOtp(
//           otpValue, _sendOTPBean.userId, _sentOTPBean ?? SentOTPBean(otpRefNo: "", resendIntervalInMins: 0, otpMaxReattempt: 0), context,
//           (errMsg) {
//         setState(() {//todo use bloc
//           errorText = errMsg;
//         });
//       });
//       await Future.delayed(const Duration(milliseconds: 2000));//todo unnecessary delayed, use addPostFrameCallback
//       loadingDialog.dismiss(() {});
//     }
// // In debug mode, this checking will always true
//     if (verifyResult || kDebugMode) {
//       await ViewBloc.showSuccessDialogForAwhile(context, successMessage: mtl("otpVerified"));
// //After verification success, different process for firs-time login and registration
//       if (widget.otpVerifyPurpose.verifyPurposeName == OtpVerifyPurpose.REGISTRATION.verifyPurposeName) {
//         processForRegistration();
//       } else if (widget.otpVerifyPurpose.verifyPurposeName == OtpVerifyPurpose.FIRSTTIMELOGIN.verifyPurposeName) {
//         processForFirstTimeLogin();
//       } else if (widget.otpVerifyPurpose.verifyPurposeName == OtpVerifyPurpose.CHANGEPASSWORD.verifyPurposeName) {
//         processForChangePassword();
//       } else {
//         processForResetPassword();
//       }
//     } else {
// //Verification failed, delete all the text field and re-enter
//       _otpFieldController.verifyUnsuccessful();
//     }
//   }
//
//   //todo should be inside bloc and emit event
//   Future<void> processForRegistration() async {
//     bool isCustomer = widget.registrationBean?.isCustomer ?? false;
//     if (!isCustomer) {
//       final result = await _registrationBloc.sendValidationEmail(_sendOTPBean.userId, _sendOTPBean.email ?? "", context);
//       if (result) {
//         //todo show alert dialog and pop result later might just close the alert dialog?
//         final completed = await ViewBloc.showAlertDialog(context,//todo showAlertDialog can be put inside bloc listener
//             title: "${mtl("verifyEmailSuccess")} ${_sendOTPBean.email ?? ""}\n${mtl("verifyEmailSuccess2")}",
//             illustration: loadSvg("pictogram/email.svg", color: null),
//             positiveText: mtl("okButton"), onPressedPositive: () {
//           NUINavigator.popWithResult(context, true);
//         });
//         if (completed) {
//           NUINavigator.popAllAndPush(context, const BaseScreen());
//         }
//         return;
//       } else {
//         await Future.delayed(const Duration(milliseconds: 80));//todo unnecessary delayed, use addPostFrameCallback
//         NUINavigator.popAllAndPush(context, const BaseScreen());
//         return;
//       }
//     } else {
//       final result = await _registrationBloc.accountActivation(_sendOTPBean.userId, _sendOTPBean.email ?? "", context);
//       if (result) {
//         await Future.delayed(const Duration(milliseconds: 80));//todo unnecessary delayed, use addPostFrameCallback
//         NUINavigator.push(
//             context,
//             SuccessScreen(
//                 title: mtl("regisSuccess"),
//                 description: mtl("regisSuccessDesc"),
//                 illus: loadSvg("pictogram/correct_tick.svg", color: null),
//                 popAll: true));
//       } else {
// // Account activation failed, redirect to base screen
//         await Future.delayed(const Duration(milliseconds: 80));//todo unnecessary delayed, use addPostFrameCallback
//         NUINavigator.popAllAndPush(context, const BaseScreen());
//       }
//     }
//   }
//
//   //todo should be inside bloc and emit event
//   Future<void> processForFirstTimeLogin() async {
// //First time login, user will only be saved once OTP success
//     UserProfileBean? userProfileBean = widget.userProfileBean;
//     if (userProfileBean != null) {
//       try {
//         await _userBloc.saveUserToDB(userProfileBean);
//         await _userBloc.saveToken(userProfileBean.loginAccessToken?.accessToken ?? "", userProfileBean.loginAccessToken?.refreshToken ?? "",
//             userProfileBean.loginAccessToken?.expiresIn ?? 0);
//         _userBloc.changeIPushUserId();
//         await Future.delayed(const Duration(milliseconds: 80));//todo unnecessary delayed, use addPostFrameCallback
// // await ViewBloc.showSuccessDialogForAwhile(context, successMessage: mtl("loginSuccessDialog"));
//         NUINavigator.push(context, SuccessScreen(title: mtl("verifySuccess"), popAll: true));
//       } catch (e) {
//         logNUI("Otp Screen", "First-time Login Error : $e");
//         await ViewBloc.showFailedDialogForAwhile(
//           context,
//           errorMessage: mtl("loginUnsuccessfulDialog"),
//         );
//         NUINavigator.popAllAndPush(context, const BaseScreen());
//       }
//     }
//   }
//
//   //todo should be inside bloc and emit event
//   Future<void> processForResetPassword() async {
//     NUINavigator.popAndPush(
//         context,
//         NewPasswordScreen(
//           isFirstStep: false,
//           userId: widget.userId,
//         ));
//   }
//
//   //todo should be inside bloc and emit event
//   Future<void> processForChangePassword() async {
//     NUINavigator.popAndPush(context, NewPasswordScreen(isFirstStep: false, userId: widget.userId, inAppChangePassword: true));
//   }
//
//   //todo should be inside bloc and emit event
//   Future<bool> showTerminateDialog() async {
//     final result = await ViewBloc.showAlertDialog(context,
//         title: "${mtl("otpTerminateDialog")} ${widget.otpVerifyPurpose.name} ${mtl("otpTerminateDialog2")}",
//         positiveText: mtl("yes"),
//         onPressedPositive: () {
//           NUINavigator.popWithResult(context, true);
//         },
//         negativeText: mtl("no"),
//         onPressedNegative: () {
//           NUINavigator.popWithResult(context, false);
//         });
//     return result;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //todo use of bloc but without blocProvider/BlocBuilder here? use blocProvider/BlocBuilder
//     //todo use MultiBlocListener/MultiBlocProvider here
//     //   BlocProvider(
//     //     create: (BuildContext context) => OTPScreenBloc(RegistrationBloc(),OTPBloc(),UserBloc())..add(SendOtpStart()),//todo on result emit event SendOtpResult
//     //     child: BlocBuilder<OTPScreenBloc, OTPScreenState>(
//     //       builder: (context, state) {
//     //         return switch (state) {
//     //              SendOtpResult() =>
//     //             }
//     //   )
//     return WillPopScope(
//       onWillPop: () async {
//         return await showTerminateDialog();
//       },
//       child: AnnotatedRegion<SystemUiOverlayStyle>(
//           value: SystemUiOverlayStyle.dark,//todo always dark mode? use theme in materialApp
//           child: Scaffold(
//             backgroundColor: AppColors.BackgroundWhite,//todo inconsistent color references, there is no usage of AppColors anywhere in this code
//             body: Column(
//               children: [
//                 BackToolbar(
//                   title: Text(
//                     mtl("verification"),
//                     style: uiTheme.font(size: 18, colorPair: accentBlue),
//                     textAlign: TextAlign.center,
//                   ),
//                   withShadow: true,
//                   withStatusBar: true,
//                   backButton: true,
//                   backIcon: Icon(Icons.arrow_back_rounded, color: uiTheme.color(accentBlue)),
//                   onPressed: () async {
//                     final result = await showTerminateDialog();
//                     if (result) {
//                       NUINavigator.pop(context);
//                     }
//                   },
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "${widget.otpVerifyPurpose.verifyPurposeName} ${mtl("verification")}",
//                             style: uiTheme.font(size: 18, colorPair: darkBlue),
//                           ),
//                           const Divider(height: 16),
//                           Text(mtl("otpDesc"), style: uiTheme.font(size: 16, colorPair: greyTwo)),
//                           const Divider(height: 30),
//                           Text(isNullOrEmpty(errorText) ? "" : errorText, style: uiTheme.font(size: 14, colorPair: red)),//todo isNullOrEmpty can replace with extension method
//                           const Divider(height: 8),
//                           OtpField(
//                             otpFieldController: _otpFieldController,
//                           ),
//                           const Divider(height: 15),
//                           Visibility(
//                               visible: countingDown,
//                               child: Text("OTP has been sent to ${StringUtil.maskString(widget.mobileNo)}.",//todo can use localization instead of hardcoded
//                                   style: uiTheme.font(size: 14, colorPair: darkBlue))),
//                           const Divider(height: 30),
//                           Align(
//                             alignment: Alignment.center,
//                             child: RichText(//todo unnecessary richtext, why use richtext when you only has 1 textspan? replace with text with gestureDetector
//                               textAlign: TextAlign.center,
//                               text: TextSpan(
//                                 text: '${mtl("otpDidNotGetCode")}  ',
//                                 style: uiTheme.font(size: 18, colorPair: darkBlue),
//                                 children: [
//                                   TextSpan(
//                                     text: mtl("otpResend"),
//                                     style: uiTheme.font(
//                                         size: 18,
//                                         color: countingDown ? uiTheme.color(accentBlue).withOpacity(0.3) : uiTheme.color(accentBlue)),
//                                     recognizer: TapGestureRecognizer()
//                                       ..onTap = countingDown
//                                           ? null
//                                           : () async {
//                                               await _initSendOtp();
//                                             },
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const Divider(height: 8),
//                           Visibility(
//                               visible: countingDown,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text("Resend in ", style: uiTheme.font(size: 14, colorPair: darkBlue)),
//                                   CustomTimer(
//                                     seconds: 305,
//                                     onFinished: () {
//                                       countingDown = false;
//                                       setState(() {});//todo use bloc
//                                     },
//                                   ),
//                                 ],
//                               )),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }
