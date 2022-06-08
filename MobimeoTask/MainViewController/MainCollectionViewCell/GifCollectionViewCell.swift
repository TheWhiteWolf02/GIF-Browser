//
//  MainCollectionViewCell.swift
//  MobimeoTask
//
//  Created by Shifat Ur Rahman on 08.06.22.
//

import UIKit
import Kingfisher

class GifCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var gifView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(gifInfo: GifInfo) {
        let url = URL(string: gifInfo.images.downsized.url)
        gifView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
    }
}
