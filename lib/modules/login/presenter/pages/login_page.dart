import 'package:cardapio/modules/login/presenter/bloc/events/login_events.dart';
import 'package:cardapio/modules/login/presenter/bloc/login_bloc.dart';
import 'package:cardapio/modules/login/presenter/bloc/states/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bloc = Modular.get<LoginBloc>();

  final formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey.withOpacity(0.3),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Icon(
                      Icons.fastfood_sharp,
                      size: size.width * 0.3,
                      color: Colors.red,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(hintText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (text) {
                        if (!text!.contains('@')) {
                          return 'Email inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      obscureText: true,
                      validator: (text) {
                        if (text!.length < 6) {
                          return 'A senha deve ter mais de 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              final email = _emailController.text;
                              final password = _passwordController.text;

                              bloc.add(UserLoginEvent(email, password));
                            }
                          },
                          child: const Text('Entrar'),
                        ),
                        Container(
                          width: size.width * 0.9,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                          ),
                          child: BlocListener<LoginBloc, LoginStates>(
                            bloc: bloc,
                            listener: (context, state) {
                              if (state is LoginErrorState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(state.message),
                                  ),
                                );
                              }

                              if (state is LoginSuccessState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.blue,
                                    content: Text('Login Efetuado com sucesso'),
                                  ),
                                );
                                Modular.to.navigate('/home');
                              }
                            },
                            child: BlocBuilder<LoginBloc, LoginStates>(
                              bloc: bloc,
                              builder: (context, state) {
                                if (state is LoginLoadingState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                return Container();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
