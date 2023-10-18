import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatMessage {
  final String role;
  final String message;

  ChatMessage(this.role, this.message);
}

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key});

  static String get routeName => 'chatting';

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false; // 로딩 상태 표시
  final _focusNode = FocusNode();
  final WebSocketChannel _channel = IOWebSocketChannel.connect(
    'wss://u8hibriooa.execute-api.ap-northeast-2.amazonaws.com/dev/',
    headers: {
      'room_id': '1',
    },
  );

  final _messages = <ChatMessage>[];

  final _controller = TextEditingController();

  void _sendMessage() {
    final message = _controller.text;

    // 사용자의 메시지 추가
    setState(() {
      _messages.add(ChatMessage('user', message));
      _messages.add(ChatMessage('tago', 'loading'));
      _isLoading = true;
    });

    _channel.sink.add(
        '{"action":"sendmessage","room_id":"1","role":"user","message":"$message"}');
    _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  void initState() {
    super.initState();
    _messages.add(ChatMessage('tago', '안녕하세요!\n어떤 느낌의 여행지가 좋으신가요?'));
    _channel.stream.listen(
      (data) {
        setState(() {
          // 기존의 로딩 메시지 삭제
          if (_messages.isNotEmpty &&
              _messages.last.message == 'loading' &&
              _messages.last.role == 'tago') {
            _messages.removeLast();
          }

          _messages.add(ChatMessage('tago', data));
          _isLoading = false; // 로딩 상태 종료
        });
      },
      onError: (error) {
        // 오류 처리 로직
      },
      onDone: () {
        // 웹소켓 연결 종료 처리
      },
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 10),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    // 키보드가 보일 때 스크롤을 맨 아래로 이동
    if (isKeyboardVisible) {
      _scrollToBottom();
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode()); // 키보드 닫기
      },
      child: DefaultLayout(
        titleComponet: const Text(
          '타고챗',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: SafeArea(
          bottom: true,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.manual,
                  child: Column(
                    children: List.generate(
                      _messages.length + 2,
                      (index) {
                        if (index == 0) {
                          return Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('asset/img/logo/logo.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        } else if (index == 1) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 20.0,
                            ),
                            child: Text(
                              '타고챗에서는\n여행지를 추천받을 수 있어요!',
                              style: TextStyle(
                                color: LABEL_TEXT_SUB_COLOR,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          final message = _messages[index - 2];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2.0,
                            ),
                            child: ListTile(
                              title: Align(
                                alignment: message.role == 'user'
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (message.role == 'tago') ...[
                                      ClipOval(
                                        child: Image.asset(
                                          'asset/img/logo/logo.png',
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                    ],
                                    Flexible(
                                      child: Padding(
                                        padding: message.role == 'user'
                                            ? const EdgeInsets.only(left: 30.0)
                                            : const EdgeInsets.only(
                                                right: 50.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: message.role == 'user'
                                                ? Colors.white
                                                : LABEL_BG_COLOR,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15)),
                                            border: message.role == 'user'
                                                ? Border.all(
                                                    color: LABEL_BG_COLOR,
                                                    width: 1)
                                                : null,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 15.0),
                                            child: message.message == 'loading'
                                                ? const Text(
                                                    '(타고는 고민중...)',
                                                    style: TextStyle(
                                                      color:
                                                          LABEL_TEXT_SUB_COLOR,
                                                      fontSize: 14.0,
                                                    ),
                                                  )
                                                : SelectableText(
                                                    message.role == 'user'
                                                        ? message.message
                                                        : (index == 2)
                                                            ? message.message
                                                            : DataUtils
                                                                .changeBotMessage(
                                                                    message
                                                                        .message),
                                                    style: const TextStyle(
                                                        fontSize: 13.0,
                                                        height: 1.5),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: LABEL_BG_COLOR,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            focusNode: _focusNode,
                            autofocus: true,
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            expands: true,
                            maxLines: null,
                            minLines: null,
                            cursorOpacityAnimates: true,
                            cursorColor: PRIMARY_COLOR,
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText:
                                  _isLoading ? "타고가 대답 중 ..." : "메시지 입력...",
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                left: 15.0,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                  horizontal: 5.0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _isLoading
                                        ? SELECTED_BOX_BG_COLOR
                                        : SELECTED_PLACE_BG_COLOR, // 지정된 색상
                                    borderRadius: BorderRadius.circular(
                                        20), // borderRadius 설정
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(
                                      Icons.arrow_upward,
                                      color: Colors.white,
                                    ),
                                    onPressed: _sendMessage,
                                  ),
                                ),
                              ),
                            ),
                            enabled: !_isLoading,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
