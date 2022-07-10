//
//  MoviesByGenreViewController.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import UIKit

class MoviesByGenreViewController: UIViewController {

    var dataSource: UICollectionViewDiffableDataSource<MoviesByGenreLayoutSection, MoviesByGenreSectionItem>!
    var collectionView: UICollectionView!
    var viewModel: MoviesByGenreViewModelProtocol
    var coordinator: MoviesByGenreCoordinator?

    var movieByGenreRegistration: UICollectionView.CellRegistration<MoviesCollectionViewCell, Movie>!
    var headerRegistration: UICollectionView.SupplementaryRegistration<SectionHeaderTextReusableView>!
    var footerRegistration: UICollectionView.SupplementaryRegistration<SeparatorCollectionReusableView>!

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "\(viewModel.genre) Movies"

        setupNavigationItem()
        setupCollectionView()
        setupCells()
        viewModel.fetchMoviesByGenre(viewModel.genre)
        bindData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.didFinishShowMovieByGenre()
    }

    init(viewModel: MoviesByGenreViewModelProtocol) {

        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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

        var snapshot = NSDiffableDataSourceSnapshot<MoviesByGenreLayoutSection, MoviesByGenreSectionItem>()
        snapshot.appendSections([.movies])

        let items = items.map { movie in
            MoviesByGenreSectionItem.movie(movie)
        }

        snapshot.appendItems(items)
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }

    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
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

    func setupHeader() {

        headerRegistration = .init(supplementaryNib: SectionHeaderTextReusableView.nib, elementKind: UICollectionView.elementKindSectionHeader, handler: { (header, text, indexPath) in
            header.titleLabel.text = text
        })
    }

    func setupFooter() {
        footerRegistration = .init(elementKind: UICollectionView.elementKindSectionFooter, handler: { (_, _, _) in })
    }

    func bindData() {

        viewModel.movies.bind { movies in
            if let movies = movies, !movies.isEmpty {

                var snapshot = NSDiffableDataSourceSnapshot<MoviesByGenreLayoutSection, MoviesByGenreSectionItem>()
                snapshot.appendSections(MoviesByGenreLayoutSection.allCases)

                let items = movies.map { movie in
                    MoviesByGenreSectionItem.movie(movie)
                }

                snapshot.appendItems(items)

                self.setupDataSource(withSnapshot: snapshot)
            }
        }
    }

    func setupDataSource(withSnapshot snapshot: NSDiffableDataSourceSnapshot<MoviesByGenreLayoutSection, MoviesByGenreSectionItem>) {

        dataSource = UICollectionViewDiffableDataSource<MoviesByGenreLayoutSection, MoviesByGenreSectionItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: MoviesByGenreSectionItem) -> UICollectionViewCell? in

            switch item {
            case .movie(let movie):
                return collectionView.dequeueConfiguredReusableCell(using: self.movieByGenreRegistration, for: indexPath, item: movie)
            }
        }

        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.headerRegistration, for: indexPath)
            } else {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.footerRegistration, for: indexPath)
            }
        }

        dataSource.apply(snapshot, animatingDifferences: false)
    }


}
