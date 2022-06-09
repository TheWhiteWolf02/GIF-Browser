//
//  DetailsViewModel.swift
//  MobimeoTask
//
//  Created by Shifat Ur Rahman on 08.06.22.
//

import Foundation

class DetailsViewModel {
    var gifDetails: GifInfo?
    private var GifID: String
    private var apiClient: giphyAPIProtocol
    
    init(id: String, apiClient: giphyAPIProtocol = GiphyAPI()) {
        GifID = id
        self.apiClient = apiClient
    }
    
    func requestGifDetails(completion: @escaping (GifInfo?) -> Void) {
        apiClient.requestGifDetails(id: GifID) { result in
            self.gifDetails = result
            completion(result)
        }
    }
}
