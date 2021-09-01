//
//  PeopleCollectionViewCell.swift
//  movieApp
//
//  Created by Temitope on 01/09/2021.
//

import UIKit

class PeopleCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: PeopleCollectionViewCell.self)
    
    @IBOutlet weak var image: UIImageView!
    
    func set(data: Results){
        ImageCacheManager.fetchImageData(from: "\(NetworkConstants.posterPath.rawValue)\(data.profilePath ?? "")") { (data) -> (Void) in
            DispatchQueue.main.async {
                self.image.image = UIImage(data: data as Data)
            }
        }
        
    }
}
