//
//  DetailsViewController.swift
//  movieApp
//
//  Created by Temitope on 01/09/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var bigImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var smallImage: UIImageView!
    
    var movie : Movie?
    var favouriteMovies: [Movie]? {
        return MoviePersisterManager.shared.load()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(data: movie!)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: false)
    }
    
    private func setupFavouriteButton() {
        guard let favouriteMovies = favouriteMovies else { return }
        if favouriteMovies.contains(where: { (data) -> Bool in
            guard let movie = movie else {return false}
            return data.id == movie.id
        }) {
            view.backgroundColor = UIColor.black
        }else {
            view.backgroundColor = UIColor.black
        }
    }
    
    func setup(data: Movie) {
        ImageCacheManager.fetchImageData(from: "\(NetworkConstants.posterPath.rawValue)\(data.backdropPath ?? "")") { (data) -> (Void) in
            DispatchQueue.main.async {
                self.bigImage.image = UIImage(data: data as Data)
            }
        }
        ImageCacheManager.fetchImageData(from: "\(NetworkConstants.posterPath.rawValue)\(data.posterPath ?? "")") { (data) -> (Void) in
            DispatchQueue.main.async {
                self.smallImage.image = UIImage(data: data as Data)
            }
        }
        date.text = data.releaseDate
        movieName.text = data.originalTitle
        summary.text = data.overview

    }

    @IBAction func saveBtn(_ sender: UIButton) {
        guard let movie = movie else { return }
        guard let favouriteMovies = favouriteMovies else { return }
        if favouriteMovies.contains(where: { (data) -> Bool in
            return data.id == movie.id
        }) {
            MoviePersisterManager.shared.remove(movie: movie)
        }else {
            MoviePersisterManager.shared.save(movie: movie)
        }

        
        setupFavouriteButton()
    }
   
}
