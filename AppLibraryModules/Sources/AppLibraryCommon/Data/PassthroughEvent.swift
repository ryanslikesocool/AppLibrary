import Combine

/// - Remark: This object is a typealias to `PassthroughSubject<(repeat each Output), Never>`.
public typealias PassthroughEvent<each Output> = PassthroughSubject<(repeat each Output), Never>
