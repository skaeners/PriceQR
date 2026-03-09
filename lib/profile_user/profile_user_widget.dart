import '/components/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_user_model.dart';
export 'profile_user_model.dart';

class ProfileUserWidget extends StatefulWidget {
  const ProfileUserWidget({super.key});

  static String routeName = 'ProfileUser';
  static String routePath = '/profileUser';

  @override
  State<ProfileUserWidget> createState() => _ProfileUserWidgetState();
}

class _ProfileUserWidgetState extends State<ProfileUserWidget> {
  late ProfileUserModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileUserModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      context.goNamed(LoginWidget.routeName);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cerrar sesión: $e')),
      );
    }
  }

  void _showComingSoonModal(BuildContext context,
      {String featureName = 'esta función'}) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 30,
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(0, 10),
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFF1E1E2D).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.rocket_launch_outlined,
                      size: 40,
                      color: Color(0xFF1E1E2D),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '¡Próximamente! 🚀',
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          font: GoogleFonts.karla(fontWeight: FontWeight.bold),
                          color: Color(0xFF1E1E2D),
                          fontSize: 22,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Text(
                    '$featureName estará disponible en la próxima versión de PriceQR.',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.karla(),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 16,
                          lineHeight: 1.4,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Estamos trabajando para brindarte la mejor experiencia.',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          font: GoogleFonts.karla(),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),
                  FFButtonWidget(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    text: '¡Entendido!',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50,
                      color: Color(0xFF1E1E2D),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.karla(
                                    fontWeight: FontWeight.w600),
                                color: Colors.white,
                                fontSize: 16,
                              ),
                      elevation: 2,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 190,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1E1E2D),
                      Color(0xFF2A2A40),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 12,
                              color: Colors.black.withOpacity(0.4),
                              offset: Offset(0, 6),
                            )
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 42,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 38,
                            backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('usuarios')
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(
                                    color: Colors.white);
                              }

                              final userData =
                                  snapshot.data?.data() as Map<String, dynamic>?;

                              final nombre = userData?['nombre'] ?? 'Usuario';
                              final correo = userData?['correo'] ??
                                  FirebaseAuth.instance.currentUser?.email ??
                                  '';

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    nombre,
                                    style: GoogleFonts.karla(
                                      color: Color(0xFFFFC107),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    correo,
                                    style: GoogleFonts.karla(
                                      color: Color(0xFFB0BEC5),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),

              _buildMenuCard(
                title: 'Edit Profile',
                icon: Icons.edit,
                iconColor: FlutterFlowTheme.of(context).primaryText,
                onTap: () =>
                    context.pushNamed(EditarPerfilUsuarioWidget.routeName),
              ),

              _buildMenuCard(
                title: 'Notification Settings',
                icon: Icons.notifications_sharp,
                iconColor: Color(0xFFDD932C),
                onTap: () => _showComingSoonModal(context,
                    featureName: 'La configuración de notificaciones'),
              ),

              _buildMenuCard(
                title: 'About the App',
                icon: Icons.info,
                iconColor: Color(0xFF1F84D0),
                onTap: () => _showComingSoonModal(context,
                    featureName: 'La información sobre la app'),
              ),

              _buildMenuCard(
                title: 'Contact Support',
                icon: Icons.support_agent,
                iconColor: Color(0xFF171817),
                onTap: () => _showComingSoonModal(context,
                    featureName: 'El soporte al cliente'),
              ),

              Padding(
                padding: EdgeInsets.only(top: 80),
                child: FFButtonWidget(
                  onPressed: _signOut,
                  text: 'Log Out',
                  icon: Icon(Icons.logout, size: 18),
                  options: FFButtonOptions(
                    width: 170,
                    height: 52,
                    color: Color(0xFF1E1E2D),
                    textStyle: GoogleFonts.karla(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    elevation: 6,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),

          wrapWithModel(
            model: _model.navBarModel,
            updateCallback: () => safeSetState(() {}),
            child: NavBarWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: Colors.black.withOpacity(0.08),
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.karla(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}