//
//  MoviesViewController.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import UIKit

class MoviesViewController: UIViewController {

    var dataSource: UICollectionViewDiffableDataSource<MoviesByGenreLayoutSection, MoviesSectionItem>!
    var collectionView: UICollectionView!
    var viewModel: MoviesViewModelProtocol
    var coordinator: MoviesCoordinator?
    let searchBar = UISearchBar(frame: .zero)

    var movieByGenreRegistration: UICollectionView.CellRegistration<MoviesCollectionViewCell, Movie>!

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "Movies"

        setupNavigationItem()
        setupCollectionView()
        setupCells()
        viewModel.fetchAllMovies()
        bindData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.didFinishShowMovies()
    }

    init(viewModel: MoviesViewModelProtocol = MoviesViewModel()) {

        self.viewModel = viewModel
        super.init(nibName:nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupNavigationItem() {

        func createMenu() -> UIMenu {

            let sortByTitleAction = UIAction(title: "Sort by title",
                                             image: UIImage(systemName: "arrow.counterclockwise")) { [weak self] _ in

                guard let self = self else { return }
                self.sortDataSource(withItems: self.viewModel.sortByTitle())
            }

            let sortByRatingAction = UIAction(title: "Sort by rating",
                                              image: UIImage(systemName: "arrow.counterclockwise")) { [weak self] _ in

                guard let self = self else { return }
                self.sortDataSource(withItems: self.viewModel.sortByRating())
            }

            let sortByReleaseDateAction = UIAction(title: "Sort by Release Date",
                                                   image: UIImage(systemName: "arrow.counterclockwise")) { [weak self] _ in

                guard let self = self else { return }
                self.sortDataSource(withItems: self.viewModel.sortByReleaseDate())
            }

            let menu = UIMenu(title: "", children: [sortByTitleAction, sortByRatingAction, sortByReleaseDateAction])
            return menu
        }
        
        let navItem = UIBarButtonItem(image: UIImage(systemName: "lineweight"), menu: createMenu())
        navigationItem.rightBarButtonItem = navItem
    }

    func sortDataSource(withItems items: [Movie]) {

        var snapshot = NSDiffableDataSourceSnapshot<MoviesByGenreLayoutSection, MoviesSectionItem>()
        snapshot.appendSections(MoviesByGenreLayoutSection.allCases)

        let items = items.map { movie in
            MoviesSectionItem.movie(movie)
        }

        snapshot.appendItems(items)
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }

    func setupCollectionView() {

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
        view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        searchBar.placeholder = "Search by title or director"
        searchBar.delegate = self
    }

    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionIdentifier = self.dataSource?.snapshot().sectionIdentifiers[sectionIndex]
            return sectionIdentifier?.layoutSection(with: layoutEnvironment)
        }
    }

    func setupCells() {

        movieByGenreRegistration = .init(cellNib: MoviesCollectionViewCell.nib, handler: { (cell, _, item) in
            cell.setup(withMovie: item)
        })
    }

    func bindData() {

        viewModel.movies.bind { movies in

            if let movies = movies, !movies.isEmpty {

                var snapshot = NSDiffableDataSourceSnapshot<MoviesByGenreLayoutSection, MoviesSectionItem>()
                snapshot.appendSections(MoviesByGenreLayoutSection.allCases)

                let items = movies.map { movie in
                    MoviesSectionItem.movie(movie)
                }

                snapshot.appendItems(items)

                self.setupDataSource(withSnapshot: snapshot)
            }
        }
    }

    func setupDataSource(withSnapshot snapshot: NSDiffableDataSourceSnapshot<MoviesByGenreLayoutSection, MoviesSectionItem>) {

        dataSource = UICollectionViewDiffableDataSource<MoviesByGenreLayoutSection, MoviesSectionItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: MoviesSectionItem) -> UICollectionViewCell? in

            switch item {
            case .movie(let movie):
                return collectionView.dequeueConfiguredReusableCell(using: self.movieByGenreRegistration, for: indexPath, item: movie)

            }
        }

        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func performQuery(with text: String) {

        let movies = viewModel.filteredMovies(with: text).sorted { $0.title ?? String() < $1.title ?? String() }

        var snapshot = NSDiffableDataSourceSnapshot<MoviesByGenreLayoutSection, MoviesSectionItem>()
        snapshot.appendSections([.movies])

        let items = movies.map { movie in
            MoviesSectionItem.movie(movie)
        }

        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
