import Foundation
import LocalizationTable
import SwiftUI

public protocol LocalizationKeyProtocol: ExpressibleByStringLiteral, ExpressibleByStringInterpolation where
	StringLiteralType == String,
	StringInterpolation: LocalizationKeyStringInterpolationProtocol
{ }

// MARK: - Default Implementation

extension String.LocalizationValue: LocalizationKeyProtocol { }
extension LocalizedStringKey: LocalizationKeyProtocol { }

// MARK: - Constants

public extension LocalizationKeyProtocol {
	static var accessibilityRequest: LocalizationKey<Self>.AccessibilityRequest.Type { LocalizationKey<Self>.AccessibilityRequest.self }
	static var acknowledgements: LocalizationKey<Self>.Acknowledgements.Type { LocalizationKey<Self>.Acknowledgements.self }
	static var additionalApplicationGroups: LocalizationKey<Self>.AdditionalApplicationGroups.Type { LocalizationKey<Self>.AdditionalApplicationGroups.self }
	static var appearancePicker: LocalizationKey<Self>.AppearancePicker.Type { LocalizationKey<Self>.AppearancePicker.self }
	static var applicationGroupCriteriaPicker: LocalizationKey<Self>.ApplicationGroupCriteriaPicker.Type { LocalizationKey<Self>.ApplicationGroupCriteriaPicker.self }
	static var applicationHideFlagsList: LocalizationKey<Self>.ApplicationHideFlagsList.Type { LocalizationKey<Self>.ApplicationHideFlagsList.self }
	static var applicationSearchScopesList: LocalizationKey<Self>.ApplicationSearchScopesList.Type { LocalizationKey<Self>.ApplicationSearchScopesList.self }
	static var browserError: LocalizationKey<Self>.BrowserError.Type { LocalizationKey<Self>.BrowserError.self }
	static var common: LocalizationKey<Self>.Common.Type { LocalizationKey<Self>.Common.self }
	static var libraryLayoutPicker: LocalizationKey<Self>.LibraryLayoutPicker.Type { LocalizationKey<Self>.LibraryLayoutPicker.self }
	static var settingsWindow: LocalizationKey<Self>.SettingsWindow.Type { LocalizationKey<Self>.SettingsWindow.self }
}
