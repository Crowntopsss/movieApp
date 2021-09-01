//
//  NowPlayingCollectionViewCell.swift
//  movieApp
//
//  Created by Temitope on 01/09/2021.
//

import UIKit

class NowPlayingCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: NowPlayingCollectionViewCell.self)

    @IBOutlet weak var NowPlayImage: UIImageView!

    func setup(data: Movie){
        ImageCacheManager.fetchImageData(from: "\(NetworkConstants.posterPath.rawValue)\(data.posterPath ?? "")") { (data) -> (Void) in
            DispatchQueue.main.async {
                self.NowPlayImage.image = UIImage(data: data as Data)
            }
        }
        
    }
    
}
