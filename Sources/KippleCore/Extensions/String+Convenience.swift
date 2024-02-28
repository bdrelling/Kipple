import Foundation

// TODO: Write tests
public extension String {
    func replacingTabsWithSpaces(_ count: Int = 4) -> String {
        self.replacingOccurrences(of: "\t", with: "    ")
    }
    
    func trimmingSlashes() -> String {
        self.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
    }
    
    func base64Encoded() -> String? {
        let data = self.data(using: .utf8)
        return data?.base64EncodedString()
    }
}
