import OSLog

enum FeatureFlag { }

// MARK: - Input

extension FeatureFlag {
	enum Input {
		static let implementation: InputImplementation
			= .native

		static let logEvents: Bool
			= true

		static func logEvent(
			in scope: Any.Type,
			named name: @autoclosure @escaping () -> String
		) {
			logEvent(in: String(describing: scope), named: name())
		}

		static func logEvent(
			in scope: @autoclosure @escaping () -> String,
			named name: @autoclosure @escaping () -> String
		) {
			guard FeatureFlag.Input.logEvents else {
				return
			}

			Logger.input.debug("\(scope()) received \"\(name())\" event")
		}
	}
}
