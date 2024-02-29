import KippleCore
import XCTest

final class ModuloTests: XCTestCase {
    func testModuloPositiveNumbers() {
        // Given
        let dividend: Int = 10
        let divisor: Int = 3
        let expectedRemainder: Int = 1
        
        // When
        let result = modulo(dividend, divisor)
        
        // Then
        XCTAssertEqual(result, expectedRemainder)
    }
    
    func testModuloNegativeNumbers() {
        // Given
        let dividend: Int = -10
        let divisor: Int = 3
        let expectedRemainder: Int = 2
        
        // When
        let result = modulo(dividend, divisor)
        
        // Then
        XCTAssertEqual(result, expectedRemainder)
    }
    
    func testModuloZeroDivisor() {
        // Given
        let dividend: Int = 10
        let divisor: Int = 0
        let expectedRemainder: Int = 0 // Not defined, should return 0
        
        // When
        let result = modulo(dividend, divisor)
        
        // Then
        XCTAssertEqual(result, expectedRemainder)
    }
}
