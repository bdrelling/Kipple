import XCTest

final class NSNumberExtensionTests: XCTestCase {
    func testIsBooleanForFalse() {
        // Given
        let number = NSNumber(value: false)
        
        // When
        let isBoolean = number.isBoolean
        
        // Then
        XCTAssertTrue(isBoolean)
    }
    
    func testIsBooleanForTrue() {
        // Given
        let number = NSNumber(value: true)
        
        // When
        let isBoolean = number.isBoolean
        
        // Then
        XCTAssertTrue(isBoolean)
    }
    
    func testIsBooleanForZero() {
        // Given
        let number = NSNumber(value: 0)
        
        // When
        let isBoolean = number.isBoolean
        
        // Then
        XCTAssertFalse(isBoolean)
    }
    
    func testIsBooleanForNonBooleanValue() {
        // Given
        let number = NSNumber(value: 42)
        
        // When
        let isBoolean = number.isBoolean
        
        // Then
        XCTAssertFalse(isBoolean)
    }
}
