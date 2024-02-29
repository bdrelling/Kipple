import XCTest

final class Int64ClampedTests: XCTestCase {
    func testClampedInt32WithinRange() {
        // Given
        let int64Value: Int64 = 42
        
        // When
        let int32Value = int64Value.clampedInt32()
        
        // Then
        XCTAssertEqual(int32Value, 42)
    }
    
    func testClampedInt32ExceedsRange() {
        // Given
        let int64Value: Int64 = Int64(Int32.max) + 1
        
        // When
        let int32Value = int64Value.clampedInt32()
        
        // Then
        XCTAssertEqual(int32Value, Int32.max)
    }
}
