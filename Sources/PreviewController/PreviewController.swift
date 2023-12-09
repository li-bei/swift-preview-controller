import QuickLook

public final class PreviewController: NSObject {
    public var items: [PreviewItem]
    
    public var currentPreviewItemIndex: Int = 0
    
    public weak var transitionView: UIView?
    
    public init(items: [PreviewItem] = [], currentPreviewItemIndex: Int = 0, transitionView: UIView? = nil) {
        self.items = items
        self.currentPreviewItemIndex = currentPreviewItemIndex
        self.transitionView = transitionView
    }
    
    private var _self: PreviewController?
    
    @MainActor
    public func present(from viewController: UIViewController) {
        _self = self
        let previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.currentPreviewItemIndex = currentPreviewItemIndex
        previewController.delegate = self
        viewController.present(previewController, animated: true)
    }
}

// MARK: - QLPreviewControllerDataSource

extension PreviewController: QLPreviewControllerDataSource {
    public func numberOfPreviewItems(in: QLPreviewController) -> Int {
        return items.count
    }
    
    public func previewController(_: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return items[index]
    }
}

// MARK: - QLPreviewControllerDelegate

extension PreviewController: QLPreviewControllerDelegate {
    @available(iOS 13.0, *)
    public func previewController(_: QLPreviewController, editingModeFor: QLPreviewItem) -> QLPreviewItemEditingMode {
        return .disabled
    }
    
    public func previewController(_: QLPreviewController, transitionViewFor: QLPreviewItem) -> UIView? {
        return transitionView
    }
    
    public func previewControllerDidDismiss(_: QLPreviewController) {
        _self = nil
    }
}
