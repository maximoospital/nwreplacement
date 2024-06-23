import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  
  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    title: "Maxi's Steam Remote Play Launcher says hi!",
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setResizable(false);
    await windowManager.setMaximizable(false);
    await windowManager.show();
    await windowManager.focus();
  });
    runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  // Check config, if tutorial is done and the bitfiesta folder contains nw.exe, show main screen, else show tutorial screen

  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/main',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: {
        '/main': (context) => const MainScreen()
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        title: "Hi there!",
        body: "If you're seeing this screen, something's gone wrong.\nIt's either your settings, or us screwing up!\n Let's fix that.",
        image: const Center(child: Icon(FontAwesomeIcons.steam, size: 100.0)),
      ),
      PageViewModel(
        title: "Why are you seeing this?",
        body: "This app is a placeholder.\n It's meant to be replaced by the last game you've launched.",
        image: const Center(child: Icon(FontAwesomeIcons.list, size: 50.0)),
      ),
      PageViewModel(
        title: "How do I fix this?",
        body: "Go back to the launcher and pick a game from your list!\nUpon a first launch, we'll make sure you don't see this anymore.",
        image: const Center(child: Icon(FontAwesomeIcons.exclamationCircle, size: 50.0)),
      ),
      PageViewModel(
        title: "And that's it!",
        body: "Go ahead, close this!\n No, seriously, get out!!!",
        image: const Center(child: Icon(FontAwesomeIcons.checkCircle, size: 100.0)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: getPages(),
      onDone: () async {
        await windowManager.close();
      },
      showSkipButton: false,
      showNextButton: true,
      showBackButton: true,
      back: const Text("Go Back"),
      next: const Text("Next"),
      done: const Text("Exit", style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}