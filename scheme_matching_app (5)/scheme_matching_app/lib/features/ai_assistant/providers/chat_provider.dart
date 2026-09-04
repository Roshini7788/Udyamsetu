import 'package:flutter/foundation.dart';
import '../data/models/chat_message_model.dart';
import '../data/services/ai_chat_service.dart';
import '../../eligibility/data/models/user_profile_model.dart';

/// Drives Screens 4 and 5. Holds the conversation AND the structured
/// profile being built up from it, since in this app the two are one
/// continuous flow (Section 7: adaptive questioning, not a separate form).
class ChatProvider extends ChangeNotifier {
  final AiChatService _service = AiChatService();

  final List<ChatMessageModel> messages = [];
  final UserProfileModel profile = UserProfileModel();
  bool isThinking = false;
  bool get isProfileComplete => profile.isComplete;

  Future<void> start() async {
    messages.clear();
    messages.add(ChatMessageModel(
      text: 'Tell me what you need - for example, "I want to start a small tailoring business."',
      sender: ChatSender.ai,
    ));
    notifyListeners();
  }

  Future<void> sendUserMessage(String text) async {
    if (text.trim().isEmpty) return;
    messages.add(ChatMessageModel(text: text, sender: ChatSender.user));
    isThinking = true;
    notifyListeners();

    _service.extractIntoProfile(text, profile);
    final nextQuestion = await _service.nextQuestionFor(profile);

    messages.add(ChatMessageModel(text: nextQuestion, sender: ChatSender.ai));
    isThinking = false;
    notifyListeners();
  }

  /// Used by the structured eligibility-questions screen (Screen 5) when
  /// the user answers via form fields instead of free text.
  void updateProfileField(String field, dynamic value) {
    switch (field) {
      case 'category':
        profile.category = value as String?;
        break;
      case 'annualFamilyIncome':
        profile.annualFamilyIncome = value as double?;
        break;
      case 'businessType':
        profile.businessType = value as String?;
        break;
      case 'projectCost':
        profile.projectCost = value as double?;
        break;
      case 'requestedLoanAmount':
        profile.requestedLoanAmount = value as double?;
        break;
      case 'state':
        profile.state = value as String?;
        break;
    }
    notifyListeners();
  }
}
