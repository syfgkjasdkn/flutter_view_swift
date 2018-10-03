import UIKit
import Flutter

class MainViewController: UIViewController {
  var nativeViewController: NativeViewController?
  var flutterViewController: FlutterViewController?
  var messageChannel: FlutterBasicMessageChannel?

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "NativeViewControllerSegue":
      nativeViewController = segue.destination as? NativeViewController
      nativeViewController?.delegate = self
    case "FlutterViewControllerSegue":
      flutterViewController = segue.destination as? FlutterViewController
      messageChannel = FlutterBasicMessageChannel(name: "channel",
                                                  binaryMessenger: flutterViewController!,
                                                  codec: FlutterStringCodec.sharedInstance())
      messageChannel?.setMessageHandler { [weak self] (message, reply) in
        self?.nativeViewController?.didReceiveIncrement()
        reply("")
      }
    default: ()
    }
  }
}

extension MainViewController: NativeViewControllerDelegate {
  func didTapIncrementButton() {
    messageChannel?.sendMessage("ping")
  }
}
