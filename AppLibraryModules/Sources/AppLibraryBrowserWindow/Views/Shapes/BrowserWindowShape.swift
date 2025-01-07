import SwiftUI

struct BrowserWindowShape {
	private let cornerRadius: CGFloat

	fileprivate init(cornerRadius: CGFloat) {
		self.cornerRadius = cornerRadius
	}

	public init() {
		self.init(cornerRadius: Self.cornerRadius)
	}
}

// MARK: - Sendable

extension BrowserWindowShape: Sendable { }

// MARK: - Shape

extension BrowserWindowShape: Shape {
	public func path(in rect: CGRect) -> Path {
		RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
			.path(in: rect)
	}
}

// MARK: - InsettableShape

extension BrowserWindowShape: InsettableShape {
	public func inset(by amount: CGFloat) -> Self {
		BrowserWindowShape(cornerRadius: cornerRadius - amount)
	}
}

// MARK: - Constants

extension BrowserWindowShape {
//	public static let cornerRadius: CGFloat = 16
	public static let cornerRadius: CGFloat = 10
}
