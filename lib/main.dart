import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:taller_fotos/domain/ficha.dart';
import 'package:taller_fotos/presentation/fichas_bloc.dart';
import 'package:taller_fotos/presentation/inyeccion.dart';

void main() {
  configurarDependencias();
  runApp(const TallerApp());
}

class TallerApp extends StatelessWidget {
  const TallerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FichaRepositorio>.value(value: getIt<FichaRepositorio>()),
        BlocProvider(
          create: (context) => FichasBloc(context.read<FichaRepositorio>()),
        ),
      ],
      child: MaterialApp(
        title: 'Taller de fotos',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD84A1B)),
          useMaterial3: true,
        ),
        home: const FichasPage(),
      ),
    );
  }
}

class FichasPage extends StatefulWidget {
  const FichasPage({super.key});

  @override
  State<FichasPage> createState() => _FichasPageState();
}

class _FichasPageState extends State<FichasPage> {
  final _titulo = TextEditingController();

  @override
  void dispose() {
    _titulo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Taller de fotos')),
      body: BlocBuilder<FichasBloc, FichasListas>(
        builder: (context, estado) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextField(
                controller: _titulo,
                decoration: const InputDecoration(labelText: 'Título de la ficha'),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {
                  context.read<FichasBloc>().add(
                        AgregarFicha(_titulo.text, const Imagen(ruta: 'memoria://nueva', bytes: 128)),
                      );
                  _titulo.clear();
                },
                child: const Text('Guardar ficha'),
              ),
              if (estado.mensaje != null) ...[
                const SizedBox(height: 12),
                Text(estado.mensaje!),
              ],
              const SizedBox(height: 20),
              if (estado.fichas.isEmpty) const Text('Todavía no hay fichas.'),
              for (final ficha in estado.fichas)
                ListTile(
                  title: Text(ficha.titulo),
                  subtitle: Text('${ficha.imagen.bytes} bytes'),
                ),
            ],
          );
        },
      ),
    );
  }
}
