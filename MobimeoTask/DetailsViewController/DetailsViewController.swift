//
//  DetailsViewController.swift
//  MobimeoTask
//
//  Created by Shifat Ur Rahman on 08.06.22.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet private weak var gifContainerView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var gifImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    private let viewModel: DetailsViewModel
    
    init?(coder: NSCoder, detailsViewModel: DetailsViewModel) {
        viewModel = detailsViewModel
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        viewModel.requestGifDetails() { result in
            DispatchQueue.main.async {
                self.updateInfo(gifResult: result)
            }
        }
    }
    
    private func updateInfo(gifResult: GifInfo?) {
        let url = URL(string: gifResult?.images.downsized.url ?? "")
        self.gifImageView.kf.setImage(with: url, completionHandler: { _ in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        })
        titleLabel.text = "Title: \(gifResult?.title ?? "")"
        sourceLabel.text = "Source: \(gifResult?.source ?? "")"
        ratingLabel.text = "Rating: \(gifResult?.rating ?? "")"
    }
}
