#if canImport(OSLog)
import OSLog
#endif

@available(iOS 16, macCatalyst 16, macOS 13, tvOS 16, watchOS 9, *)
public struct Measure {
#if canImport(OSLog)
	public let logger: Logger
#endif
	public let timeFormatStyle: Duration.UnitsFormatStyle

#if canImport(OSLog)
	public init(
		logger: Logger? = nil,
		timeFormatStyle: Duration.UnitsFormatStyle? = nil
	) {
		self.logger = logger ?? Self.defaultLogger
		self.timeFormatStyle = timeFormatStyle ?? Self.defaultTimeFormatStyle
	}
#else
	public init(
		timeFormatStyle: Duration.UnitsFormatStyle? = nil
	) {
		self.timeFormatStyle = timeFormatStyle ?? Self.defaultTimeFormatStyle
	}
#endif
}

// MARK: - Sendable

@available(iOS 16, macCatalyst 16, macOS 13, tvOS 16, watchOS 9, *)
extension Measure: Sendable { }

// MARK: - Work

@available(iOS 16, macCatalyst 16, macOS 13, tvOS 16, watchOS 9, *)
public extension Measure {
	// MARK: Synchronous

	/// Measure a unit of work and log the time elapsed to the console.
	/// - Parameters:
	///   - label: A short description of the work being performed.
	///   - file: The name of the file where the work is performed.  This uses the [`#file`](https://developer.apple.com/documentation/swift/file()) macro by default.
	///   - line: The line number where the work is started.  This uses the [`#line`](https://developer.apple.com/documentation/swift/line()) macro by default.
	///   - work: The work to perform.
	borrowing func work(
		_ label: @autoclosure @escaping () -> String?,
		file: StaticString = #file, line: UInt = #line,
		work: () throws -> Void
	) rethrows {
		let clock = ContinuousClock()
		let duration = try clock.measure(work)
		log(label: label, duration: duration, file: file, line: line)
	}

	/// Measure a unit of work and log the time elapsed to the console.
	/// - Parameters:
	///   - label: A short description of the work being performed.
	///   - file: The name of the file where the work is performed.  This uses the [`#file`](https://developer.apple.com/documentation/swift/file()) macro by default.
	///   - line: The line number where the work is started.  This uses the [`#line`](https://developer.apple.com/documentation/swift/line()) macro by default.
	///   - work: The work to perform.
	borrowing func work<Result>(
		_ label: @autoclosure @escaping () -> String?,
		file: StaticString = #file, line: UInt = #line,
		work: () throws -> Result
	) rethrows -> Result! {
		let clock = ContinuousClock()
		var result: Result?
		let duration = try clock.measure {
			result = try work()
		}
		log(label: label, duration: duration, file: file, line: line)
		return result
	}

	// MARK: Asynchronous

	/// Measure a unit of asynchronous work and log the time elapsed to the console.
	/// - Parameters:
	///   - isolation:
	///   - label: A short description of the work being performed.
	///   - file: The name of the file where the work is performed.  This uses the [`#file`](https://developer.apple.com/documentation/swift/file()) macro by default.
	///   - line: The line number where the work is started.  This uses the [`#line`](https://developer.apple.com/documentation/swift/line()) macro by default.
	///   - work: The work to perform.
	borrowing func work(
		isolation: isolated (any Actor)? = #isolation,
		_ label: @autoclosure @escaping () -> String? = nil,
		file: StaticString = #file, line: UInt = #line,
		work: () async throws -> Void
	) async rethrows {
		let clock = ContinuousClock()
		let duration = try await clock.measure(isolation: isolation, work)
		log(label: label, duration: duration, file: file, line: line)
	}

	/// Measure a unit of asynchronous work and log the time elapsed to the console.
	/// - Parameters:
	///   - isolation:
	///   - label: A short description of the work being performed.
	///   - file: The name of the file where the work is performed.  This uses the [`#file`](https://developer.apple.com/documentation/swift/file()) macro by default.
	///   - line: The line number where the work is started.  This uses the [`#line`](https://developer.apple.com/documentation/swift/line()) macro by default.
	///   - work: The work to perform.
	borrowing func work<Result>(
		isolation: isolated (any Actor)? = #isolation,
		_ label: @autoclosure @escaping () -> String? = nil,
		file: StaticString = #file, line: UInt = #line,
		work: () async throws -> Result
	) async rethrows -> Result! {
		let clock = ContinuousClock()
		var result: Result?
		let duration = try await clock.measure(isolation: isolation) {
			result = try await work()
		}
		log(label: label, duration: duration, file: file, line: line)
		return result
	}
}

// MARK: - Log

@available(iOS 16, macCatalyst 16, macOS 13, tvOS 16, watchOS 9, *)
private extension Measure {
	func log(
		label: () -> String?,
		duration: Duration,
		file: StaticString, line: UInt
	) {
		let insertingLabel: String = if let label = label() {
			" \"\(label)\""
		} else {
			""
		}

#if canImport(OSLog)
		logger.debug("""
		Completed work\(insertingLabel):
		- Time Elapsed: \(duration.formatted(timeFormatStyle))
		- Location: \(file):\(line)
		""")
#else
		print("""
		Completed work\(insertingLabel):
		- Time Elapsed: \(duration.formatted(timeFormatStyle))
		- Location: \(file):\(line)
		""")
#endif
	}
}

// MARK: - Constants

@available(iOS 16, macCatalyst 16, macOS 13, tvOS 16, watchOS 9, *)
extension Measure {
	private static let defaultTimeFormatStyle: Duration.UnitsFormatStyle = Duration.UnitsFormatStyle(
		allowedUnits: [.seconds, .milliseconds],
		width: .abbreviated,
		fractionalPart: .show(length: 7)
	)

#if canImport(OSLog)
	private static let defaultLogger: Logger = Logger(
		subsystem: Bundle.main.bundleIdentifier!,
		category: String(describing: Self.self)
	)
#endif

	public static let `default`: Self = Self()
}
