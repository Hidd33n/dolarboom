import 'package:dolarcito/bloc/events/dolar_event.dart';
import 'package:dolarcito/bloc/main/dolar_bloc.dart';
import 'package:dolarcito/screens/newscreen/newscreen.dart';
import 'package:dolarcito/screens/streamingscreen/streaming_prices_screen.dart';
// Importamos el nuevo widget
import 'package:dolarcito/widgets/dolarmainview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Lista de widgets para cada pestaña
  static final List<Widget> _widgetOptions = <Widget>[
    DolarMainView(), // Vista principal de Dólares
    StreamingPricesScreen(), // Nueva vista para precios de streaming
    NewsScreen(), // Nueva vista para noticias
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DolarBloc>().add(FetchDolarEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Dolarcito',
          style: GoogleFonts.bebasNeue(fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              context.read<DolarBloc>().add(FetchDolarEvent());
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue[800],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money, color: Colors.white),
            label: 'Dólares',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv, color: Colors.white),
            label: 'Streaming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article, color: Colors.white),
            label: 'Noticias',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}