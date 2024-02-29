import KippleCore
import XCTest

final class ResultExtensionTests: XCTestCase {
    enum TestError: Error {
        case test
    }
    
    func testSuccessProperty() {
        // Given
        let expectedResult: Int = 42
        let result: Result<Int, Error> = .success(expectedResult)
        
        // When
        let successValue = result.success
        
        // Then
        XCTAssertEqual(successValue, expectedResult)
    }
    
    func testFailureProperty() {
        // Given
        let expectedError = TestError.test
        let result: Result<Int, Error> = .failure(expectedError)
        
        // When
        let failureValue = result.failure
        
        // Then
        XCTAssertEqual(failureValue as? TestError, expectedError)
    }
    
    func testSuccessPropertyWithFailure() {
        // Given
        let result: Result<Int, Error> = .failure(TestError.test)
        
        // When
        let successValue = result.success
        
        // Then
        XCTAssertNil(successValue)
    }
    
    func testFailurePropertyWithSuccess() {
        // Given
        let result: Result<Int, Error> = .success(42)
        
        // When
        let failureValue = result.failure
        
        // Then
        XCTAssertNil(failureValue)
    }
}
