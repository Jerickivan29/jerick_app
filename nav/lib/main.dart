import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: const Color.fromARGB(255, 0, 173, 181),
        title: const Text("Choppee"),
        leading: const Icon(Icons.filter_vintage),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Text(
                  "Choppee Login",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {
                    // Validator
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                      return 'Enter a valid email!';
                    } else if (value != "tulipat9@gmail.com") {
                      return 'Account not found';
                    }
                    return null;
                  },
        
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (value) {},
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid password!';
                    } else if (value != "russel123") {
                      return "Wrong password. Try again.";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                  child: const Text("Login"),
                  onPressed: () => _submit(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == PassArgumentsScreen.routeName) {
          final Arguments args = settings.arguments as Arguments;
          return MaterialPageRoute(
            builder: (context) {
              return PassArgumentsScreen(
                title: args.titleBar,
                message: args.textMessage,
              );
            },
          );
        }
        assert(false, 'Implementation ${settings.name}');
        return null;
      },
      title: 'Arguments in named routes',
      home: const HomeScreen(),
      routes: {
        ExtractArgumentsScreen.routeName: (context) =>
            const ExtractArgumentsScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IT 331: AppDev'),
        backgroundColor: Colors.amber[500],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ExtractArgumentsScreen.routeName,
                  arguments: Arguments(
                    'Extract Arguments Screen',
                    'Extracted in the build method.',
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.yellow),
              ),
              child: const Text("Extract arguments"),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  PassArgumentsScreen.routeName,
                  arguments: Arguments(
                    'Accept Arguments Screen',
                    'Extracted in the onGenerateRoute function.',
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.yellow),
              ),
              child: const Text("Accept arguments"),
            ),
          ],
        ),
      ),
    );
  }
}

class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';
  const ExtractArgumentsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final Arguments args =
        ModalRoute.of(context)!.settings.arguments as Arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.titleBar),
      ),
      body: Center(
        child: Text(args.textMessage),
      ),
    );
  }
}

class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';
  final String title;
  final String message;
  const PassArgumentsScreen({
    super.key,
    required this.title,
    required this.message,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

class Arguments {
  final String titleBar;
  final String textMessage;
  Arguments(this.titleBar, this.textMessage);
}
