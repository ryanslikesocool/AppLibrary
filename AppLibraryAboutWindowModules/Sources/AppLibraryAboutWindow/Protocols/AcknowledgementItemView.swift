import SwiftUI

protocol AcknowledgementItemView: View {
	associatedtype Value: Acknowledgement

	init(_ value: Value)
}