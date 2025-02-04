import Combine

public typealias PassthroughEvent<each Output> = PassthroughSubject<(repeat each Output), Never>
