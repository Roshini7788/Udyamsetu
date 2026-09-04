# YojanaSetu - AI-Driven Scheme Matching (SIH26092)

Flutter mobile app prototype - Phase 1 (UI + navigation, dummy data).

## What's implemented

All 10 MVP screens + login/signup, fully navigable, running on local dummy
data (3 sample schemes, 3 sample channel partners). No backend, no Gemini
key, no Google Maps key required yet - that's Phase 3+.

Flow: Splash -> Login -> Home Dashboard -> AI Assistant (chat) ->
Eligibility confirm -> Matched Schemes (ranked, explainable) ->
Scheme Details -> EMI Calculator / Documents / Nearby Partners ->
My Applications.

## Setup

This project was hand-built as source files (no `flutter create` was run,
since the Flutter SDK isn't available in the sandbox that generated it).
On your machine, with Flutter installed:

```bash
cd scheme_matching_app
flutter pub get
flutter run
```

If `flutter pub get` complains about a missing platform folder (android/,
ios/), that's because those weren't generated here. Fix with:

```bash
flutter create . --project-name scheme_matching_app
flutter pub get
flutter run
```

This regenerates the platform scaffolding in place without touching your
`lib/` folder.

## Project structure

See `lib/` - organized feature-first:

```
lib/
  core/            shared constants, theme, reusable widgets
  features/        one folder per feature (auth, ai_assistant,
                    eligibility, scheme_matching, emi_calculator,
                    channel_partners, documents, applications, home, splash)
  routes/          app_router.dart - central named-route table
  main.dart        MultiProvider + MaterialApp bootstrap
```

Each feature follows `data/` (models + services) -> `providers/`
(ChangeNotifier state) -> `presentation/` (screens).

## Swapping dummy data for the real backend (Phase 3+)

Every service class under `features/*/data/services/` is written so its
**method signatures stay stable** when you replace the dummy logic with
real `http` calls to the Node/Express API:

| Service | Currently | Becomes (Phase 3+) |
|---|---|---|
| `auth_service.dart` | accepts any non-empty login | `POST /auth/login`, `/auth/register` + JWT storage |
| `ai_chat_service.dart` | keyword-matching stub | `POST /ai/chat`, `/ai/extract-profile` (Gemini) |
| `scheme_service.dart` | local rule logic on `dummy_data.dart` | `POST /schemes/match` |
| `partner_service.dart` | filters `dummy_data.dart` | `GET /partners/nearby` + Google Maps |
| `document_service.dart` | reads `dummy_data.dart` | `GET /documents/:schemeId` |
| `application_service.dart` | in-memory list | `POST /applications`, `GET /applications/:userId` |
| `emi_service.dart` | already deterministic local math | stays local (Section 17: never call AI for this) |

`core/constants/api_endpoints.dart` already has every endpoint URL ready
to use - point `ApiEndpoints.baseUrl` at your deployed backend via
`--dart-define=API_BASE_URL=https://your-api.com/api`.

## Known gaps (intentional, later phases)

- Voice input (mic button) is a stub - Phase 6 wires `speech_to_text` /
  `flutter_tts` behind the same `sendUserMessage` callback.
- Nearby Partners is list-only - Phase 8 adds the map view alongside it.
- No JWT persistence yet (`shared_preferences` is in `pubspec.yaml`,
  unused until Phase 3).
- No regional-language localization wiring yet (`core/localization/` is
  an empty folder reserved for Phase 6-9).
