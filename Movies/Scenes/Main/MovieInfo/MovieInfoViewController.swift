//
//  MovieInfoViewController.swift
//  Movies
//
//  Created by Engin Yildiz on 10.04.2021.
//

import UIKit
import SDWebImage

final class MovieInfoViewController: SuperViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var releaseDateIcon: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var addWatchlistButton: UIButton!
    @IBOutlet weak var addFavoriteButton: UIButton!
    
    var movieInfoModel: MovieInfoModel!
    
    var viewModel: MovieInfoViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    var movieID: Int! {
        didSet {
            viewModel.loadView(movieID: movieID)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        
        super.viewWillAppear(animated)
    }
    
    func prepareView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        view.backgroundColor = lightGrayColor
        buttonContainerView.backgroundColor = darkGrayColor
        
        addWatchlistButton.addTarget(self, action: #selector(addWatchlistButtonTapped), for: UIControl.Event.touchUpInside)
        addFavoriteButton.addTarget(self, action: #selector(addFavoriteButtonTapped), for: UIControl.Event.touchUpInside)
        
        titleLabel.text = movieInfoModel.originalTitle
        scoreLabel.text = String(movieInfoModel.voteAverage)
        releaseDateLabel.text = movieInfoModel.releaseDate
        releaseDateIcon.isHidden = !(movieInfoModel.releaseDate.count > 0)
        descriptionTextView.text = movieInfoModel.overview
        
        if let imagePath: String = movieInfoModel.posterPath, let imageURL: URL = URL(string: (imageBaseURL + imagePath)) {
            backgroundImageView.sd_setImage(with: imageURL, placeholderImage: nil, options: [], completed: { (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
                self.backgroundImageView.image = image
            })
        }
    }
    
    @objc func addWatchlistButtonTapped() {
        let watchlistUpdateRequestModel: WatchlistUpdateRequestModel = WatchlistUpdateRequestModel.init(mediaType: "movie", mediaID: movieInfoModel.id, watchlist: true)
        viewModel.addWatchlistButtonPressed(watchlistUpdateRequestModel: watchlistUpdateRequestModel)
    }
    
    @objc func addFavoriteButtonTapped() {
        let favoriteUpdateRequestModel: FavoriteUpdateRequestModel = FavoriteUpdateRequestModel.init(mediaType: "movie", mediaID: movieInfoModel.id, favorite: true)
        viewModel.addFavoriteButtonPressed(favoriteUpdateRequestModel: favoriteUpdateRequestModel)
    }
}

extension MovieInfoViewController: MovieInfoViewModelDelegate {
    
    func handleViewModelOutput(_ output: MovieInfoViewModelOutput) {
        switch output {
        case .loadView(let movieInfoModel):
            self.movieInfoModel = movieInfoModel
            prepareView()
        case .showToastMessage(let message):
            showToastOnCenter(message: message, title: nil, duration: 3.0)
        case .isLoading(let loading):
            loading ? LoadingView.startLoading() : LoadingView.stopLoading()
        case .hideKeyboard:
            dismissKeyboard()
        case .setTitle(let title):
            navigationItem.title = title
        }
    }
}
