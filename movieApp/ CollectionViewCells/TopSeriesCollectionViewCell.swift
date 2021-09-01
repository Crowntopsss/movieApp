//
//  TopSeriesCollectionViewCell.swift
//  movieApp
//
//  Created by Temitope on 01/09/2021.
//

import UIKit

class TopSeriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    static let identifier = String(describing: TopSeriesCollectionViewCell.self)
    
    func setup(data: Movie){
        ImageCacheManager.fetchImageData(from: "\(NetworkConstants.posterPath.rawValue)\(data.posterPath ?? "")") { (data) -> (Void) in
            DispatchQueue.main.async {
                self.image.image = UIImage(data: data as Data)
            }
        }
        
    }
    


}
