//
//  ViewController.swift
//  MobimeoTask
//
//  Created by Shifat Ur Rahman on 08.06.22.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet private weak var gifCollectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gifCollectionView.dataSource = self
        gifCollectionView.delegate = self
        gifCollectionView.register(UINib(nibName: "GifCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GifCollectionViewCell")
        
        activityIndicator.startAnimating()
        viewModel.requestTrendingGifs() {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.gifCollectionView.reloadData()
            }
        }
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.gifArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCollectionViewCell", for: indexPath) as! GifCollectionViewCell
        cell.setData(gifInfo: viewModel.gifArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewModel: DetailsViewModel = DetailsViewModel(id: viewModel.gifArray[indexPath.row].id)
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailsViewController", creator: { coder in
            DetailsViewController(coder: coder, detailsViewModel: detailsViewModel)
        })
        navigationController?.fadeTo(viewController)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.gifArray.count - 1 {
            viewModel.requestTrendingGifs() {
                DispatchQueue.main.async {
                    self.gifCollectionView.reloadData()
                }
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70.0, height: 70.0)
    }
}
