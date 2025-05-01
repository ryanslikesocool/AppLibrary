import SwiftUI

public protocol CustomLabelConvertible {
	associatedtype LabelTitle: View
	associatedtype LabelIcon: View

	var label: Label<LabelTitle, LabelIcon> { get }
}