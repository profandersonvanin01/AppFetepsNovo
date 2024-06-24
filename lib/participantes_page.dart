import 'package:feteps/DetalheProject_page.dart';
import 'package:feteps/Menu_Page.dart';
import 'package:feteps/sobre_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ParticipantesPage extends StatefulWidget {
  const ParticipantesPage({super.key});

  @override
  State<ParticipantesPage> createState() => _InstituicoesPageState();
}

class _InstituicoesPageState extends State<ParticipantesPage> {
  Map<String, List<dynamic>> _projectsCache = {
    "ETEC": [],
    "FATEC": [],
    "OUTROS": []
  };
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    await Future.wait([
      _fetchProjectsByClassification("ETEC"),
      _fetchProjectsByClassification("FATEC"),
      _fetchProjectsByClassification("OUTROS")
    ]);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchProjectsByClassification(String classification) async {
    final response = await http.get(Uri.parse(
        'https://profandersonvanin.com.br/appfeteps/pages/Project/get.php?classification=$classification&limit=50'));

    if (response.statusCode == 200) {
      setState(() {
        _projectsCache[classification] = json.decode(response.body)['response'];
      });
    } else {
      throw Exception('Falha ao carregar os projetos');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SobrePage(),
                      ),
                    );
                  },
                  icon: Icon(
                    size: MediaQuery.of(context).size.width * 0.075,
                    Icons.arrow_back_sharp,
                    color: const Color(0xFF0E414F),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    left: MediaQuery.of(context).size.width * 0.02,
                  ),
                  child: Image.asset(
                    'lib/assets/logo.png',
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
              ],
            ),
            actions: [
              Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015,
                      ),
                      child: Icon(
                        Icons.menu,
                        size: MediaQuery.of(context).size.width * 0.095,
                        color: const Color(0xFF0E414F),
                      ),
                    ),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  );
                },
              ),
            ],
          ),
          endDrawer: const MenuPage(),
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFFFFD35F)))
              : ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.12,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text('Participantes',
                                    style: GoogleFonts.poppins(
                                        fontSize: screenWidth * 0.09,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                            255, 14, 56, 70))),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: screenHeight * 0.055,
                              left: screenWidth * 0.06,
                              right: screenWidth * 0.06),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: 'Pesquise uma Instituição...',
                              hintStyle: TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3.0,
                                  color: Color.fromARGB(255, 255, 209, 64),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              prefixIcon: Icon(Icons.search,
                                  color: Color.fromARGB(255, 255, 209, 64)),
                            ),
                          ),
                        ),
                        _buildProjectSection('Etecs', 'ETEC'),
                        const SizedBox(height: 10.0),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1.5,
                        ),
                        _buildProjectSection('Fatecs', 'FATEC'),
                        const SizedBox(height: 10.0),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1.5,
                        ),
                        _buildProjectSection('Outras Instituições', 'OUTROS'),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildProjectSection(String title, String classification) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title,
            style: GoogleFonts.inter(
                fontSize: screenWidth * 0.07,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5.0),
        _projectsCache[classification]!.isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var project in _projectsCache[classification]!)
                      CardWidget2(
                        project: project,
                        classification: classification,
                      )
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Estas instituições ainda não possuem projetos.',
                  style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.05, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
      ],
    );
  }
}

class CardWidget2 extends StatelessWidget {
  final Map<String, dynamic> project;
  final String classification;

  const CardWidget2({super.key, required this.project, required this.classification});

  Color Cor(String classification) {
    switch (classification) {
      case 'ETEC':
        return const Color(0xFF830000);
      case 'FATEC':
        return const Color(0xFF1A5B97);
      case 'OUTROS':
        return const Color(0xFFDDA73A);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final String? bannerUrl = project['banner'];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetalheProjectPage(project: project),
            ),
          );
        },
        child: Card(
          color: Cor(classification),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SizedBox(
            width: screenWidth * 0.45,
            height: screenWidth * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10.0),
                if (bannerUrl != null && bannerUrl.isNotEmpty)
                  Container(
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black,
                      width: 2.5,
                    )),
                    child: Image.network(
                      bannerUrl,
                      width: screenWidth * 0.42,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'lib/assets/Rectangle.png',
                          width: screenWidth * 0.42,
                        );
                      },
                    ),
                  )
                else
                  Image.asset(
                    'lib/assets/Rectangle.png',
                    width: screenWidth * 0.42,
                  ),
                const SizedBox(height: 5.0),
                Text(
                  _shortenText(project['name_project'], 25),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.042,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 3.0),
                Text(
                  'name_institution', //Não consegui puxar
                  style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.035,
                      color: const Color.fromARGB(255, 158, 156, 156)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _shortenText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)}...';
  }
}