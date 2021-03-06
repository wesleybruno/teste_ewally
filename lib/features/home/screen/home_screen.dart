import 'package:ewally/configs/ui/Cores.dart';
import 'package:ewally/configs/ui/DimensoesTela.dart';
import 'package:ewally/configs/ui/Fontes.dart';
import 'package:ewally/features/home/models/extrato_model.dart';
import 'package:ewally/features/home/screen/bloc/extrato_cubit.dart';
import 'package:ewally/features/home/screen/bloc/saldo_cubit.dart';
import 'package:ewally/features/home/screen/widget/content_factory.dart';
import 'package:ewally/features/home/home_strings.dart';
import 'package:ewally/injection_container.dart';
import 'package:ewally/widgets/botao_principal/botao_principal.dart';
import 'package:ewally/configs/utils/ValorMonetarioExtension.dart';
import 'package:ewally/configs/utils/DateTimeExtension.dart';
import 'package:ewally/widgets/campo_form/campo_form.dart';
import 'package:ewally/widgets/error_widgets/erro_api_widget.dart';
import 'package:ewally/widgets/error_widgets/sem_internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SaldoCubit cubit;
  TextEditingController _controllerPeriodoInicio;
  TextEditingController _controllerPeriodoFim;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    _controllerPeriodoInicio = TextEditingController();
    _controllerPeriodoFim = TextEditingController();
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

  _selecionarData(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        controller.text = picked.formatarDataString;
      });
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

  _aoApertarIconeTipoVizualizacao(
    BuildContext context,
    ExtratoModel extrato,
    TipoExibicao tipoExibicao,
  ) {
    _esconderTeclado();
    BlocProvider.of<ExtratoCubit>(context).alterarTipoExibicao(
      extrato,
      tipoExibicao,
    );
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
        child: BlocBuilder<SaldoCubit, SaldoState>(
          builder: (context, state) {
            return _buildContent(context, state);
          },
        ),
      ),
    );
  }

  _buildContent(
    BuildContext context,
    SaldoState saldoState,
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
        child:
            BlocBuilder<ExtratoCubit, ExtratoState>(builder: (_, extratoState) {
          return Column(
            children: [
              _buildText(
                  HomeStrings.saldoAtual(saldoState.saldoModel.balance.emReal)),
              _buildText(HomeStrings.buscarExtrato),
              _buildCampoForm(
                HomeStrings.periodoInicio,
                _controllerPeriodoInicio,
                extratoState is ExtratoApiReturnError,
                context,
              ),
              _buildCampoForm(
                HomeStrings.periodoFim,
                _controllerPeriodoFim,
                extratoState is ExtratoApiReturnError,
                context,
              ),
              _buildButton(
                !(extratoState is DadosInvalidoState) &&
                    !(extratoState is LoadingExtratoState),
                extratoState is LoadingExtratoState,
                context,
              ),
              if (extratoState is ExtratoUsuarioReturn) ...[
                _buildSelectTypeContent(
                  context,
                  extratoState.extratoModel,
                  extratoState.tipoExibicao,
                ),
                ContentFactory.buildContent(
                  extratoState.extratoModel,
                  extratoState.tipoExibicao,
                )
              ],
            ],
          );
        }),
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

  _buildSelectTypeContent(
    BuildContext context,
    ExtratoModel extrato,
    TipoExibicao tipoExibicao,
  ) {
    return extrato.statement.isEmpty
        ? Container()
        : Container(
            margin: EdgeInsets.only(bottom: 20.h),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  iconSize: 30.w,
                  icon: Icon(Icons.add_chart),
                  onPressed: () => _aoApertarIconeTipoVizualizacao(
                    context,
                    extrato,
                    TipoExibicao.GRAFICO,
                  ),
                  color: tipoExibicao == TipoExibicao.GRAFICO
                      ? Cores.pantone
                      : Cores.cinza[200],
                ),
                IconButton(
                  iconSize: 30.w,
                  icon: Icon(Icons.library_books),
                  color: tipoExibicao == TipoExibicao.LISTA
                      ? Cores.pantone
                      : Cores.cinza[200],
                  onPressed: () => _aoApertarIconeTipoVizualizacao(
                    context,
                    extrato,
                    TipoExibicao.LISTA,
                  ),
                )
              ],
            ),
          );
  }

  _buildCampoForm(
    String texto,
    TextEditingController controller,
    bool possuiErro,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => _selecionarData(context, controller),
      child: CampoForm(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 5.h,
        ),
        titulo: texto,
        enable: false,
        keyboardType: TextInputType.emailAddress,
        fillColor: Cores.cinza[100],
        controller: controller,
        possuiErro: possuiErro,
        borderColor: Cores.vermelhorErro,
        onChange: (_) => _validarDados(context),
      ),
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
        bottom: 20.h,
      ),
      child: BotaoPrincipal(
        aoClicar: () => _aoApertarBuscar(context),
        exibirLoading: exibirLoading,
        habilitar: habilitar,
        corDesabilitado: Cores.cinza[200],
        texto: HomeStrings.buscacr,
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
