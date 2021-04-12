//
//  SearchViewController.swift
//  Movies
//
//  Created by Engin Yildiz on 8.04.2021.
//

import UIKit

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)! as UITableViewCell
        cell.textLabel?.text = viewModel.getMovie(at: indexPath).title
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.goMovieInfo(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex: Int = tableView.numberOfSections - 1
        let lastRowIndex: Int = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if viewModel.canLoadMore && (indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex) {
            viewModel.searchMovie(query: moviesSearchBar.text!)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchBar.text!.count > 0 else { return }
        
        searchBar.resignFirstResponder()
        viewModel.resetQuery()
        viewModel.searchMovie(query: searchBar.text!)
    }
}

final class SearchViewController: SuperViewController {
    @IBOutlet weak var moviesTableView: UITableView! {
        didSet {
            moviesTableView.delegate = self
            moviesTableView.dataSource = self
            moviesTableView.tableFooterView = UIView(frame: CGRect.zero)
            moviesTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        }
    }
    @IBOutlet weak var moviesSearchBar: UISearchBar! {
        didSet {
            moviesSearchBar.delegate = self
        }
    }
    
    var viewModel: SearchViewModelProtocol! {
        didSet {
            viewModel.delegate = self
            viewModel.loadView()
        }
    }
    
    let cellReuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.moviesFetched = {[weak self] in
            self?.moviesTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        tabBarController?.navigationItem.title = "Search"
        
        super.viewWillAppear(animated)
    }
    
    func prepareView() {
        
    }
}

extension SearchViewController: SearchViewModelDelegate {
    
    func handleViewModelOutput(_ output: SearchViewModelOutput) {
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
    
    func navigate(to route: SearchViewRoute) {
        switch route {
        case .movieDetail(let viewModel, let movieID):
            let viewController = MovieInfoViewBuilder.make(with: viewModel, movieID: movieID)
            navigationController?.pushViewController(viewController, animated: true)
            break
        }
    }
}
