import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_zipcode/modules/zipcode/domain/entities/address_entity.dart';
import 'package:search_zipcode/modules/zipcode/presentation/cubit/zipcode_cubit.dart';
import 'package:search_zipcode/modules/zipcode/presentation/cubit/zipcode_state.dart';

class ZipcodePage extends StatelessWidget {
  final TextEditingController _cepController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ZipcodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca CEP'),
      ),
      body: BlocConsumer<ZipcodeCubit, ZipcodeState>(
        listener: (context, state) {
          if (state is Error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is Empty) {
            return _buildInitialInput(context);
          } else if (state is Loading) {
            return _buildLoading();
          } else if (state is Loaded) {
            return _buildColumnWithData(context, state.address);
          } else if (state is Error) {
            return _buildInitialInput(context, error: state.message);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildInitialInput(BuildContext context, {String? error}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 130,
                child: Icon(Icons.location_on, size: 130),
              ),
              const SizedBox(height: 296),
              TextFormField(
                controller: _cepController,
                decoration: InputDecoration(
                  hintText: 'Digite o CEP',
                  errorText: error,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite um CEP.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final cep = _cepController.text;
                    context.read<ZipcodeCubit>().getZipcodeInfoEvent(cep);
                  }
                },
                child: const Text('Buscar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildColumnWithData(BuildContext context, AddressEntity address) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 130,
              child: Icon(Icons.location_on, size: 130),
            ),
            const SizedBox(height: 296),
            Column(
              children: [
                Text('CEP: ${address.cep}'),
                Text('Logradouro: ${address.rua}'),
                Text('Cidade: ${address.cidade}'),
                Text('Estado: ${address.uf}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _cepController.clear();
                    context.read<ZipcodeCubit>().emit(Empty());
                  },
                  child: const Text('Buscar Outro'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
