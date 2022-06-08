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
    
    private func backend(gifID: String? = nil) -> String {
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
        let urlString = backend()+"?api_key=\(Constants.devKey)&limit=25&rating=pg&offset=\(String(offset))"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, resp, err in
            if err == nil, let data = data {
                let result: GifCollectionModel? = self.parse(json: data)
                completion(result?.data)
            } else{
                debugPrint(err ?? "")
            }
        }.resume()
    }
    
    func requestGifDetails(id: String, completion: @escaping (GifInfo?) -> Void) {
        let urlString = backend(gifID: id)+"?api_key=\(Constants.devKey)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, resp, err in
            if err == nil, let data = data {
                let result: GifDetailModel? = self.parse(json: data)
                completion(result?.data)
            } else{
                debugPrint(err ?? "")
            }
        }.resume()
    }
}
