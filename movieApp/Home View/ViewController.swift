//
//  ViewController.swift
//  movieApp
//
//  Created by Temitope on 30/08/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var data = [Movie]()
    let viewModel = HomeViewModel()

    
    @IBOutlet weak var popularMovieCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        register()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        popularMovieCollection.collectionViewLayout = layout
        
        
        // Do any additional setup after loading the view.
    }
    
    func register() {
        popularMovieCollection.register(UINib(nibName: PopularMovieCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PopularMovieCollectionViewCell.identifier)
    }

    private func fetchData() {
        viewModel.getNowPlaying { (result) in
            switch result {
            case .success(let movies):
                guard let movies = movies else { return }
                DispatchQueue.main.async {
                    self.data = movies
                    self.popularMovieCollection.reloadData()
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlertWith(title: "Oops!", message: "\(error.localizedDescription)\n Pull view to refresh")
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCollectionViewCell.identifier, for: indexPath) as! PopularMovieCollectionViewCell
        cell.setup(data: data[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((Int(self.popularMovieCollection.frame.width - 20))), height: Int(CGFloat(180)))
    }
    
    
}
