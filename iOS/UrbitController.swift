import Foundation

class UrbitController {
  static var log: LogDelegate?;
  
  let docsDirectory: NSString? = {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let basePath = paths.first
    return basePath
  }()
  
  func start() {
    if let docsDirectory = docsDirectory {
      if let urbLib = NSBundle.mainBundle().pathForResource("urb", ofType: nil) as NSString? {
        dispatch_after(
          dispatch_time(DISPATCH_TIME_NOW, 2000000000),
          dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
          {
            main3(
              docsDirectory.UTF8String,
              urbLib.UTF8String,
              { UrbitController.receive(String.fromCString($0), error: false) },
              { UrbitController.receive(String.fromCString($0), error: true) })
          })
      }
    }
  }
  
  class func receive(line: String?, error: Bool) {
    if let line = line {
      if let log = log {
        log.receive(line, error: error)
      }
    }
  }
}

protocol LogDelegate {
  func receive(line: String, error: Bool);
}