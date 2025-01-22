//import SwiftUI
//
//public extension ForEach where
//	Data == Range<Int>,
//	ID == Int,
//	Content: View
//{
//	/// Creates an instance that computes views on demand over a given constant
//	/// range.
//	///
//	/// The instance only reads the initial value of the provided `data` and
//	/// doesn't need to identify views across updates. To compute views on
//	/// demand over a dynamic range, use ``ForEach/init(_:id:content:)``.
//	///
//	/// - Parameters:
//	///   - data: A constant range.
//	///   - content: The view builder that creates views dynamically.
//	@_semantics("swiftui.requires_constant_range")
//	init(
//		_ data: ClosedRange<Int>,
//		@ViewBuilder content: @escaping (Int) -> Content
//	) {
//		self.init(data.lowerBound ..< data.upperBound, content: content)
//	}
//}
