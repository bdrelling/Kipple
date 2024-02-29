
import Foundation
import KippleCodable
import XCTest

final class DecodingErrorCleanedTests: XCTestCase {
    func testTypeMismatch() throws {
        // Given
        let data = """
        {
            "name": 123
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do {
            // When
            let _ = try decoder.decode(Person.self, from: data)
            XCTFail("DecodingError should be thrown.")
        } catch let error as DecodingError {
            // Then
            XCTAssertEqual(error.cleanedDescription, "Type mismatch for key 'name'. Expected type 'String'.")
        }
    }
    
    func testTypeMismatchForNestedType() throws {
        // Given
        let data = """
        {
            "name": "Alice",
            "pets": [
                "dog",
            ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do {
            // When
            let _ = try decoder.decode(Person.self, from: data)
            XCTFail("DecodingError should be thrown.")
        } catch let error as DecodingError {
            // Then
            XCTAssertEqual(error.cleanedDescription, "Type mismatch for key 'pets[0]'. Expected type 'Dictionary<String, Any>'.")
        }
    }
    
    func testKeyNotFound() throws {
        // Given
        let data = """
        {
            "age": "29"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do {
            // When
            let _ = try decoder.decode(Person.self, from: data)
            XCTFail("DecodingError should be thrown.")
        } catch let error as DecodingError {
            // Then
            XCTAssertEqual(error.cleanedDescription, "Key 'name' not found.")
        }
    }
    
    func testKeyNotFoundForNestedType() throws {
        // Given
        let data = """
        {
            "name": "Alice",
            "pets": [
                {},
            ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do {
            // When
            let _ = try decoder.decode(Person.self, from: data)
            XCTFail("DecodingError should be thrown.")
        } catch let error as DecodingError {
            // Then
            XCTAssertEqual(error.cleanedDescription, "Key 'pets[0].legs' not found.")
        }
    }
    
    func testDataCorruptedEmpty() throws {
        // Given
        let data = """
        {
            "name":
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do {
            // When
            let _ = try decoder.decode(Person.self, from: data)
            XCTFail("DecodingError should be thrown.")
        } catch let error as DecodingError {
            // Then
            XCTAssertEqual(error.cleanedDescription, "Data corrupted.")
        }
    }
}

// MARK: - Supporting Types

private struct Person: Codable {
    let name: String
    let pets: [Animal]
}

private struct Animal: Codable {
    let legs: Int
}
