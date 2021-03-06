import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../add_game_at/add_game_at_widget.dart';
import '../backend/backend.dart';
import '../flutter_main/flutter_main_icon_button.dart';
import '../flutter_main/flutter_main_theme.dart';
import '../index.dart';

//FR
class AddGameHtWidget extends StatefulWidget {
  const AddGameHtWidget({
    Key key,
    this.team,
  }) : super(key: key);

  final TeamsRecord team;

  @override
  _AddGameHtWidgetState createState() => _AddGameHtWidgetState();
}

class _AddGameHtWidgetState extends State<AddGameHtWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterTheme.of(context).primaryText,
            size: 32,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'Sélectionnez l\'équipe locale',
            style: FlutterTheme.of(context).title1,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: FlutterTheme.of(context).primaryBackground,
      body: SafeArea(
        child: StreamBuilder<List<TeamsRecord>>(
          stream: queryTeamsRecord(),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: SpinKitFadingGrid(
                    color: Color(0xFF00C853),
                    size: 50,
                  ),
                ),
              );
            }
            List<TeamsRecord> listViewTeamsRecordList = snapshot.data;
            return ListView.builder(
              controller: controller,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: listViewTeamsRecordList.length,
              itemBuilder: (context, listViewIndex) {
                final listViewTeamsRecord =
                    listViewTeamsRecordList[listViewIndex];
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddGameAtWidget(
                            team: listViewTeamsRecord,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        color: FlutterTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 48,
                            color: Color(0x0B000000),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterTheme.of(context).secondaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF81C784),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 10, 10, 10),
                                    child: CachedNetworkImage(
                                      imageUrl: listViewTeamsRecord.imageUrl,
                                      placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          new Image.asset(
                                              'assets/images/team-logo.png'),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15, 15, 15, 15),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listViewTeamsRecord.name,
                                    style: FlutterTheme.of(context).bodyText1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
