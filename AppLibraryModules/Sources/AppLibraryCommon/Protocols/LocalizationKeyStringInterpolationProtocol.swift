import Foundation
import SwiftUI

public protocol LocalizationKeyStringInterpolationProtocol: StringInterpolationProtocol {
	mutating func appendInterpolation(_ string: String)

	// String.LocalizationValue
//	mutating func appendInterpolation<Subject>(_ subject: Subject) where Subject : NSObject

	// LocalizedStringKey
//	mutating func appendInterpolation<Subject>(_ subject: Subject, formatter: Formatter?) where Subject : NSObject

	mutating func appendInterpolation<F>(_ input: F.FormatInput, format: F) where F : FormatStyle, F.FormatInput : Equatable, F.FormatOutput == String
}

// MARK: - Default Implementation

extension String.LocalizationValue.StringInterpolation: LocalizationKeyStringInterpolationProtocol { }
extension LocalizedStringKey.StringInterpolation: LocalizationKeyStringInterpolationProtocol { }
