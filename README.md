# GeoQuiz

## Screenshot
<img src="https://user-images.githubusercontent.com/37167834/233836624-33b73448-4d0f-4ae6-a1e0-d9a3b48a6834.png" width="200" />

## Required Feature

Below message is created by ChatGPT

As a Product Manager, I recommend the following functions and screens for the GeoQuiz application:

1. Onboarding / Tutorial:
    - Introduce users to the app and its features.
    - Explain the gameplay and how to interact with the AI.

2. Main Menu / Home Screen:
    - Start a new game.
    - Access settings and user profile.
    - View achievements and leaderboards.

3. Game Screen:
    - ✅Display the interactive world map.
    - ✅Zoom and pan controls for the map.
    - ✅Search historic memorial place.
    - Display quiz questions and multiple-choice answers.
    - AI chatbox for hints, explanations, and user interaction.
    - Timer and score display.

4. Hint and Explanation Screen:
    - Show detailed hints and explanations from the AI.
    - Include images or videos for better understanding.

5. User Profile and Achievements:
    - Display user's progress, scores, and rankings.
    - List completed and available achievements.
    - Offer customization options for the user's avatar and profile.

6. Leaderboards:
    - Display global and friend rankings.
    - Filter options to view rankings based on various categories and timeframes.

7. Settings:
    - Adjust audio, visual, and gameplay preferences.
    - Manage linked social media accounts.
    - Access help and support.

8. Social Features:
    - Invite friends to play and compare scores.
    - Share achievements and scores on social media platforms.

9. Push Notifications:
    - Remind users to play and engage with the app.
    - Notify users about updates, new content, or events.

10. In-app Store:
- Offer in-app purchases for additional content, hints, or customizations.
- Implement a reward system with in-game currency earned by playing.

These functions and screens should provide a comprehensive and engaging experience for users of the GeoQuiz application.

## How to create json_serializable request/response data which is used by REST API

1. Create file as below 

```dart
import 'package:core_data/api/model/geo_element.dart';
import 'package:json_annotation/json_annotation.dart';

part 'overpass_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OverpassResponse {
  final double version;
  final String generator;
  @JsonKey(name: "elements")
  final List<GeoElementResponseData> geoElements;

  OverpassResponse({
    required this.version,
    required this.generator,
    required this.geoElements,
  });

  factory OverpassResponse.fromJson(Map<String, dynamic> json) =>
      _$OverpassResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OverpassResponseToJson(this);
}
```

 - `part <filename>` : Specify the file name where you want to describe the serialize/deserialize process 
- `explicitToJson: true` means Json data format is nested

2. run command
`flutter packages pub run build_runner build --delete-conflicting-outputs`

