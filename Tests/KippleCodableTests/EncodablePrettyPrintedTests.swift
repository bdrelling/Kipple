import KippleCodable
import XCTest

final class EncodablePrettyPrintedTests: XCTestCase {
    let encoder = JSONEncoder()

    func testPrettyPrintingEncodableSucceeds() throws {
        // Given
        let person = Person(name: "Alice", age: 30)

        // When
        let prettyPrintedString = try person.prettyPrinted()
        print(prettyPrintedString)

        // Then
        XCTAssertEqual(prettyPrintedString, """
        {
          "age" : 30,
          "name" : "Alice"
        }
        """)
    }
    
    func testPrettyPrintingStringSucceeds() throws {
        // Given
        let prettyPrintedString = try "Alice".prettyPrinted()

        // Then
        XCTAssertEqual(prettyPrintedString, "\"Alice\"")
    }
}

// MARK: - Supporting Types

private struct Person: Codable {
    let name: String
    let age: Int
}

