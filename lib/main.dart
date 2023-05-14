import 'package:bikeshareapp/screens/mypage_screen.dart';
import 'package:flutter/material.dart';
import 'package:bikeshareapp/screens/home_screen.dart';
import 'package:bikeshareapp/screens/chat_screen.dart';
import 'package:bikeshareapp/screens/search_screen.dart';
import 'package:bikeshareapp/screens/setting_screen.dart';
import 'package:bikeshareapp/screens/resetPassword_screen.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:bikeshareapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //플러터 코어 엔진 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // SystemColorModeObserver를 등록합니다.
  final systemColorModeObserver = SystemColorModeObserver();
  WidgetsBinding.instance.addObserver(systemColorModeObserver);

  final brightness = WidgetsBinding.instance.window.platformBrightness;
  final isDarkMode = brightness == Brightness.dark;
  if (isDarkMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.black, // 상태창 배경색
      systemNavigationBarColor: Colors.black, // 네비게이션바 배경색
      statusBarIconBrightness: Brightness.light, // 상태창 아이콘 색상
      systemNavigationBarIconBrightness: Brightness.light, // 네비게이션바 아이콘 색상
    ));
  } else {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white, // 상태창 배경색
      systemNavigationBarColor: Colors.white, // 네비게이션바 배경색
      statusBarIconBrightness: Brightness.dark, // 상태창 아이콘 색상
      systemNavigationBarIconBrightness: Brightness.dark, // 네비게이션바 아이콘 색상
    ));
  }

  /*  statusBarColor: MyApp.themeNotifier.value == ThemeMode.light
        ? Colors.white // 밝은 모드에서 검은색
        : const Color(0xFF212121), // 어두운 모드에서 흰색
    systemNavigationBarColor: MyApp.themeNotifier.value == ThemeMode.light
        ? Colors.white // 밝은 모드에서 흰색
        : const Color(0xFF212121), // 어두운 모드에서 검은색
    systemNavigationBarIconBrightness:
        MyApp.themeNotifier.value == ThemeMode.light
            ? Brightness.dark
            : Brightness.light,
  ));*/

  runApp(const MyApp());
}

class SystemColorModeObserver with WidgetsBindingObserver {
  @override
  void didChangePlatformBrightness() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    if (brightness == Brightness.dark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: const Color(0xFF212121), // 상태창 배경색
        systemNavigationBarColor: const Color(0xFF212121), // 네비게이션바 배경색
        statusBarIconBrightness: Brightness.light, // 상태창 아이콘 색상
        systemNavigationBarIconBrightness: Brightness.light, // 네비게이션바 아이콘 색상
      ));
      // 시스템이 다크 모드인 경우의 처리
      // 여기에서 UI 색상을 변경합니다.
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white, // 상태창 배경색
        systemNavigationBarColor: Colors.white, // 네비게이션바 배경색
        statusBarIconBrightness: Brightness.dark, // 상태창 아이콘 색상
        systemNavigationBarIconBrightness: Brightness.dark, // 네비게이션바 아이콘 색상
      ));
      // 시스템이 라이트 모드인 경우의 처리
      // 여기에서 UI 색상을 변경합니다.
    }
  }
}

MaterialColor primaryColor = const MaterialColor(0xFFFFFFFF, {
  //primarily switch에 들어갈 color객체표
  50: Color(0xFFFFFFFF),
  100: Color(0xFFFFFFFF),
  200: Color(0xFFFFFFFF),
  300: Color(0xFFFFFFFF),
  400: Color(0xFFFFFFFF),
  500: Color(0xFFFFFFFF),
  600: Color(0xFFFFFFFF),
  700: Color(0xFFFFFFFF),
  800: Color(0xFFFFFFFF),
  900: Color(0xFFFFFFFF),
});

class Palette {
  static const Color iConColor = Colors.amber;
  static const Color highlightColor = Colors.amber;
  static const Color activeColor = Colors.amber;
  static const Color inActiveColor = Colors.grey;
  static const Color darkModeColor = Color(0xFF212121);
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  //static final Brightness platformBrightness = MediaQuery.of(context).platformBrightness;

  const MyApp({super.key});

  // static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        /**
         * 이 코드는 Flutter 프레임워크에서 제공하는 ValueListenableBuilder 위젯을 사용하여, 테마 모드를 동적으로 변경할 수 있게 해주는 코드입니다.

ValueListenableBuilder 위젯은 ValueListenable을 구독하고, 그 값이 변경될 때마다 builder 함수를 호출하여 위젯을 다시 그립니다. 이 코드에서는 themeNotifier라는 ValueNotifier<ThemeMode> 객체를 valueListenable 매개변수에 전달하여, 테마 모드가 변경될 때마다 builder 함수가 호출되도록 설정합니다.

builder 함수는 세 개의 매개변수를 받습니다. 첫 번째 매개변수인 _는 BuildContext 객체입니다. 두 번째 매개변수인 currentMode는 ValueListenable에 저장된 현재 테마 모드 값입니다. 세 번째 매개변수인 __는 builder 함수를 다시 호출하도록 하는 VoidCallback입니다.

따라서 builder 함수는 현재 테마 모드 값을 이용하여 새로운 위젯을 반환하게 됩니다. 이러한 방식으로 ValueListenableBuilder 위젯은 ValueNotifier에 의존하는 위젯을 빌드할 수 있게 해주는 유용한 도구입니다.
         */
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            // Remove the debug banner
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: '',
              primarySwatch: primaryColor,
              cardColor: const Color.fromARGB(255, 0, 0, 0),
            ),

            darkTheme: ThemeData.dark(),
            themeMode: currentMode,

            home: const LoginSignUpPage(),
          );
        });
  }
}

//MainPage
class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void reloadApp() {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MyApp());
  }

  //bool isSelected = true;
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: MyApp.themeNotifier.value == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                  width: 0.1,
                ),
              ),
            ),
            child: AppBar(
              elevation: 0,
              title: const Text('App'),
              centerTitle: true,
              backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
                  ? Colors.white
                  : const Color(0xFF212121),
              actions: [
                const AppBarRightIconButton(
                    page: SearchScreen(), icon: Icons.search),
                IconButton(
                  onPressed: () {
                    setState(() {
                      MyApp.themeNotifier.value =
                          MyApp.themeNotifier.value == ThemeMode.light
                              ? ThemeMode.dark
                              : ThemeMode.light;
                      // SystemUiOverlayStyle(
                      //   systemNavigationBarColor:
                      //       MyApp.themeNotifier.value == ThemeMode.light
                      //           ? Colors.white
                      //           : const Color(0xFF212121),
                      // );
                    });
                    reloadApp();
                  },
                  icon: MyApp.themeNotifier.value == ThemeMode.light
                      ? const Icon(Icons.dark_mode_sharp)
                      : const Icon(Icons.light_mode_rounded),
                ),
                const AppBarRightIconButton(
                    page: SettingScreen(), icon: Icons.settings),
              ],
            ),
          ),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: const [
            HomeScreen(),
            //SearchScreen(),
            ChatPage(),
            MyPage(),
          ],
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            dividerColor: Colors.white,
            dividerTheme: const DividerThemeData(
              thickness: 3,
            ),
            splashColor: Colors.transparent, //스플래시효과 제거
            highlightColor: Colors.transparent,
          ),
          child: Container(
            decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(width: 0.1, color: Colors.white))),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              enableFeedback: false,
              iconSize: 22,
              //backgroundColor: const Color(0xFF212121),
              backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
                  ? Colors.white
                  : const Color(0xFF212121),
              unselectedItemColor: MyApp.themeNotifier.value == ThemeMode.light
                  ? const Color(0xFF212121)
                  : Colors.white,
              selectedItemColor: MyApp.themeNotifier.value == ThemeMode.light
                  ? const Color(0xFF212121)
                  : Colors.white,
              //unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
              selectedFontSize: 16,
              currentIndex: _selectedIndex,
              onTap: (value) {
                //value는 item = [] 내부의 배열 인덱스(0~n);
                setState(() {
                  _selectedIndex = value;
                  //isSelected = !isSelected;
                });
                print('value: $value');
              },
              items: [
                BottomNavigationBarItem(
                  icon: _selectedIndex == 0 //_selectedIndex의 값에 따라 표시되는 아이콘 변경
                      ? const Icon(Icons.home_rounded)
                      : const Icon(Icons.home_outlined),
                  label: '홈',
                ),
                // BottomNavigationBarItem(
                //   icon: _selectedIndex == 1
                //       ? const Icon(Icons.saved_search)
                //       : const Icon(Icons.search),
                //   label: '검색',
                // ),
                BottomNavigationBarItem(
                  icon: _selectedIndex == 1
                      ? const Icon(Icons.chat_bubble)
                      : const Icon(Icons.chat_bubble_outline),
                  label: '채팅',
                ),
                BottomNavigationBarItem(
                  icon: _selectedIndex == 2
                      ? const Icon(Icons.person)
                      : const Icon(Icons.person_outline),
                  label: '마이페이지',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppBarRightIconButton extends StatelessWidget {
  //final Function? pageRouter = (context) => const SearchScreen();
  final Widget page;
  final IconData icon;
  const AppBarRightIconButton({
    super.key,
    required this.page,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page, //search페이지로 이동
          ),
        );
      },
      splashColor: Colors.transparent,
    );
  }
}

class LoginSignUpPage extends StatefulWidget {
  const LoginSignUpPage({super.key});

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  bool isSignUpScreen = false;
  final _formKey = GlobalKey<FormState>();
  //private, 글로벌키에 바인드할 state는 form위젯을 통해서 모든 텍스트폼필드에 밸리데이션 작동, ==>FormState가 되어야함.
  final _authentication =
      FirebaseAuth.instance; //authentication 인스턴스 생성 , 사용자 등록 및 인증에 사용
  String userName = '';
  String userEmail = '';
  String userPassword = '';

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      //formstate의 값이 유효할 경우에 한해서 formKey의 currentstate에서 value값을 가져온 후 save.
      _formKey.currentState!.save();
      //return 'pass'; //널 체크 필요. 아래주석 이유와 동일
    }
    /*currentState에 의해서만 validate가 호출될 수 있으므로, currentState에 대한 null check가 필요 */
    //유효성검사에 대한 결과를 isValid에 저장
    //return null;
  }
/*사용자가 텍스트 폼필드에 입력한 정보의 유효성을 확인하기 위해서는 currentState속성을 통해서 FormState에 접근해야함.*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height:
                      MediaQuery.of(context).size.height, //높이를 디바이스 기기 높이만큼 설정
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/gradient.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 80,
                      left: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'WelCome',
                            style: const TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 25,
                              color: Colors.black,
                            ),
                            children: [
                              WidgetSpan(
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      isSignUpScreen
                                          ? ' to Demo App !'
                                          : ' Back !',
                                      speed: const Duration(milliseconds: 180),
                                      textStyle: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          isSignUpScreen
                              ? 'SignUp to Continue'
                              : 'Login to Continue',
                          style: const TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // ↑ background
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
                top: 150,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  padding: const EdgeInsets.all(20),
                  height: isSignUpScreen ? 270 : 240, //로그인, 회원가입에 따라 높이조정
                  width: MediaQuery.of(context).size.width - 30,
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: MyApp.themeNotifier.value == ThemeMode.light
                        ? Colors.white.withOpacity(0.75)
                        : Palette.darkModeColor.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignUpScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    '로그인',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: MyApp.themeNotifier.value ==
                                              ThemeMode.light
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  if (!isSignUpScreen)
                                    Container(
                                      height: 3,
                                      width: 75,
                                      color: isSignUpScreen
                                          ? Palette.inActiveColor
                                          : Colors.teal,
                                    ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignUpScreen = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    '가입하기',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: MyApp.themeNotifier.value ==
                                              ThemeMode.light
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  if (isSignUpScreen)
                                    Container(
                                      height: 3,
                                      width: 90,
                                      color: isSignUpScreen
                                          ? Colors.indigo
                                          : Palette.inActiveColor,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (!isSignUpScreen) //로그인 페이지
                          Container(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    onChanged: (value) {
                                      userEmail = value;
                                    },
                                    onSaved: (value) {
                                      userEmail = value!;
                                    },
                                    key: const ValueKey(4),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !value.contains('@')) {
                                        return '유효한 이메일 주소를 입력해 주세요.';
                                      }
                                      return null;
                                    },
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                        color: MyApp.themeNotifier.value ==
                                                ThemeMode.light
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Palette.inActiveColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyApp.themeNotifier.value ==
                                                  ThemeMode.light
                                              ? Palette.darkModeColor
                                              : Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyApp.themeNotifier.value ==
                                                  ThemeMode.light
                                              ? Palette.darkModeColor
                                              : Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.all(10),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    onChanged: (value) {
                                      userPassword = value;
                                    },
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    key: const ValueKey(5),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '비밀번호를 입력해 주세요.';
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                        color: MyApp.themeNotifier.value ==
                                                ThemeMode.light
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.lock_person,
                                        color: Palette.inActiveColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyApp.themeNotifier.value ==
                                                  ThemeMode.light
                                              ? Palette.darkModeColor
                                              : Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyApp.themeNotifier.value ==
                                                  ThemeMode.light
                                              ? Palette.darkModeColor
                                              : Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.all(10),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  TextButton(
                                    //비밀번호찾기
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ResetPasswordScreen()));
                                    },
                                    child: Text(
                                      '비밀번호를 잊으셨나요? 여기를 클릭하세요.',
                                      style: TextStyle(
                                        color: MyApp.themeNotifier.value ==
                                                ThemeMode.light
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: isSignUpScreen ? 50 : 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (isSignUpScreen) //회원가입 페이지
                          Container(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    onChanged: (value) {
                                      userName = value;
                                    },
                                    onSaved: (value) {
                                      userName = value!; //널체크
                                    },
                                    key: const ValueKey(1),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 3) {
                                        return '사용자이름을 3글자 이상 입력해주세요';
                                      }
                                      return null;
                                    },
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      hintText: 'UserName',
                                      hintStyle: TextStyle(
                                        color: MyApp.themeNotifier.value ==
                                                ThemeMode.light
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.account_box,
                                        color: Palette.inActiveColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyApp.themeNotifier.value ==
                                                  ThemeMode.light
                                              ? Palette.darkModeColor
                                              : Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyApp.themeNotifier.value ==
                                                  ThemeMode.light
                                              ? Palette.darkModeColor
                                              : Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.all(10),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    onChanged: (value) {
                                      userEmail = value;
                                    },
                                    onSaved: (value) {
                                      userEmail = value!;
                                    },
                                    key: const ValueKey(2),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !value.contains('@')) {
                                        return '유효한 이메일 주소를 입력해 주세요.';
                                      }
                                      return null;
                                    },
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                        color: MyApp.themeNotifier.value ==
                                                ThemeMode.light
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Palette.inActiveColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyApp.themeNotifier.value ==
                                                  ThemeMode.light
                                              ? Palette.darkModeColor
                                              : Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyApp.themeNotifier.value ==
                                                  ThemeMode.light
                                              ? Palette.darkModeColor
                                              : Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.all(10),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    onChanged: (value) {
                                      userPassword = value;
                                    },
                                    onSaved: (value) {
                                      userPassword = value!;
                                    },
                                    key: const ValueKey(3),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 6) {
                                        return '비밀번호는 최소 6자리 이상 입력해 주세요.';
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      hintText: 'Password (at least 6 words)',
                                      hintStyle: TextStyle(
                                        color: MyApp.themeNotifier.value ==
                                                ThemeMode.light
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.lock_person,
                                        color: Palette.inActiveColor,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyApp.themeNotifier.value ==
                                                  ThemeMode.light
                                              ? Palette.darkModeColor
                                              : Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyApp.themeNotifier.value ==
                                                  ThemeMode.light
                                              ? Palette.darkModeColor
                                              : Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.all(10),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              // ↑ Textformfields
              if (isSignUpScreen)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  top: 440,
                  right: MediaQuery.of(context).size.width - 250,
                  left: MediaQuery.of(context).size.width - 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(140, 60),
                      backgroundColor:
                          MyApp.themeNotifier.value == ThemeMode.light
                              ? Colors.white.withOpacity(0.8)
                              : Palette.darkModeColor.withOpacity(0.8),
                    ),
                    onPressed: () async {
                      if (isSignUpScreen) {
                        _tryValidation();

                        try {
                          final newUser = await _authentication
                              .createUserWithEmailAndPassword(
                            email: userEmail,
                            password: userPassword,
                          );
                          if (newUser.user != null) {
                            await newUser.user!.updateDisplayName(userName);
                          }

                          //등록이 되었는지 체크
                          if (newUser.user != null) {
                            //nueUser변수의 user가 null이 아닐 경우
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('비밀번호는 6자리 이상 입력해 주세요.'),
                              ),
                            );
                          } else if (e.code == 'email-already-in-use') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('이미 사용중인 Email입니다.'),
                              ),
                            );
                          }
                          print(e);
                        }
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text('SIGN UP'),
                        Icon(Icons.arrow_forward_outlined),
                      ],
                    ),
                  ),
                ),
              // ↑ SignUp button
              if (!isSignUpScreen)
                AnimatedPositioned(
                  duration: const Duration(
                    milliseconds: 300,
                  ),
                  curve: Curves.easeIn,
                  top: 420,
                  right: MediaQuery.of(context).size.width - 250,
                  left: MediaQuery.of(context).size.width - 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(140, 60),
                      backgroundColor:
                          MyApp.themeNotifier.value == ThemeMode.light
                              ? Colors.white.withOpacity(0.8)
                              : Palette.darkModeColor.withOpacity(0.8),
                    ),
                    onPressed: () async {
                      if (!isSignUpScreen) {
                        _tryValidation();
                        try {
                          final newUser =
                              await _authentication.signInWithEmailAndPassword(
                                  email: userEmail, password: userPassword);
                          if (newUser.user != null) {
                            //nueUser변수의 user가 null이 아닐 경우
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found' ||
                              e.code == 'wrong-password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    '등록되지 않은 계정이거나 \n아이디 또는 비밀번호를 잘못 입력했습니다.'),
                              ),
                            );
                          }
                          print(e);
                        }
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text('LOGIN'),
                        Icon(Icons.arrow_forward_outlined),
                      ],
                    ),
                  ),
                ),
              // ↑ Login button
              //전송버튼
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
                top: isSignUpScreen ? 510 : 490,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    if (!isSignUpScreen)
                      AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'or Login with',
                            speed: const Duration(milliseconds: 100),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    if (isSignUpScreen)
                      AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'or Sign with',
                            speed: const Duration(milliseconds: 100),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (!isSignUpScreen)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainPage(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                        ),
                        child: Container(
                          width: 70,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/google.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    if (isSignUpScreen)
                      ElevatedButton(
                        onPressed: () {
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainPage(),
                              ));*/
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                        ),
                        child: Container(
                          width: 70,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/google.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
