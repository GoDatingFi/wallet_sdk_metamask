import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wallet_sdk_metamask/wallet_sdk_metamask.dart';

class AddChainScreen extends StatefulWidget {
  const AddChainScreen({Key? key}) : super(key: key);

  @override
  _AddChainScreenState createState() => _AddChainScreenState();
}

class _AddChainScreenState extends State<AddChainScreen> {
  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'My App',
          description: 'An app for converting pictures to NFT',
          url: 'https://walletconnect.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));

  var _session, _uri;

  @override
  Widget build(BuildContext context) {
    connector.on(
        'connect',
        (session) => setState(
              () {
                _session = _session;
              },
            ));
    connector.on(
        'session_update',
        (payload) => setState(() {
              _session = payload;
              print(_session.accounts[0]);
              print(_session.chainId);
            }));
    connector.on(
        'disconnect',
        (payload) => setState(() {
              _session = null;
            }));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/main_page_image.png',
              fit: BoxFit.fitHeight,
            ),
            (_session != null)
                ? Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account',
                        ),
                        Text(
                          '${_session.accounts[0]}',
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Chain: ',
                            ),
                            Text(_getNetworkName(_session.chainId))
                          ],
                        ),
                        const SizedBox(height: 20),
                        (_session.chainId != 80001)
                            ? Row(
                                children: const [
                                  Icon(Icons.warning,
                                      color: Colors.redAccent, size: 15),
                                  Text('Network not supported. Switch to '),
                                  Text(
                                    'Mumbai Testnet',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            : const SizedBox()
                      ],
                    ))
                : ElevatedButton(
                    onPressed: () => _loginUsingMetamask(context),
                    child: const Text("Connect with Metamask")),
            _session != null
                ? Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                        onPressed: () => _addChain(),
                        child: const Text("Add Matic network")))
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  _loginUsingMetamask(BuildContext context) async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        Logger().d(session.accounts[0]);
        Logger().d(session.chainId);
        setState(() {
          _session = session;
        });
      } catch (exp) {
        Logger().e(exp);
      }
    }
  }

  _addChain() async {
    if (connector.connected) {
      try {
        Logger().d("add chain");

        EthereumWalletConnectProvider provider =
            EthereumWalletConnectProvider(connector);
        launchUrlString(_uri, mode: LaunchMode.externalApplication);
        var name = "Mumbai";
        var chainId = 0x13881;
        List<String> rpc = [
          "https://matic-mumbai.chainstacklabs.com",
          "https://rpc-mumbai.maticvigil.com",
          "https://matic-testnet-archive-rpc.bwarelabs.com"
        ];
        var native = {"name": "MATIC", "symbol": "MATIC", "decimals": 18};
        var explorers = ["https://mumbai.polygonscan.com"];

        var response = await provider.addChain(
            chainId: chainId,
            chainName: name,
            nativeCurrency: native,
            rpc: rpc,
            explorers: explorers);
        Logger().i(response);
      } catch (exp) {
        Logger().e(exp);
      }
    }
  }

  _getNetworkName(chainId) {
    switch (chainId) {
      case 1:
        return 'Ethereum Mainnet';
      case 3:
        return 'Ropsten Testnet';
      case 4:
        return 'Rinkeby Testnet';
      case 5:
        return 'Goreli Testnet';
      case 42:
        return 'Kovan Testnet';
      case 137:
        return 'Polygon Mainnet';
      case 80001:
        return 'Mumbai Testnet';
      default:
        return 'Unknown Chain';
    }
  }
}
