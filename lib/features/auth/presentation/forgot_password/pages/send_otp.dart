import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../core/core.dart';

class SendOTP extends HookConsumerWidget {
  const SendOTP({
    super.key,
    required this.phoneController,
    required this.token,
    required this.pageController,
  });

  final TextEditingController phoneController;
  final ValueNotifier<String> token;
  final PageController pageController;

  @override
  Widget build(BuildContext context, ref) {
    // Controller
    final controller = useMemoized(() => CountdownController(autoStart: true));
    return SingleChildScrollView(
      child: ContainerBGWhiteScaleFromMiddle(
        margin: EdgeInsets.symmetric(horizontal: 32.w),
        bgColor: AppColors.bg200,
        child: Column(
          crossAxisAlignment: crossStart,
          mainAxisSize: MainAxisSize.min,
          children: [
            gap8,
            KTextFormField2(
              containerPadding: padding0,
              controller: phoneController,
              keyboardType: TextInputType.text,
              hintText: AppStrings.phoneNumber,
            ),
            gap24,
            KFilledButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                // ref
                //     .read(authProvider.notifier)
                //     .forgotPassword(phoneController.text)
                //     .then((value) => value
                //         ? showDialog(
                //             context: context,
                //             barrierDismissible: false,
                //             barrierLabel: "Barrier",
                //             useSafeArea: true,
                //             builder: (context) => AlertDialog(
                //               content: OtpCheckWidget(
                //                 controller: controller,
                //                 onTapOtpCheck: (otp) async => ref
                //                     .read(authProvider.notifier)
                //                     .verifyOtp(otp)
                //                     .then((value) {
                //                   if (value.isNotBlank) {
                //                     token.value = value;
                //                     Navigator.pop(context);
                //                     pageController.nextPage(
                //                         duration: 500.milliseconds,
                //                         curve: Curves.easeIn);
                //                   }
                //                 }),
                //               ),
                //             ),
                //           )
                //         : null);
                showOTPDialog(
                  context: context,
                  controller: controller,
                  onFinishedTimer: () => Navigator.pop(context),
                  onTapOtpCheck: (otp) async {
                    //  ref
                    //     .read(authProvider.notifier)
                    //     .verifyOtp(otp)
                    //     .then((value) {
                    //   if (value.isNotBlank) {
                    //     token.value = value;
                    //     Navigator.pop(context);
                    //     pageController.nextPage(
                    //         duration: 500.milliseconds,
                    //         curve: Curves.easeIn);
                    //   }
                    // });
                    Navigator.pop(context);
                    pageController.nextPage(
                        duration: 500.milliseconds, curve: Curves.easeIn);
                  },
                );
              },
              text: AppStrings.sendOtp,
            ),
          ],
        ),
      ),
    );
  }
}
