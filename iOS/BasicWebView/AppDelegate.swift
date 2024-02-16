import UIKit
import WebKit

let cookiesToWatch = ["myCookie"]

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let wkCookieWatcher = WKCookieWatcher()
    let httpCookieWatcher = HTTPCookieWatcher()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

}
