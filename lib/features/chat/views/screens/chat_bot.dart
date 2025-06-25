import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/features/chat/logic/cubit/chat_cubit.dart';
import 'package:heal_care/features/chat/views/screens/inside_chat_screen.dart';
import 'package:heal_care/features/chat/views/screens/advices_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key, required this.chatIndex, this.model});
  final String chatIndex;
  final dynamic model;

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  int _currentQuestionIndex = 0;
  bool _showAnswers = true;
  bool isTyping = false;
  String? selectedSymptom;
  String? selectedDuration;
  List<String> userAnswers = []; // Track all user answers

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What symptoms are you currently experiencing?',
      'answers': [
        'Abdominal pain',
        'Bloating or gas',
        'Nausea or vomiting',
        'Diarrhea',
        'Constipation',
        'Acid reflux or heartburn',
      ],
    },
    {
      'question': 'How long have you had these symptoms?',
      'answers': ['Less than 24 hours', '1-3 days', 'More than 3 days'],
    },
    {
      'question': 'Do you have any chronic digestive conditions?',
      'answers': ['Yes (e.g., IBS, Crohn\'s disease, diabetes)', 'No'],
    },
    {
      'question':
          'Are you vomiting blood or does your vomit look like coffee grounds?',
      'answers': ['Yes', 'No'],
      'emergency': true,
    },
    {
      'question': 'Is your stool black, tar-like, or bloody?',
      'answers': ['Yes', 'No'],
      'emergency': true,
    },
    {
      'question': 'Are your eyes or skin turning yellow? (jaundice)',
      'answers': ['Yes', 'No'],
      'emergency': true,
    },
    {
      'question': 'Do you have high fever with abdominal symptoms?',
      'answers': ['Yes', 'No'],
      'emergency': true,
    },
  ];

  final List<Widget> _chatWidgets = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addBotMessage(_questions[_currentQuestionIndex]['question']);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _addBotMessage(String message) {
    setState(() {
      _chatWidgets.add(_buildBotMessage(message));
    });
    _scrollToBottom();
  }

  void _addUserAnswer(String answer) {
    setState(() {
      _chatWidgets.add(_buildUserMessage(answer));
      isTyping = true;
      userAnswers.add(answer); // Track the answer
    });
    _scrollToBottom();

    // Store specific answers for later use
    if (_currentQuestionIndex == 0) {
      selectedSymptom = answer;
    } else if (_currentQuestionIndex == 1) {
      selectedDuration = answer;
    }

    final chatCubit = context.read<ChatCubit>();

    // Check if symptoms lasting more than 3 days
    if (answer.toLowerCase().contains('more than 3 days')) {
      _chatWidgets.add(_buildBotMessage(
          "It seems you've been experiencing these symptoms for more than 3 days. Let me connect you with a doctor for further assistance."));
      _scrollToBottom();

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          _navigateToChat(chatCubit, isEmergency: false);
        }
      });
      return;
    }

    // Handle emergency cases
    final currentQuestion = _questions[_currentQuestionIndex];
    final isEmergencyQuestion = currentQuestion.containsKey('emergency');
    if (isEmergencyQuestion && answer.toLowerCase() == 'yes') {
      _chatWidgets.add(_buildBotMessage(
          "Based on your answers, you should consult with a doctor immediately. Connecting you to a doctor now..."));
      _scrollToBottom();

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          _navigateToChat(chatCubit, isEmergency: true);
        }
      });
      return;
    }

    // Continue to next question
    Future.delayed(const Duration(milliseconds: 600), () {
      if (_currentQuestionIndex + 1 < _questions.length) {
        _currentQuestionIndex++;
        setState(() {
          isTyping = false;
          _chatWidgets.add(
              _buildBotMessage(_questions[_currentQuestionIndex]['question']));
        });
        _scrollToBottom();
      } else {
        _handleFinalRecommendations(chatCubit);
      }
    });
  }

  void _navigateToChat(ChatCubit chatCubit, {required bool isEmergency}) {
    String patientInfo = _createPatientInfoMessage(isEmergency);

    setState(() {
      _chatWidgets.add(_buildBotMessage(patientInfo)); // ← عرض الرسالة للمستخدم
    });
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: chatCubit,
            child: InsideChatScreen(
              chatIndex: widget.chatIndex,
              model: widget.model,
              initialBotMessage: patientInfo,
            ),
          ),
        ),
      );
    });
  }

  String _createPatientInfoMessage(bool isEmergency) {
    String message = "Disease : ${selectedSymptom ?? ' '}\n";
    message +=
        "Duration : ${selectedDuration ?? ''}";
    return message;
  }

  void _handleFinalRecommendations(ChatCubit chatCubit) {
    // Check for any emergency responses
    bool hasEmergency = false;
    for (int i = 0; i < userAnswers.length; i++) {
      if (i + 3 < _questions.length) {
        // Emergency questions start from index 3
        final question = _questions[i + 3];
        if (question.containsKey('emergency') &&
            question['emergency'] == true &&
            userAnswers[i].toLowerCase() == 'yes') {
          hasEmergency = true;
          break;
        }
      }
    }

    setState(() {
      _showAnswers = false;
      isTyping = false;

      if (hasEmergency) {
        _chatWidgets.add(_buildBotMessage(
            "Based on your answers, you should consult with a doctor immediately. Connecting you to a doctor now..."));
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            _navigateToChat(chatCubit, isEmergency: true);
          }
        });
      } else {
        _chatWidgets.add(_buildBotMessage(
            "Thank you for answering the questions. Based on your responses, we recommend checking our advice section."));
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdvicesScreen(
                  symptom: selectedSymptom ?? 'General Advice',
                ),
              ),
            );
          }
        });
      }
    });
    _scrollToBottom();
  }

  Widget _buildBotMessage(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child:
            Text(text, style: AppTextStyles.poppinsBlack(14, FontWeight.w400)),
      ),
    );
  }

  Widget _buildUserMessage(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child:
            Text(text, style: AppTextStyles.poppinsWhite(14, FontWeight.w400)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentAnswers = _currentQuestionIndex < _questions.length
        ? _questions[_currentQuestionIndex]['answers'] as List<String>
        : [];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 24.r,
                      child: Icon(Icons.arrow_back,
                          size: 24.r, color: AppColors.mainBlack),
                    ),
                  ),
                  horizontalSpace(24),
                  CircleAvatar(
                    radius: 25.r,
                    backgroundImage: AssetImage(Assets.imagesChatBot),
                  ),
                  horizontalSpace(12),
                  Text('ARIA',
                      style: AppTextStyles.poppinsBlack(16, FontWeight.w600)),
                ],
              ),
              verticalSpace(32),
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  children: _chatWidgets,
                ),
              ),
              if (isTyping)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.mainWhite,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text("Bot is typing...",
                        style: AppTextStyles.poppinsBlack(13, FontWeight.w400)),
                  ),
                ),
              if (_showAnswers && currentAnswers.isNotEmpty && !isTyping) ...[
                verticalSpace(12),
                Column(
                  children: currentAnswers.map((answer) {
                    return GestureDetector(
                      onTap: () => _addUserAnswer(answer),
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          answer,
                          style:
                              AppTextStyles.poppinsWhite(14, FontWeight.w500),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
