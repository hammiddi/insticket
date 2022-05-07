import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_util.dart';
import '../tickets_view/tickets_view_widget.dart';

class MyTicketsWidget extends StatefulWidget {
  const MyTicketsWidget({
    Key key,
    this.ticketsView,
  }) : super(key: key);

  final GamesRecord ticketsView;

  @override
  _MyTicketsWidgetState createState() => _MyTicketsWidgetState();
}

class _MyTicketsWidgetState extends State<MyTicketsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: flutterTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'My Tickets',
          style: flutterTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: flutterTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                child: Text(
                  'Purchase History',
                  style: flutterTheme.of(context).title2,
                ),
              ),
              StreamBuilder<List<GamesRecord>>(
                stream: queryGamesRecord(
                  queryBuilder: (gamesRecord) => gamesRecord
                      .where('bought_by', arrayContains: currentUserReference)
                      .where('date', isGreaterThan: getCurrentTimestamp),
                ),
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
                  List<GamesRecord> listViewGamesRecordList = snapshot.data;
                  return ListView.builder(
                    controller: controller,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewGamesRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewGamesRecord =
                          listViewGamesRecordList[listViewIndex];
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TicketsViewWidget(
                                  ticketsView: listViewGamesRecord,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              color:
                                  flutterTheme.of(context).secondaryBackground,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        flutterTheme.of(context).secondaryColor,
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
                                    children: [
                                      Stack(
                                        alignment:
                                            AlignmentDirectional(-0.6, 0),
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.4, 0),
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFC8E6C9),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 10, 10, 10),
                                                child: Image.network(
                                                  listViewGamesRecord
                                                      .atImageUrl,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-0.4, 0),
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF81C784),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 10, 10, 10),
                                                child: Image.network(
                                                  listViewGamesRecord
                                                      .htImageUrl,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Purchased  tickets ',
                                          style: flutterTheme
                                              .of(context)
                                              .bodyText2,
                                        ),
                                        Text(
                                          '${listViewGamesRecord.homeTeam} vs ${listViewGamesRecord.awayTeam}',
                                          style: flutterTheme
                                              .of(context)
                                              .bodyText1,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              color: flutterTheme
                                                  .of(context)
                                                  .secondaryText,
                                              size: 12,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 0, 0, 0),
                                              child: Text(
                                                dateTimeFormat('d/M h:mm a',
                                                    listViewGamesRecord.date),
                                                style: flutterTheme
                                                    .of(context)
                                                    .bodyText2,
                                              ),
                                            ),
                                          ],
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                child: Text(
                  'Old Purchase History',
                  style: flutterTheme.of(context).title2,
                ),
              ),
              StreamBuilder<List<GamesRecord>>(
                stream: queryGamesRecord(
                  queryBuilder: (gamesRecord) => gamesRecord
                      .where('bought_by', arrayContains: currentUserReference)
                      .where('date', isLessThan: getCurrentTimestamp),
                ),
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
                  List<GamesRecord> listViewGamesRecordList = snapshot.data;
                  return ListView.builder(
                    controller: controller,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewGamesRecordList.length,
                    itemBuilder: (context, listViewIndex) {
                      final listViewGamesRecord =
                          listViewGamesRecordList[listViewIndex];
                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: Container(
                          width: double.infinity,
                          height: 120,
                          decoration: BoxDecoration(
                            color: flutterTheme.of(context).secondaryBackground,
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
                                  color: Color(0xFFFFEBEE),
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
                                  children: [
                                    Stack(
                                      alignment: AlignmentDirectional(-0.6, 0),
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.4, 0),
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFFCDD2),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 10, 10, 10),
                                              child: Image.network(
                                                'https://upload.wikimedia.org/wikipedia/sco/thumb/4/47/FC_Barcelona_%28crest%29.svg/1200px-FC_Barcelona_%28crest%29.svg.png',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-0.4, 0),
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFEF9A9A),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 10, 10, 10),
                                              child: Image.network(
                                                'https://upload.wikimedia.org/wikipedia/sco/thumb/4/47/FC_Barcelona_%28crest%29.svg/1200px-FC_Barcelona_%28crest%29.svg.png',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '01X tickets purchased ',
                                        style: flutterTheme
                                            .of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: flutterTheme
                                                  .of(context)
                                                  .warning,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                      ),
                                      Text(
                                        'Team Example1 vs Team Example2',
                                        style:
                                            flutterTheme.of(context).bodyText1,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.calendar_today_outlined,
                                            color: flutterTheme
                                                .of(context)
                                                .secondaryText,
                                            size: 12,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5, 0, 0, 0),
                                            child: Text(
                                              '16 mar 2022 - 19:00',
                                              style: flutterTheme
                                                  .of(context)
                                                  .bodyText2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}