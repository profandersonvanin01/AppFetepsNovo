import 'package:feteps/NossaEquipe_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrenoCardozoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: screenWidth * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NossaEquipePage(),
                    ),
                  );
                },
                icon: Icon(
                  size: screenWidth * 0.075,
                  Icons.arrow_back_sharp,
                  color: const Color(0xFF0E414F),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.015,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                ),
                child: Image.asset(
                  'lib/assets/logo.png',
                  width: screenWidth * 0.65,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.03, bottom: screenHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1,),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.5,
                      ),
                    ),
                    child: Image.asset(
                      'lib/assets/breno.png',
                      height: screenHeight * 0.35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                 padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: screenHeight * 0.02),
                  child: Text(
                    'Breno Cardozo',
                    style: GoogleFonts.inter(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A5B97),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08,  vertical: screenHeight * 0.02 ),
                  child: Text(
                    'Função: Desenvolvimento Web',
                    style: GoogleFonts.inter(
                      fontSize: screenWidth * 0.048,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF830000),
                    ),
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Github:',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.048,
                          color: const Color(0xFFFFD35F),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'https://github.com/Breno-Cardozo',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: screenHeight * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LinkedIn:',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.048,
                          color: const Color(0xFFFFD35F),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'www.linkedin.com/in/brenocardozo',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      ),
                  child: Text(
                    'Email para contato:',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.048,
                      color: const Color(0xFFFFD35F),
                    ),
                  ),
                  
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,),
                  child: Row(
                    children: [Text('breno_cardozogarcia@hotmail.com',  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.048,
                      color: Colors.black
                    ), )],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
