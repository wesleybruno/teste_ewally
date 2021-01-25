import 'package:ewally/configs/ui/Cores.dart';
import 'package:ewally/configs/ui/Icones.dart';
import 'package:ewally/widgets/svg_image/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ewally/configs/routes/app/i_app_navigator.dart';
import 'package:ewally/configs/ui/DimensoesTela.dart';
import 'package:ewally/features/splash/screens/bloc/splash_cubit.dart';
import 'package:ewally/injection_container.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _irParaHome() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      dependencia<IAppNavigator>().irParaHome(podeVoltar: false);
    });
  }

  _irParaLogin() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      dependencia<IAppNavigator>().irParaLogin(podeVoltar: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => dependencia<SplashCubit>()..buscarDadosCabecalhos(),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (_, state) {
          if (state is PossuiDadosGravados) {
            _irParaHome();
          }
          if (state is SemDadosGravados) {
            _irParaLogin();
          }
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  height: double.infinity,
                  color: Cores.branco,
                  child: Container(),
                ),
                _buildLogo()
              ],
            ),
          );
        },
      ),
    );
  }

  _buildLogo() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 100.h, bottom: 50.h),
        height: 50.h,
        width: 50.w,
        child: SvgImage(
          icone: IconesAplicacao.logo,
        ),
      ),
    );
  }
}
