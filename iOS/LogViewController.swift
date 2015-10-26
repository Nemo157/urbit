import UIKit

class LogViewController: UIViewController, LogDelegate {
  override func viewDidLoad() {
    super.viewDidLoad()
    UrbitController.log = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func receive(line: String, error: Bool) {
    if let log = self.view.viewWithTag(2) as! UITextView? {
      dispatch_async(dispatch_get_main_queue(), {
        let attr = error
          ? NSAttributedString(string: line, attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
          : NSAttributedString(string: line)
        
        log.textStorage.appendAttributedString(attr)
      })
    }
  }
}

