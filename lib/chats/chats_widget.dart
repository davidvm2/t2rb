import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../chat/chat_widget.dart';
import '../flutter_flow/chat/index.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatsWidget extends StatefulWidget {
  ChatsWidget({Key key}) : super(key: key);

  @override
  _ChatsWidgetState createState() => _ChatsWidgetState();
}

class _ChatsWidgetState extends State<ChatsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'All Chats',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
          child: StreamBuilder<List<ChatsRecord>>(
            stream: queryChatsRecord(
              queryBuilder: (chatsRecord) => chatsRecord
                  .where('users', arrayContains: currentUserReference)
                  .orderBy('last_message_time', descending: true),
            ),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: FlutterFlowTheme.customColor2,
                    ),
                  ),
                );
              }
              List<ChatsRecord> listViewChatsRecordList = snapshot.data;
              // Customize what your widget looks like with no query results.
              if (snapshot.data.isEmpty) {
                return Material(
                  child: Container(
                    height: 100,
                    child: Center(
                      child: Text('No results.'),
                    ),
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: listViewChatsRecordList.length,
                itemBuilder: (context, listViewIndex) {
                  final listViewChatsRecord =
                      listViewChatsRecordList[listViewIndex];
                  return FutureBuilder<UsersRecord>(
                    future: () async {
                      final chatUserRef = FFChatManager.instance.getChatUserRef(
                          currentUserReference, listViewChatsRecord);
                      return UsersRecord.getDocument(chatUserRef).first;
                    }(),
                    builder: (context, snapshot) {
                      final chatUser = snapshot.data;
                      return FFChatPreview(
                        onTap: chatUser != null
                            ? () => Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 300),
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    child: ChatWidget(
                                      chatUser: chatUser,
                                    ),
                                  ),
                                )
                            : null,
                        lastChatText: listViewChatsRecord.lastMessage,
                        lastChatTime: listViewChatsRecord.lastMessageTime,
                        seen: listViewChatsRecord.lastMessageSeenBy
                            .contains(currentUserReference),
                        userName: chatUser?.displayName ?? '',
                        userProfilePic: chatUser?.photoUrl ?? '',
                        color: Color(0xFFEEF0F5),
                        unreadColor: Colors.blue,
                        titleTextStyle: GoogleFonts.getFont(
                          'DM Sans',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        dateTextStyle: GoogleFonts.getFont(
                          'DM Sans',
                          color: Color(0x73000000),
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        previewTextStyle: GoogleFonts.getFont(
                          'DM Sans',
                          color: Color(0x73000000),
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                        borderRadius: BorderRadius.circular(0),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
