//
//  BlockDemoTests.swift
//  BlockDemoTests
//
//  Created by DJ A on 3/20/23.
//

import XCTest
@testable import BlockDemo

final class BlockDemoTests: XCTestCase {
    
    class MockNetworkService: NetworkProtocol {
        var response = [Employee]()
        var error: NetworkError?
        
        func fetchEmployees() async throws -> [BlockDemo.Employee] {
            if let error {
                throw error
            } else {
                return response
            }
        }
    }
    
    private var networkServiceMock: MockNetworkService?
    
    private var sampleEmployees = [
        Employee(id: "1", name: "John", phoneNumber: "8435555555", email: "john@gmail.com", biography: "John is a neat guy", photoURLSmall: URL(string: "https://picsum.photos/200"), photoURLLarge: URL(string: "https://picsum.photos/200"), team: "Point of Sale", employeeType: .fullTime)
    ]
    private var sampleEmployeesEmpty = [Employee]()
    
    private func XCTAssertThrowsErrorAsync<T, R>(
        _ expression: @autoclosure () async throws -> T,
        _ errorThrown: @autoclosure () -> R,
        _ message: @autoclosure () -> String = "This method should fail",
        file: StaticString = #filePath,
        line: UInt = #line
    ) async where R: Comparable, R: Error  {
        do {
            let _ = try await expression()
            XCTFail(message(), file: file, line: line)
        } catch {
            XCTAssertEqual(error as? R, errorThrown())
        }
    }

    override func setUpWithError() throws {
        networkServiceMock = MockNetworkService()
    }

    override func tearDownWithError() throws {
        networkServiceMock = nil
    }

    func testFetchEmployeesSuccess() async throws {
        guard let networkServiceMock else { return }
        networkServiceMock.response = sampleEmployees
        let returnedEmployees = try await networkServiceMock.fetchEmployees()
        XCTAssertEqual(sampleEmployees, returnedEmployees)
        XCTAssertNil(networkServiceMock.error)
    }
    
    func testFetchEmployeesEmptyData() async throws {
        guard let networkServiceMock else { return }
        networkServiceMock.response = sampleEmployeesEmpty
        let returnedEmployees = try await networkServiceMock.fetchEmployees()
        XCTAssert(returnedEmployees.isEmpty)
        XCTAssertNil(networkServiceMock.error)
    }
    
    func testFetchEmployeesServerError() async throws {
        guard let networkServiceMock else { return }
        networkServiceMock.error = NetworkError.serverError
        await XCTAssertThrowsErrorAsync(try await networkServiceMock.fetchEmployees(), NetworkError.serverError)
    }
    
    func testFetchEmployeesUnknownError() async throws {
        guard let networkServiceMock else { return }
        networkServiceMock.error = NetworkError.unknown
        await XCTAssertThrowsErrorAsync(try await networkServiceMock.fetchEmployees(), NetworkError.unknown)
    }
    
    func testFetchEmployeesBadRequestError() async throws {
        guard let networkServiceMock else { return }
        networkServiceMock.error = NetworkError.badRequest
        await XCTAssertThrowsErrorAsync(try await networkServiceMock.fetchEmployees(), NetworkError.badRequest)
    }
}
