import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(HMDABackblazeB2Tests.allTests),
    ]
}
#endif
