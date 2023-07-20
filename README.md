# Article Explorer

Article Explorer is a Flutter app that allows users to explore and read the most popular articles in New York Times. The app is built in MVVM architecture.

## Getting Started

Follow the steps below to set up and run the Article Explorer app on your local machine.

### Prerequisites

Make sure you have the following tools installed on your machine:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)

### Installation

1. Clone the repository:
git clone https://github.com/AlpKarky/article_explorer.git

2. Change into the project directory:
cd article_explorer

3. Install dependencies:
flutter pub get

### Running the App

To run the app on a connected device or emulator, use the following command:
flutter run

### Running Tests

To execute unit tests and generate coverage reports, run the following command:
flutter test --coverage

The coverage report will be generated in the `coverage/lcov.info` file.

### Viewing Coverage Report

To view the coverage report in a more human-readable format, you can use the `lcov` tool.

After installing `lcov`, you can generate an HTML coverage report using the following command:

genhtml coverage/lcov.info -o coverage/html

Open the generated `index.html` file in the `coverage/html` directory with your web browser to view the coverage report.

### Notes

- The tests include unit tests for the ViewModel and Widget tests using `flutter_test` and `mocktail` packages.
- The `ArticlesViewModel` class is tested separately using mock services to ensure proper functionality.
- Widget tests cover UI elements and interactions to validate the app's behavior.
- The coverage report helps you assess the test coverage for your app.
