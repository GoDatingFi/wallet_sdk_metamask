# wallet_sdk_metamask

We're GoDatingFi.com, A decentralized Global Platform for Dating.
=> Auto-add network on the Metamask by flutter.


## Screenshots

<img src="https://github.com/GoDatingFi/wallet_sdk_metamask/blob/master/example/assets/demo.JPEG" height="400em" width="225em" />

## Usage

[Example](https://github.com/GoDatingFi/wallet_sdk_metamask/blob/master/example/lib/pages/add_chain.dart)

To use this package :

* add the dependency to your [pubspec.yaml](https://github.com/GoDatingFi/wallet_sdk_metamask/blob/master/pubspec.yaml) file.

```yaml
  dependencies:
    flutter:
      sdk: flutter
    wallet_sdk_metamask:
```

### How to use

```dart
_addChain() async {
    if (connector.connected) {
      try {
        Logger().d("add chain");

        EthereumWalletConnectProvider provider =
            EthereumWalletConnectProvider(connector);
        launchUrlString(_uri, mode: LaunchMode.externalApplication);
        var name = "Mumbai";
        var chainId = ChainId.MATIC;
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

```

# License
Copyright (c) 2020 Parth Patel

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).