//
//  giphyAPI.swift
//  MobimeoTask
//
//  Created by Shifat Ur Rahman on 08.06.22.
//

import Foundation

protocol giphyAPIProtocol {
    func requestTrendingGifs(offset: Int, completion: @escaping ([GifInfo]?) -> Void)
    func requestGifDetails(id: String, completion: @escaping (GifInfo?) -> Void)
}

class GiphyAPI: giphyAPIProtocol {
    private let baseURL: String = "https://api.giphy.com/v1/gifs/"
    private let trending: String = "trending"
    private let urlSession: URLSession
    
    init(session: URLSession = .shared) {
        urlSession = session
    }
    
    private func updateURL(gifID: String? = nil) -> String {
        guard let id = gifID else {
            return baseURL+trending
        }
        return baseURL+id
    }
    
    private func parse<T:Codable>(json: Data)->T? {
        let decoder = JSONDecoder()
        if let jsonModel = try? decoder.decode(T.self, from: json) {
            return jsonModel
        }
        return nil
    }
    
    func requestTrendingGifs(offset: Int, completion: @escaping ([GifInfo]?) -> Void) {
        let urlString = updateURL()+"?api_key=\(Constants.devKey)&limit=25&rating=pg&offset=\(String(offset))"
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        
        urlSession.dataTask(with: urlRequest) { data, resp, err in
            if err == nil, let data = data {
                let result: GifCollectionModel? = self.parse(json: data)
                completion(result?.data)
            }
        }.resume()
    }
    
    func requestGifDetails(id: String, completion: @escaping (GifInfo?) -> Void) {
        let urlString = updateURL(gifID: id)+"?api_key=\(Constants.devKey)"
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        
        urlSession.dataTask(with: urlRequest) { data, resp, err in
            if err == nil, let data = data {
                let result: GifDetailModel? = self.parse(json: data)
                completion(result?.data)
            }
        }.resume()
    }
}
