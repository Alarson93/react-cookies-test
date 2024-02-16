import Foundation
import WebKit

class WKCookieWatcher: NSObject, WKHTTPCookieStoreObserver {

    private var previousCookies: [String: String] {
        get {
            UserDefaults.standard.dictionary(forKey: "WKHTTPCookieStore") as? [String: String] ?? [:]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "WKHTTPCookieStore")
        }
    }

    override init() {
        super.init()
        WKWebsiteDataStore.default().httpCookieStore.add(self)
    }

    func cookiesDidChange(in cookieStore: WKHTTPCookieStore) {
        cookieStore.getAllCookies { cookies in
            let currentCookies = self.createCookieDictionary(from: cookies)
            let newCookies = currentCookies.filter { self.previousCookies[$0.key] == nil }
            let modifiedCookies = currentCookies.filter { self.previousCookies[$0.key] != nil && self.previousCookies[$0.key] != $0.value }
            let deletedCookies = self.previousCookies.filter { currentCookies[$0.key] == nil }

            newCookies.forEach { print("WKHTTPCookieStore created: \($0.key) \($0.value.prefix(10))") }
            modifiedCookies.forEach { print("WKHTTPCookieStore modified: \($0.key) \($0.value.prefix(10))") }
            deletedCookies.forEach { print("WKHTTPCookieStore deleted: \($0.key)") }

            self.previousCookies = currentCookies
        }
    }

    private func createCookieDictionary(from cookies: [HTTPCookie]) -> [String: String] {
        var cookieDict = [String: String]()

        for cookie in cookies {
            cookieDict[cookie.name] = cookie.value
        }

        return cookieDict
    }

}
