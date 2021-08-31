//
//  PopularMovieCollectionViewCell.swift
//  movieApp
//
//  Created by Temitope on 31/08/2021.
//

import UIKit

class PopularMovieCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: PopularMovieCollectionViewCell.self)
    
    @IBOutlet weak var image: UIImageView!
    
    func setup(data: Movie){
        ImageCacheManager.fetchImageData(from: "\(NetworkConstants.posterPath.rawValue)\(data.backdropPath ?? "")") { (data) -> (Void) in
            DispatchQueue.main.async {
                self.image.image = UIImage(data: data as Data)
            }
        }
        
    }
    
}
