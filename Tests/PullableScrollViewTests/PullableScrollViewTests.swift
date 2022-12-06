import XCTest
import SwiftUI
@testable import PullableScrollView

final class PullableScrollViewTests: XCTestCase {

    func testUsage() {
        XCTAssertNoThrow(
            PullableScrollView(tintColor: .red,
                               refreshCallback: { callback in
                                   // Fetch some data and invoke `callBack` to hide the indicator
                                   DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                       callback()
                                   }
                               }, content: {
                                   Text("Scroll view content")
                               })
        )
    }
}
