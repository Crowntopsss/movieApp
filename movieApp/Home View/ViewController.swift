//
//  ViewController.swift
//  movieApp
//
//  Created by Temitope on 30/08/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var popularData = [Movie]()
    var nowPlayData = [Movie]()
    let viewModel = HomeViewModel()

    
    @IBOutlet weak var nowPlayingCollection: UICollectionView!
    @IBOutlet weak var popularMovieCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        fetchNowPlayData()
        register()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        popularMovieCollection.collectionViewLayout = layout
        nowPlayingCollection.collectionViewLayout = layout
        
        
        // Do any additional setup after loading the view.
    }
    
    func register() {
        popularMovieCollection.register(UINib(nibName: PopularMovieCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PopularMovieCollectionViewCell.identifier)
        
        nowPlayingCollection.register(UINib(nibName: NowPlayingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: NowPlayingCollectionViewCell.identifier)
    }

    private func fetchData() {
        viewModel.getPopularMovies { (result) in
            switch result {
            case .success(let movies):
                guard let movies = movies else { return }
                DispatchQueue.main.async {
                    self.popularData = movies
                    self.popularMovieCollection.reloadData()
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlertWith(title: "Oops!", message: "\(error.localizedDescription)\n Pull view to refresh")
                }
            }
        }
    }
    private func fetchNowPlayData() {
        viewModel.getNowPlaying { (result) in
            switch result {
            case .success(let movies):
                guard let movies = movies else { return }
                DispatchQueue.main.async {
                    self.nowPlayData = movies
                    self.nowPlayingCollection.reloadData()
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
        
        switch collectionView {
        case popularMovieCollection:
            return popularData.count
        case nowPlayingCollection :
            return nowPlayData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case popularMovieCollection:
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCollectionViewCell.identifier, for: indexPath) as! PopularMovieCollectionViewCell
            cell.setup(data: popularData[indexPath.row])
            return cell
        case nowPlayingCollection :
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCollectionViewCell.identifier, for: indexPath) as! NowPlayingCollectionViewCell
            cell.setup(data: nowPlayData[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case popularMovieCollection:
            return CGSize(width: Int(CGFloat(300)), height: Int(CGFloat(180)))
        case nowPlayingCollection:
            return CGSize(width: Int(CGFloat(150)), height: Int(CGFloat(226)))
        default:
            return CGSize()
        }
    }
    
    
}
