import KippleCollections
import XCTest

final class InterleavableDictionaryTests: XCTestCase {
    func testDictionary() {
        // Given
        let dictionary: [String: [Int]] = ["a": [1, 2, 3], "b": [4, 5, 6], "c": [7, 8, 9]]
        
        print(dictionary.interleaved())
        // Then
        self.validateDictionary(dictionary)
    }
    
    func testOrderedDictionary() {
        // Given
        let dictionary: OrderedDictionary<String, [Int]> = ["a": [1, 2, 3], "b": [4, 5, 6], "c": [7, 8, 9]]
        
        print(dictionary.interleaved())
        
        // Then
        self.validateDictionary(dictionary)
    }
    
    private func validateDictionary<D>(_ dictionary: D) where D: InterleavableDictionary, D.Key == String, D.Value == [Int] {
        // When
        let interleaved = dictionary.interleaved()
        
        // Then
        let expectedInterleaved: [(String, Int)] = [
            ("a", 1), ("a", 2), ("a", 3),
            ("b", 4), ("b", 5), ("b", 6),
            ("c", 7), ("c", 8), ("c", 9)
        ]
        
        XCTAssertEqual(interleaved.count, expectedInterleaved.count)
        
        for (actual, expected) in zip(interleaved, expectedInterleaved) {
            XCTAssertEqual(actual.0, expected.0)
            XCTAssertEqual(actual.1, expected.1)
        }
    }
}
