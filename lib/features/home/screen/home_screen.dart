import 'package:ewally/configs/ui/Cores.dart';
import 'package:ewally/configs/ui/DimensoesTela.dart';
import 'package:ewally/configs/ui/Fontes.dart';
import 'package:ewally/configs/ui/Strings.dart';
import 'package:ewally/features/home/screen/bloc/extrato_cubit.dart';
import 'package:ewally/features/home/screen/bloc/saldo_cubit.dart';
import 'package:ewally/injection_container.dart';
import 'package:ewally/widgets/botao_principal/botao_principal.dart';
import 'package:ewally/configs/utils/ValorMonetarioExtension.dart';
import 'package:ewally/widgets/campo_form/campo_form.dart';
import 'package:ewally/widgets/error_widgets/erro_api_widget.dart';
import 'package:ewally/widgets/error_widgets/sem_internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SaldoCubit cubit;
  MaskedTextController _controllerPeriodoInicio;
  MaskedTextController _controllerPeriodoFim;

  @override
  void initState() {
    _controllerPeriodoInicio = MaskedTextController(mask: '00-00-0000');
    _controllerPeriodoFim = MaskedTextController(mask: '00-00-0000');
    cubit = dependencia<SaldoCubit>();
    cubit.buscarSaldo();
    super.initState();
  }

  @override
  void dispose() {
    _controllerPeriodoInicio.clear();
    _controllerPeriodoFim.clear();
    _controllerPeriodoInicio.dispose();
    _controllerPeriodoFim.dispose();
    super.dispose();
  }

  _validarDados(BuildContext context) {
    BlocProvider.of<ExtratoCubit>(context).validarDados(
      _controllerPeriodoInicio.text,
      _controllerPeriodoFim.text,
    );
  }

  _aoApertarBuscar(BuildContext context) {
    _esconderTeclado();
    BlocProvider.of<ExtratoCubit>(context).buscarExtrato(
      _controllerPeriodoInicio.text,
      _controllerPeriodoFim.text,
    );
  }

  _recarregarSaldo(BuildContext context) {
    BlocProvider.of<SaldoCubit>(context).buscarSaldo();
  }

  _esconderTeclado() {
    FocusManager.instance.primaryFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _esconderTeclado,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => cubit,
          ),
          BlocProvider(
            create: (context) => dependencia<ExtratoCubit>(),
          ),
        ],
        child: BlocBuilder<SaldoCubit, HomeState>(
          builder: (context, state) {
            return BlocBuilder<ExtratoCubit, ExtratoState>(
                builder: (_, extratoState) {
              return _buildContent(
                context,
                state,
                extratoState,
              );
            });
          },
        ),
      ),
    );
  }

  _buildContent(
    BuildContext context,
    HomeState saldoState,
    ExtratoState extratoState,
  ) {
    if (saldoState is LoadingState)
      return Center(
        child: CircularProgressIndicator(),
      );

    if (saldoState is ApiReturnNoInternet)
      return SemInternetWidget(
        aoApertarTentarNovamente: () => _recarregarSaldo(context),
      );
    if (saldoState is ApiReturnError)
      return ErroApiWidget(
        aoApertarTentarNovamente: () => _recarregarSaldo(context),
        corTexto: Cores.preto,
      );
    if (saldoState is SaldoUsuarioReturn) {
      return SingleChildScrollView(
        child: Column(
          children: [
            _buildText('Saldo atual ${saldoState.saldoModel.balance.emReal}'),
            _buildText('Buscar Extrato'),
            _buildCampoForm(
              Strings.periodoInicio,
              _controllerPeriodoInicio,
              extratoState is DadosInvalidoState ||
                  extratoState is ExtratoApiReturnError,
              context,
            ),
            _buildCampoForm(
              Strings.periodoFim,
              _controllerPeriodoFim,
              extratoState is DadosInvalidoState ||
                  extratoState is ExtratoApiReturnError,
              context,
            ),
            _buildButton(
              extratoState is DadosValidoState,
              extratoState is LoadingExtratoState,
              context,
            )
          ],
        ),
      );
    }
    return Container();
  }

  _buildText(String texto) {
    return Container(
      margin: EdgeInsets.only(top: 50.h),
      child: Text(
        texto,
        style: TextStyle(
          fontSize: 20.ssp,
          fontFamily: Fontes.montserrat,
        ),
      ),
    );
  }

  _buildCampoForm(
    String texto,
    TextEditingController controller,
    bool possuiErro,
    BuildContext context,
  ) {
    return CampoForm(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 5.h,
      ),
      titulo: texto,
      keyboardType: TextInputType.emailAddress,
      fillColor: Cores.cinza[100],
      controller: controller,
      possuiErro: possuiErro,
      borderColor: Cores.vermelhorErro,
      onChange: (_) => _validarDados(context),
    );
  }

  _buildButton(
    bool habilitar,
    bool exibirLoading,
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30.w,
        right: 30.w,
        top: 30.h,
        bottom: 80.h,
      ),
      child: BotaoPrincipal(
        aoClicar: () => _aoApertarBuscar(context),
        exibirLoading: exibirLoading,
        habilitar: habilitar,
        corDesabilitado: Cores.cinza[200],
        texto: Strings.buscacr,
        textStyle: TextStyle(
          fontSize: 16.ssp,
          fontWeight: Fontes.semiBold,
          color: Cores.branco,
        ),
        altura: 48.h,
        raioBorda: 8.w,
      ),
    );
  }
}
