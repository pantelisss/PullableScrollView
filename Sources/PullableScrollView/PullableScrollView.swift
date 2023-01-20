import SwiftUI

/// Usage (use it as a ScrollView):
///
/// Once the refresh is completed, invoke the passed `VoidCallback` in order to hide the refresh indicator
/// ```
/// PullableScrollView(tintColor: nil) { completion in
///     Fetch data...
///     ...
///     ...
///     completion()
/// } content: {
///     `content`
/// }
/// ```
public struct PullableScrollView<Content: View>: View {
    
    public typealias VoidCallback = () -> Void
    public typealias RefreshCallback = (@escaping VoidCallback) -> Void
    
    private let tintColor: Color?
    private let showsVerticalScrollIndicator: Bool
    private let content: Content
    private let refreshCallback: RefreshCallback
    
    public init(tintColor: Color?, showsVerticalScrollIndicator: Bool = false, refreshCallback: @escaping RefreshCallback, @ViewBuilder content: () -> Content) {
        self.tintColor = tintColor
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        self.content = content()
        self.refreshCallback = refreshCallback
    }
    
    public var body: some View {
        List {
            content
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
        }
        .listStyle(.plain)
        .listSectionSeparator(.hidden)
        .applyModifications { view in
            if #available(iOS 16.0, *) {
                view.scrollIndicators(showsVerticalScrollIndicator ? .automatic : .hidden)
            } else {
                view
            }
        }
        .refreshable {
            await refresh()
        }
        .onAppear {
            if let tintColor = tintColor {
                UIRefreshControl.appearance().tintColor = UIColor(tintColor)
            }
            
            UITableView.appearance().showsVerticalScrollIndicator = showsVerticalScrollIndicator
        }
    }
}

private extension PullableScrollView {
    
    /// Pull to refresh through this async method
    /// in order to achieve a smoother transition on refreshing
    func refresh() async {
        await withCheckedContinuation { continuation in
            DispatchQueue.main.async {
                refreshCallback {
                    continuation.resume()
                }
            }
        }
    }
}

private extension View {

    /// A way to apply conditional modifiers in view
    /// - Parameter transform: Apply the needed modifiers
    /// - Returns: The modified view
    @ViewBuilder func applyModifications<Content: View>(@ViewBuilder transform: (Self) -> Content) -> some View  {
            transform(self)
    }

}
