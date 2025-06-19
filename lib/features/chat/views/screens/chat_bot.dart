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
        'Loss of appetite'
      ],
    },
    {
      'question': 'How long have you had these symptoms?',
      'answers': ['Less than 24 hours', '1-3 days', 'More than 3 days'],
    },
    {
      'question': 'Do you have any chronic digestive conditions?',
      'answers': ['Yes (e.g., IBS, Crohn’s disease, diabetes)', 'No'],
    },
    {
      'question':
          'Are you vomiting blood or does your vomit look like coffee grounds?',
      'answers': ['Yes', 'No'],
      'emergency': true, // Indicates emergency response needed
    },
    {
      'question': 'Is your stool black, tar-like, or bloody?',
      'answers': ['Yes', 'No'],
      'emergency': true, // Indicates emergency response needed
    },
    {
      'question': 'Are your eyes or skin turning yellow? (jaundice)',
      'answers': ['Yes', 'No'],
      'emergency': true, // Indicates emergency response needed
    },
    {
      'question': 'Do you have high fever with abdominal symptoms?',
      'answers': ['Yes', 'No'],
      'emergency': true, // Indicates emergency response needed
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
    });
    _scrollToBottom();

    // Get the current ChatCubit from the widget tree
    final chatCubit = context.read<ChatCubit>();

    // Check if this answer requires immediate action
    final currentQuestion = _questions[_currentQuestionIndex];
    final isEmergencyQuestion = currentQuestion.containsKey('emergency');
    final isDoctorQuestion =
        currentQuestion['question'].contains('chronic digestive conditions');
    final isDurationQuestion = currentQuestion['question']
        .toLowerCase()
        .contains('how long have you had these symptoms');

    // Check if the answer indicates symptoms lasting more than 3 days
    if (isDurationQuestion &&
        answer.toLowerCase().contains('more than 3 days')) {
      // Navigate to chat immediately if symptoms last more than 3 days
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          _chatWidgets.add(_buildBotMessage(
              "I see you've been experiencing these symptoms for more than 3 days. Let me connect you with a doctor for further assistance."));
          _scrollToBottom();
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: chatCubit,
                    child: InsideChatScreen(
                      chatIndex: widget.chatIndex,
                      model: widget.model,
                    ),
                  ),
                ),
              );
            }
          });
        }
      });
      return;
    }

    // Helper function to navigate to chat screen
    void navigateToChat() {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: chatCubit,
              child: InsideChatScreen(
                chatIndex: widget.chatIndex,
                model: widget.model,
              ),
            ),
          ),
        );
      }
    }

    // Helper function to navigate to advices screen
    void navigateToAdvices() {
      if (mounted) {
        // Get the user's answer to the first question
        String? firstAnswer;
        // The first answer should be at index 1 in _chatWidgets (index 0 is the first question)
        if (_chatWidgets.length > 1 && _chatWidgets[1] is Align) {
          final answerWidget = _chatWidgets[1] as Align;
          if (answerWidget.child is Container) {
            final container = answerWidget.child as Container;
            if (container.child is Text) {
              firstAnswer = (container.child as Text).data;
            }
          }
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdvicesScreen(
              symptom: firstAnswer ?? 'General Advice',
            ),
          ),
        );
      }
    }

    // Handle immediate navigation cases - only for emergency "yes" answers
    if (isEmergencyQuestion && answer.toLowerCase() == 'yes') {
      // Navigate to doctor chat immediately for emergency "yes"
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          _chatWidgets.add(_buildBotMessage(
              "Based on your answers, you should consult with a doctor. Connecting you to a doctor now..."));
          navigateToChat();
        }
      });
      return;
    }

    // For other cases, continue to next question or complete the flow
    Future.delayed(const Duration(milliseconds: 600), () {
      if (_currentQuestionIndex + 1 < _questions.length) {
        // Move to next question
        _currentQuestionIndex++;
        setState(() {
          isTyping = false;
          _chatWidgets.add(
              _buildBotMessage(_questions[_currentQuestionIndex]['question']));
        });
        _scrollToBottom();
      } else {
        // All questions answered, check the answers
        bool hasEmergency = false;
        bool hasDoctor = false;
        bool hasLongDuration = false;

        // Check all answers
        for (var i = 0; i < _questions.length; i++) {
          final question = _questions[i];
          final isEmergencyQ = question.containsKey('emergency') &&
              question['emergency'] == true;
          final isDoctorQ =
              question['question'].contains('chronic digestive conditions');
          final isDurationQ = question['question']
              .toLowerCase()
              .contains('how long have you had these symptoms');

          // Find the user's answer for this question
          final answerIndex =
              i * 2 + 1; // Each question is followed by its answer
          if (answerIndex < _chatWidgets.length) {
            final answerWidget = _chatWidgets[answerIndex];
            if (answerWidget is Align &&
                answerWidget.alignment == Alignment.centerRight &&
                answerWidget.child is Container) {
              final container = answerWidget.child as Container;
              if (container.child is Text) {
                final answerText =
                    (container.child as Text).data?.toLowerCase() ?? '';

                if (isEmergencyQ && answerText == 'yes') {
                  hasEmergency = true;
                } else if (isDoctorQ && answerText.startsWith('yes')) {
                  hasDoctor = true;
                } else if (isDurationQ &&
                    answerText.contains('more than 3 days')) {
                  hasLongDuration = true;
                }
              }
            }
          }
        }

        setState(() {
          _showAnswers = false;
          isTyping = false;

          if (hasEmergency || hasDoctor) {
            _chatWidgets.add(_buildBotMessage(
                "Based on your answers, you should consult with a doctor. Connecting you to a doctor now..."));
            Future.delayed(const Duration(seconds: 1), navigateToChat);
          } else {
            _chatWidgets.add(_buildBotMessage(
                "Thank you for answering the questions. Based on your responses, we recommend checking our advice section."));
            Future.delayed(const Duration(seconds: 1), navigateToAdvices);
          }
        });
        _scrollToBottom();
      }
    });
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
              // Header
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

              // Chat content
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

              // إجابات المستخدم
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
