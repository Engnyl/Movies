//
//  WatchlistViewController.swift
//  Movies
//
//  Created by Engin Yildiz on 11.04.2021.
//

import UIKit

extension WatchlistViewController: UITableViewDataSource {
    
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

extension WatchlistViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.goMovieInfo(at: indexPath)
    }
}

final class WatchlistViewController: SuperViewController {
    @IBOutlet weak var watchlistTableView: UITableView! {
        didSet {
            watchlistTableView.delegate = self
            watchlistTableView.dataSource = self
            watchlistTableView.tableFooterView = UIView(frame: CGRect.zero)
            watchlistTableView.register(UINib.init(nibName: "MovieTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieTableViewCell")
        }
    }
    
    var viewModel: WatchlistViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    let cellReuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.reloadWatchlistTableViewClosure = {[weak self] in
            self?.watchlistTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        tabBarController?.navigationItem.title = "Watchlist"
        
        super.viewWillAppear(animated)
        
        viewModel.loadView()
    }
    
    func prepareView() {
        
    }
}

extension WatchlistViewController: WatchlistViewModelDelegate {
    
    func handleViewModelOutput(_ output: WatchlistViewModelOutput) {
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
    
    func navigate(to route: WatchlistViewRoute) {
        switch route {
        case .movieDetail(let viewModel, let movieID):
            let viewController = MovieInfoViewBuilder.make(with: viewModel, movieID: movieID)
            navigationController?.pushViewController(viewController, animated: true)
            break
        }
    }
}

