import Foundation

class HTTPCookieWatcher {

    private var timer: Timer?
    private var previousCookies: [String: String] {
        get {
            UserDefaults.standard.dictionary(forKey: "HTTPCookieWatcher") as? [String: String] ?? [:]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "HTTPCookieWatcher")
        }
    }

    init() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkCookies), userInfo: nil, repeats: true)
    }

    @objc func checkCookies() {
        let currentCookies = createCookieDictionary(from: HTTPCookieStorage.shared.cookies ?? [])
        let newCookies = currentCookies.filter { self.previousCookies[$0.key] == nil }
        let modifiedCookies = currentCookies.filter { self.previousCookies[$0.key] != nil && self.previousCookies[$0.key] != $0.value }
        let deletedCookies = self.previousCookies.filter { currentCookies[$0.key] == nil }

        newCookies.forEach { print("HTTPCookieStorage created: \($0.key) \($0.value.prefix(10))") }
        modifiedCookies.forEach { print("HTTPCookieStorage modified: \($0.key) \($0.value.prefix(10))") }
        deletedCookies.forEach { print("HTTPCookieStorage deleted: \($0.key)") }

        self.previousCookies = currentCookies
    }

    private func createCookieDictionary(from cookies: [HTTPCookie]) -> [String: String] {
        var cookieDict = [String: String]()

        for cookie in cookies {
            cookieDict[cookie.name] = cookie.value
        }

        return cookieDict
    }

}
