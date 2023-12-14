import QuickLook

public final class PreviewController: NSObject {
    public var items: [PreviewItem]
    
    public weak var transitionView: UIView?
    
    public init(items: [PreviewItem] = [], transitionView: UIView? = nil) {
        self.items = items
        self.transitionView = transitionView
    }
    
    private var _self: PreviewController?
    
    @MainActor
    public func present(from viewController: UIViewController, currentPreviewItemIndex: Int? = nil) {
        _self = self
        let previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.delegate = self
        if let currentPreviewItemIndex {
            previewController.currentPreviewItemIndex = currentPreviewItemIndex
        }
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
    public func previewController(_: QLPreviewController, transitionViewFor: QLPreviewItem) -> UIView? {
        return transitionView
    }
    
    public func previewControllerDidDismiss(_: QLPreviewController) {
        _self = nil
    }
    
    @available(iOS 13.0, *)
    public func previewController(_: QLPreviewController, editingModeFor: QLPreviewItem) -> QLPreviewItemEditingMode {
        return .disabled
    }
}
