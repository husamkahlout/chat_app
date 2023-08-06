import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../resources/assets_manager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  navigateFunction() async {
    Provider.of<AuthProvider>(context, listen: false).checkUser();
  }

  @override
  void initState() {
    navigateFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          AssetsManager.splashLogo,
          fit: BoxFit.cover,
          width: 280.w,
        ),
      ),
    );
  }
}
