import 'package:google_sign_in/google_sign_in.dart';

class SocialSign {
  final GoogleSignIn signIn = GoogleSignIn.instance;
  final String serverClientId =
      "437475687941-248qnok0d00ql3mpo6eqnsctsviocce9.apps.googleusercontent.com";

  /// Login Google dan ambil idToken
  Future<String?> loginGetIdToken() async {
    try {
      // initialize dengan serverClientId (wajib untuk dapat idToken)
      await signIn.initialize(serverClientId: serverClientId);

      // login / authenticate
      GoogleSignInAccount? account;
      if (signIn.supportsAuthenticate()) {
        // platform mendukung authenticate (Android/iOS)
        account = await signIn.authenticate();
      } else {
        // fallback: gunakan stream-based login atau instance.signInSilently
        account = await signIn.attemptLightweightAuthentication();
      }

      if (account == null) return null; // user cancel login

      // ambil idToken
      final GoogleSignInAuthentication auth = account.authentication;
      return auth.idToken;
    } catch (e) {
      return null;
    }
  }

  /// Logout / disconnect Google
  Future<void> signOut() async {
    await signIn.disconnect();
  }
}
