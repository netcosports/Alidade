import Foundation

#if DEBUG
let isDebug = true
#else
let isDebug = false
#endif

@available(*, message: "Debug value")
public func value<T>(debug: T, release: T) -> T { return isDebug ? debug : release }
