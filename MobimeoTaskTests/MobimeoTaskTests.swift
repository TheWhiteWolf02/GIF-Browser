//
//  MobimeoTaskTests.swift
//  MobimeoTaskTests
//
//  Created by Shifat Ur Rahman on 08.06.22.
//

import XCTest
@testable import MobimeoTask

class MobimeoTaskTests: XCTestCase {
    var mainViewModel: MainViewModel?
    var detailsViewModel: DetailsViewModel?
    var giphyClient: giphyAPIProtocol?

    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        giphyClient = GiphyAPI(session: urlSession)
        
        mainViewModel = MainViewModel(apiClient: giphyClient!)
        detailsViewModel = DetailsViewModel(id: Constants.sampleGifData.id, apiClient: giphyClient!)
    }

    override func tearDown() {
        mainViewModel = nil
        detailsViewModel = nil
        giphyClient = nil
    }

    func testRequestTrendingGifsSuccess() throws {
        let sampleGifDataArray: GifCollectionModel = GifCollectionModel(data: [Constants.sampleGifData])
        let mockData = try! JSONEncoder().encode(sampleGifDataArray)
                
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        let expectation = XCTestExpectation(description: "response")
        mainViewModel?.requestTrendingGifs(completion: { results in
            XCTAssertEqual(results?[0].id, Constants.sampleGifData.id)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRequestTrendingGifsFailure() throws {
        let sampleGifDataArrayNil: GifCollectionModel? = nil
        let mockData = try! JSONEncoder().encode(sampleGifDataArrayNil)
                
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        let expectation = XCTestExpectation(description: "response")
        mainViewModel?.requestTrendingGifs(completion: { results in
            XCTAssertNil(results)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }

    func testRequestGifDetailsSuccess() throws {
        let sampleGifData: GifDetailModel = GifDetailModel(data: Constants.sampleGifData)
        let mockData = try! JSONEncoder().encode(sampleGifData)
                
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        let expectation = XCTestExpectation(description: "response")
        detailsViewModel?.requestGifDetails(completion: { result in
            XCTAssertEqual(result?.id, Constants.sampleGifData.id)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRequestGifDetailsFailure() throws {
        let sampleGifDataNil: GifDetailModel? = nil
        let mockData = try! JSONEncoder().encode(sampleGifDataNil)
                
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        let expectation = XCTestExpectation(description: "response")
        detailsViewModel?.requestGifDetails(completion: { result in
            XCTAssertNil(result)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }
}
