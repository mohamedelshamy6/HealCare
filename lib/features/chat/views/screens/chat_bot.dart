import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  int _currentQuestionIndex = 0;
  bool _showAnswers = true;
  bool isTyping = false;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is your goal?',
      'answers': ['Lose weight', 'Gain muscle', 'Stay fit', 'Other'],
    },
    {
      'question': 'How active are you?',
      'answers': [
        'Very active',
        'Moderately active',
        'Slightly active',
        'Not active'
      ],
    },
    {
      'question': 'Do you have any medical conditions?',
      'answers': ['Diabetes', 'Heart issues', 'None', 'Prefer not to say'],
    },
    {
      'question': 'What is your preferred meal type?',
      'answers': ['Vegetarian', 'Non-vegetarian', 'Vegan', 'No preference'],
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
        // انتهت الأسئلة
        Future.delayed(const Duration(milliseconds: 600), () {
          setState(() {
            isTyping = false;
            _showAnswers = false; // ✅ أخفي الإجابات
            _chatWidgets.add(_buildBotMessage(
                "شكرًا، يبدو أنك لا تحتاج إلى التواصل مع دكتور حاليًا."));
          });
          _scrollToBottom();
        });
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
                        style:
                            AppTextStyles.poppinsBlack(13, FontWeight.w400)),
                  ),
                ),

              // إجابات المستخدم
              if (_showAnswers &&
                  currentAnswers.isNotEmpty &&
                  !isTyping) ...[
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
