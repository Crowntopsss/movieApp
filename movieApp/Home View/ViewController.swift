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
    var peopleData = [Results]()
    var topSeriesData = [Movie]()
    
    let viewModel = HomeViewModel()

    
    @IBOutlet weak var topSeriesCollection: UICollectionView!
    @IBOutlet weak var peopleCollection: UICollectionView!
    @IBOutlet weak var nowPlayingCollection: UICollectionView!
    @IBOutlet weak var popularMovieCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        fetchNowPlayData()
        fetchPeopleData()
        topSeries()
        
        register()
        let layout = UICollectionViewFlowLayout()
        let layout2 = UICollectionViewFlowLayout()
        let layout3 = UICollectionViewFlowLayout()
        let layout4 = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout2.scrollDirection = .horizontal
        layout3.scrollDirection = .horizontal
        layout4.scrollDirection = .horizontal
    
        
        popularMovieCollection.collectionViewLayout = layout
        nowPlayingCollection.collectionViewLayout = layout2
        peopleCollection.collectionViewLayout = layout3
        topSeriesCollection.collectionViewLayout = layout4
        
        // Do any additional setup after loading the view.
    }
    
    func register() {
        popularMovieCollection.register(UINib(nibName: PopularMovieCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PopularMovieCollectionViewCell.identifier)
        
        nowPlayingCollection.register(UINib(nibName: NowPlayingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: NowPlayingCollectionViewCell.identifier)
        
        peopleCollection.register(UINib(nibName: PeopleCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PeopleCollectionViewCell.identifier)
        
        topSeriesCollection.register(UINib(nibName: TopSeriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TopSeriesCollectionViewCell.identifier)
    }
    
    private func fetchPeopleData() {
        viewModel.getPeople { (result) in
            switch result {
            case .success(let movies):
                guard let movies = movies else { return }
                DispatchQueue.main.async {
                    self.peopleData = movies
                    self.peopleCollection.reloadData()
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlertWith(title: "Oops!", message: "\(error.localizedDescription)\n Pull view to refresh")
                }
            }
        }
    }
    
    private func topSeries() {
        viewModel.topSer { (result) in
            switch result {
            case .success(let movies):
                guard let movies = movies else { return }
                DispatchQueue.main.async {
                    self.topSeriesData = movies
                    self.topSeriesCollection.reloadData()
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlertWith(title: "Oops!", message: "\(error.localizedDescription)\n Pull view to refresh")
                }
            }
        }
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
        case peopleCollection :
            return peopleData.count
        case topSeriesCollection :
            return topSeriesData.count
            
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
        case peopleCollection :
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: PeopleCollectionViewCell.identifier, for: indexPath) as! PeopleCollectionViewCell
            cell.set(data: peopleData[indexPath.row])
            return cell
        case topSeriesCollection :
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: TopSeriesCollectionViewCell.identifier, for: indexPath) as! TopSeriesCollectionViewCell
            cell.setup(data: topSeriesData[indexPath.row])
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
        case peopleCollection :
            return CGSize(width: Int(CGFloat(130)), height: Int(CGFloat(130)))
        case topSeriesCollection:
            return CGSize(width: Int(CGFloat(150)), height: Int(CGFloat(226)))
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case popularMovieCollection:
            let controller = DetailsViewController.instantiate()
            controller.movie = popularData[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        case nowPlayingCollection:
            let controller = DetailsViewController.instantiate()
            controller.movie = nowPlayData[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        case topSeriesCollection:
            let controller = DetailsViewController.instantiate()
            controller.movie = topSeriesData[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        default:
            let controller = DetailsViewController.instantiate()
            navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
}
