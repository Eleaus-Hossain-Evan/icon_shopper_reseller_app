import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/core.dart';
import '../../../features/auth/presentation/forgot_password/forgot_password_screen.dart';
import '../application/auth_provider.dart';
import 'register_screen.dart';

class LoginScreen extends HookConsumerWidget {
  static const route = '/login';

  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey.new);
    final phoneController = useTextEditingController(text: "01939418891");
    final passwordController = useTextEditingController(text: "123456");
    final phoneFocus = useFocusScopeNode();
    final passwordFocus = useFocusScopeNode();

    ref.listen(
      authProvider,
      (previous, next) {
        if (previous!.loading == true && next.loading == false) {
          BotToast.closeAllLoading();
        } else {
          BotToast.showLoading();
        }
      },
    );

    useEffect(() {
      return () {
        BotToast.closeAllLoading();
      };
    }, const []);

    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              Gap(120.h),

              //. App Logo
              const AppLogoWidget(),
              Gap(60.h),

              //. Login Form
              ContainerBGWhiteScaleFromMiddle(
                bgColor: AppColors.bg200,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: crossCenter,
                      children: [
                        AppStrings.login
                            .toTitleCase()
                            .text
                            .textStyle(ContentTextStyle.headline1)
                            .xl6
                            .make(),
                        gap8,
                        Column(
                          crossAxisAlignment: crossStart,
                          mainAxisAlignment: mainCenter,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppStrings.asReseller.text
                                .textStyle(CustomTextStyles.sBodyRegular)
                                .make(),
                            AppStrings.toIconShopper.text
                                .textStyle(CustomTextStyles.sBodyRegular)
                                .sm
                                .make(),
                          ],
                        ).pOnly(bottom: 0.h),
                      ],
                    ),
                    gap28,

                    //. Phone Number
                    KTextFormField2(
                      containerPadding: padding0,
                      controller: phoneController,
                      focusNode: phoneFocus,
                      keyboardType: TextInputType.text,
                      hintText: AppStrings.phoneNumber,
                    ),
                    gap16,

                    //. Password
                    KTextFormField2(
                      containerPadding: padding0,
                      controller: passwordController,
                      focusNode: passwordFocus,
                      keyboardType: TextInputType.text,
                      hintText: AppStrings.password,
                      isObscure: true,
                    ),
                    gap24,

                    //. Login Button
                    KFilledButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        ref.read(authProvider.notifier).login(
                              phone: phoneController.text,
                              password: passwordController.text,
                            );
                      },
                      text: AppStrings.login,
                    ),
                    gap8,

                    //. going to forgot password page
                    KTextButton(
                      padding: paddingH12,
                      child: AppStrings.forgotPassword.text
                          .textStyle(ContentTextStyle.bodyText1)
                          .bold
                          .base
                          .colorTertiary(context)
                          .make(),
                      onPressed: () {
                        context.push(ForgotPasswordScreen.route);
                      },
                    ),
                  ],
                ),
              ),
              gap24,

              //. going to sign up page
              Row(
                mainAxisAlignment: mainCenter,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppStrings.dontHaveAccount,
                    ),
                  ),
                  gap2,
                  KTextButton(
                    isSecondary: false,
                    onPressed: () {
                      context.push(RegisterScreen.route);
                    },
                    text: AppStrings.register,
                  ).w(80),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
