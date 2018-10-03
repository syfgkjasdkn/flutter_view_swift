import UIKit

protocol NativeViewControllerDelegate: class {
  func didTapIncrementButton()
}

class NativeViewController: UIViewController {
  weak var delegate: NativeViewControllerDelegate?
  var counter: Int = 0 {
    didSet {
      updateIncrementLabel()
    }
  }

  @IBOutlet weak var incrementLabel: UILabel?

  private func updateIncrementLabel() {
    let times = counter == 1 ? "time" : "times"
    incrementLabel?.text = "Flutter button tapped \(counter) \(times)"
  }

  @IBAction func handleIncrement(_ sender: UIButton) {
    delegate?.didTapIncrementButton()
  }

  func didReceiveIncrement() {
    counter += 1
  }
}
