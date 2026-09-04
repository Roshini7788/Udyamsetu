import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/primary_button.dart';
import '../../applications/providers/application_provider.dart';
import '../../scheme_matching/data/models/scheme_model.dart';
import '../providers/document_provider.dart';

class DocumentsGuidanceScreen extends StatefulWidget {
  final SchemeModel scheme;
  const DocumentsGuidanceScreen({super.key, required this.scheme});

  @override
  State<DocumentsGuidanceScreen> createState() => _DocumentsGuidanceScreenState();
}

class _DocumentsGuidanceScreenState extends State<DocumentsGuidanceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DocumentProvider>().loadForScheme(widget.scheme.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final docs = context.watch<DocumentProvider>();
    final applications = context.watch<ApplicationProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.requiredDocuments)),
      body: SafeArea(
        child: docs.isLoading
            ? const LoadingIndicator()
            : ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text('${docs.uploadedCount} of ${docs.documents.length} ready',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  ...List.generate(docs.documents.length, (index) {
                    final d = docs.documents[index];
                    return CheckboxListTile(
                      value: d.isUploaded,
                      onChanged: (_) => docs.toggleUploaded(index),
                      title: Text(d.name),
                      subtitle: Text(d.description, style: const TextStyle(fontSize: 12)),
                      activeColor: AppColors.primary,
                      contentPadding: EdgeInsets.zero,
                    );
                  }),
                  const SizedBox(height: 20),
                  Text(AppStrings.applicationGuidance, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  _GuidanceStep(number: 1, text: 'Gather all required documents listed above.'),
                  _GuidanceStep(number: 2, text: 'Visit or contact your nearest authorized Channel Partner.'),
                  _GuidanceStep(number: 3, text: 'Submit your application with the scheme reference: ${widget.scheme.name}.'),
                  _GuidanceStep(number: 4, text: 'Track your application status from "My Applications".'),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'Start My Application',
                    icon: Icons.send_outlined,
                    onPressed: () async {
                      await applications.startApplication(widget.scheme.id, widget.scheme.name);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Application started. Track it under My Applications.')),
                        );
                      }
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

class _GuidanceStep extends StatelessWidget {
  final int number;
  final String text;
  const _GuidanceStep({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 13,
            backgroundColor: AppColors.primary,
            child: Text('$number', style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
