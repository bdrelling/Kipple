import KippleFoundation
import XCTest

final class URLConvertibleTests: XCTestCase {
    func testURLConvertibleWithValidURLString() {
        // Given
        let urlString = "https://www.example.com"
        
        do {
            // When
            let url = try urlString.asURL()
            
            // Then
            XCTAssertEqual(url.absoluteString, urlString)
        } catch {
            XCTFail("Failed to convert valid URL string to URL: \(error)")
        }
    }
    
    /// Tests that attempting to convert an empty string `""` successfully throws an error.
    func testURLConvertibleWithWhitespacedURLString() throws {
        #if swift(<5.9)
        throw XCTSkip("This test does not run in versions below Swift 5.9.")
        #else
        // Given
        let whitespacedURLString = "not a valid url"
        
        do {
            // When
            let url = try whitespacedURLString.asURL()
            
            // Then
            XCTAssertEqual(url.absoluteString.removingPercentEncoding, whitespacedURLString)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        #endif
    }
    
    /// Tests that attempting to convert an empty string `""` successfully throws an error.
    func testURLConvertibleWithEmptyURLString() {
        // Given
        let emptyURLString = ""
        
        XCTAssertThrowsError(try emptyURLString.asURL(), "As of Swift 5.9, empty URL strings throw errors, but this may have changed.")
    }
    
    func testURLConvertibleWithURLInstance() {
        // Given
        let url = URL(string: "https://www.example.com")!
        
        do {
            // When
            let convertedURL = try url.asURL()
            
            // Then
            XCTAssertEqual(convertedURL, url)
        } catch {
            XCTFail("Failed to convert URL instance to URL: \(error)")
        }
    }
}
