import BundleToolbox
import Foundation

public extension XCConfiguration {
	static func url(forKey key: AppLibraryCommon.ConfigurationURLKey) throws -> URL {
		guard let result = try self[ConfigurationURLKey()][key] else {
			throw InfoDictionaryError.missingValue(forKey: key.rawValue)
		}
		return result
	}

	private struct ConfigurationURLKey: XCConfigurationKey {
		public typealias Output = [AppLibraryCommon.ConfigurationURLKey: URL]

		public static let infoDictionaryKey: String = "ConfigurationURL"

		fileprivate init() { }

		public func process(_ input: Input) throws -> Output {
			guard let infoDictionaryValue = input.object(forInfoDictionaryKey: Self.infoDictionaryKey) else {
				throw InfoDictionaryError.missingValue(forKey: Self.infoDictionaryKey)
			}
			guard let dictionaryValue = infoDictionaryValue as? [Output.Key.RawValue: String] else {
				throw InfoDictionaryError.castFailed(from: infoDictionaryValue, to: [Output.Key.RawValue: String].self)
			}

			let resultValue = try dictionaryValue.reduce(into: Output()) { partialResult, element in
				guard let key = Output.Key(rawValue: element.key) else {
					throw InfoDictionaryError.conversionFailed(from: Output.Key.RawValue.self, to: Output.Key.self)
				}
				guard let value = Output.Value(string: element.value) else {
					throw InfoDictionaryError.conversionFailed(from: String.self, to: Output.Value.self)
				}

				partialResult[key] = value
			}

			return resultValue
		}
	}
}
