import QuickLook

public final class PreviewItem: NSObject {
    public let url: URL
    
    public let title: String
    
    public init(url: URL, title: String) {
        self.url = url
        self.title = title
    }
}

// MARK: - QLPreviewItem

extension PreviewItem: QLPreviewItem {
    public var previewItemURL: URL? { url }
    
    public var previewItemTitle: String? { title }
}
