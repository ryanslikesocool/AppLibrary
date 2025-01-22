import SwiftUI

protocol CreditItemView: View {
	associatedtype Value: CreditItem where Value.ItemView == Self

	nonisolated init(_ value: Value)
}