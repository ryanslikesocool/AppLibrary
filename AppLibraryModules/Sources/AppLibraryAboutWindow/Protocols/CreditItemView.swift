import SwiftUI

protocol CreditItemView: View {
	associatedtype Value: CreditProtocol

	init(_ value: Value)
}
