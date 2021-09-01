//
//  FavouritesViewController.swift
//  movieApp
//
//  Created by Temitope on 01/09/2021.
//

import UIKit

class FavouritesViewController: UIViewController {
    let contentView = FavouriteView()
    
    var favouriteMovies: [Movie] {
        return MoviePersisterManager.shared.load() ?? []
    }
    
    var filteredMovies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favourites"
        setupCustomView()
        setupTableView()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.contentView.tableView.reloadData()
        self.contentView.tableView.backgroundColor = .black
        let headerView: UIView = UIView.init(frame: CGRect(x: 1, y: 50, width: 276, height: 60))
        headerView.backgroundColor = .black
        let labelView: UILabel = UILabel.init(frame: CGRect(x: 4, y: 5, width: 276, height: 55))
        labelView.text = "Saved Movies"
        labelView.font = UIFont.systemFont(ofSize: 25, weight: .regular)

        labelView.textColor = .white
        headerView.addSubview(labelView)
        self.contentView.tableView.tableHeaderView = headerView

    }
    
    private func setupTableView() {
        contentView.searchBar.delegate = self
    }
    
    private func setupSearchBar() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }

    private func setupCustomView() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

extension FavouritesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = favouriteMovies.filter{($0.title?.lowercased() ?? "").contains(searchBar.text?.lowercased() ?? "")}
        contentView.tableView.reloadData()
    }
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (contentView.searchBar.text?.isEmpty ?? true) ? favouriteMovies.count : filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        cell.textLabel?.text = (contentView.searchBar.text?.isEmpty ?? true) ? favouriteMovies[indexPath.row].title : filteredMovies[indexPath.row].title
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = (contentView.searchBar.text?.isEmpty ?? true) ? favouriteMovies[indexPath.row] : filteredMovies[indexPath.row]
        let controller = DetailsViewController.instantiate()
        controller.movie = data
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
