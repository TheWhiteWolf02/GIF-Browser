//
//  GifInfo.swift
//  MobimeoTask
//
//  Created by Shifat Ur Rahman on 08.06.22.
//

import Foundation

struct GifCollectionModel: Codable {
    var data: [GifInfo]
}

struct GifDetailModel: Codable {
    var data: GifInfo
}

struct GifInfo: Codable {
    var id: String
    var source: String
    var title: String
    var rating: String
    var images: Images
    
    struct Images: Codable {
        var downsized: Downsized
        
        struct Downsized: Codable {
            var width: String
            var height: String
            var url: String
        }
    }
}
