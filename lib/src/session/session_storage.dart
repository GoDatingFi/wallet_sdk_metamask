
import '../../wallet_sdk_metamask.dart';

abstract class SessionStorage {
  Future store(WalletConnectSession session);

  Future<WalletConnectSession?> getSession();

  Future removeSession();
}
