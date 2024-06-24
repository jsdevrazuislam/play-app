# My Flutter App

A Flutter application using Socket.IO for real-time functionalities. This app allows users to interact with a scrollable video list, like or dislike videos and comments in real-time, and handle authentication.

## Features

- **Scrollable Video List**: Browse through a list of videos that can be scrolled vertically.
- **Real-Time Like/Dislike**: Users can like or dislike videos in real-time.
- **Real-Time Comments**: Users can post comments on videos, and other users can like or dislike these comments in real-time.
  - Only the author can delete their own comments.
- **Video Handling**: Comprehensive management of video playback and interactions.
- **Auth Flow**: Secure user authentication process.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Node.js](https://nodejs.org/) and [npm](https://www.npmjs.com/get-npm)
- Socket.IO server setup (refer to the [Socket.IO documentation](https://socket.io/docs/))

### Installation

1. Clone the repository:

    ```sh
    git clone https://github.com/jsdevrazuislam/play-app
    cd play-app
    ```

2. Install dependencies:

    ```sh
    flutter pub get
    ```

3. Start your Socket.IO server. Ensure it is running on the appropriate port.

4. Run the app:

    ```sh
    flutter run
    ```

## Usage

### Scrollable Video List

The main screen displays a vertically scrollable list of videos. Each video item includes a thumbnail, title, and like/dislike buttons.

### Real-Time Like/Dislike

Users can like or dislike videos. These interactions are updated in real-time across all connected clients using Socket.IO.

### Real-Time Comments

Users can add comments to videos. Other users can like or dislike these comments in real-time. Only the author of a comment can delete it.

### Video Handling

The app provides functionalities for video playback, pause, and seek. 

### Auth Flow

The app includes a secure authentication process, ensuring that only registered users can like, dislike, or comment on videos.

## Project Structure

```plaintext
lib/
├── main.dart                  # Entry point of the application
├── screens/                   # All screen-related files
│   ├── home_screen.dart       # Home screen with video list
│   ├── video_screen.dart      # Video playback screen
│   └── auth_screen.dart       # Authentication screen
├── models/                    # Data models
│   ├── video.dart             # Video model
│   ├── comment.dart           # Comment model
│   └── user.dart              # User model
├── widgets/                   # Reusable UI components
│   ├── video_item.dart        # Widget for displaying a video item
│   ├── comment_item.dart      # Widget for displaying a comment item
│   └── like_button.dart       # Widget for like/dislike button
└── utils/                     # Utility functions and constants
    └── constants.dart         # App-wide constants
