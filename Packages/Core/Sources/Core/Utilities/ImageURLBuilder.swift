import Foundation

public struct ImageURLBuilder: Sendable {
    public let baseURL: URL?
    public let accountID: String
    
    public init(baseURL: URL?, accountID: String) {
        self.baseURL = baseURL
        self.accountID = accountID
    }
    
    public func buildURL(
        image: String?,
        folderName: ImageFolderName,
        folderType: ImageFolderType = .original
    ) -> URL? {
        guard let image = image?.trimmingCharacters(in: .whitespacesAndNewlines), !image.isEmpty else {
            return nil
        }
        
        if image.hasPrefix("http://") || image.hasPrefix("https://") {
            return URL(string: image)
        }
        
        guard let baseURL else { return nil }
        
        var url = baseURL
            .appendingPathComponent("uploads")
            .appendingPathComponent(accountID)
            .appendingPathComponent(folderName.rawValue)
        
        // Skip empty string folder types (e.g. .none)
        if !folderType.rawValue.isEmpty {
            url = url.appendingPathComponent(folderType.rawValue)
        }
        
        return url.appendingPathComponent(image)
    }
    
    public static let `default` = ImageURLBuilder(
        baseURL: nil,
        accountID: ""
    )
}
