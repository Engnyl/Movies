//
//  FavoritesViewController.swift
//  Movies
//
//  Created by Engin Yildiz on 11.04.2021.
//

import UIKit

extension FavoritesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            fatalError("Cell does not exists in storyboard")
        }
        
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.goMovieInfo(at: indexPath)
    }
}

final class FavoritesViewController: SuperViewController {
    @IBOutlet weak var favoritesTableView: UITableView! {
        didSet {
            favoritesTableView.delegate = self
            favoritesTableView.dataSource = self
            favoritesTableView.tableFooterView = UIView(frame: CGRect.zero)
            favoritesTableView.register(UINib.init(nibName: "MovieTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieTableViewCell")
        }
    }
    
    var viewModel: FavoritesViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    let cellReuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.reloadFavoritesTableViewClosure = {[weak self] in
            self?.favoritesTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        tabBarController?.navigationItem.title = "Favorites"
        
        super.viewWillAppear(animated)
        
        viewModel.loadView()
    }
    
    func prepareView() {
        
    }
}

extension FavoritesViewController: FavoritesViewModelDelegate {
    
    func handleViewModelOutput(_ output: FavoritesViewModelOutput) {
        switch output {
        case .loadView:
            prepareView()
        case .showToastMessage(let message):
            showToastOnCenter(message: message, title: nil, duration: 3.0)
        case .isLoading(let loading):
            loading ? LoadingView.startLoading() : LoadingView.stopLoading()
        case .hideKeyboard:
            dismissKeyboard()
        }
    }
    
    func navigate(to route: FavoritesViewRoute) {
        switch route {
        case .movieDetail(let viewModel, let movieID):
            let viewController = MovieInfoViewBuilder.make(with: viewModel, movieID: movieID)
            navigationController?.pushViewController(viewController, animated: true)
            break
        }
    }
}
