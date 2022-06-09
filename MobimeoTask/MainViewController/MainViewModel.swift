//
//  MainViewModel.swift
//  MobimeoTask
//
//  Created by Shifat Ur Rahman on 08.06.22.
//

import Foundation

class MainViewModel {
    var gifArray: [GifInfo] = []
    private var pageNo: Int = 0
    private let offsetIncrement: Int = 25
    
    private var apiClient: giphyAPIProtocol
    
    init(apiClient: giphyAPIProtocol = GiphyAPI()) {
        self.apiClient = apiClient
    }
    
    func requestTrendingGifs(completion: @escaping ([GifInfo]?) -> Void) {
        apiClient.requestTrendingGifs(offset: pageNo * offsetIncrement) { results in
            if let results = results {
                self.gifArray.append(contentsOf: results)
                self.pageNo += 1
            }
            completion(results)
        }
    }
}
