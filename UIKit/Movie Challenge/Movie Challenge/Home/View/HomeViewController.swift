//
//  HomeViewController.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 22/06/22.
//

import UIKit

class HomeViewController: UIViewController {

    var collectionView: UICollectionView! = nil
    var viewModel: HomeViewModelProtocol
    var dataSource: UICollectionViewDiffableDataSource<HomeLayoutSection, HomeSectionItem>?
    var coordinator: HomeCoordinator?

    var topMoviesRegistration: UICollectionView.CellRegistration<TopMoviesCollectionViewCell, Movie>!
    var allMoviesRegistration: UICollectionView.CellRegistration<MovieCollectionViewCell, Movie>!
    var genresRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
    var headerRegistration: UICollectionView.SupplementaryRegistration<SectionHeaderTextReusableView>!
    var footerRegistration: UICollectionView.SupplementaryRegistration<SeparatorCollectionReusableView>!

    override func viewDidLoad() {

        super.viewDidLoad()

        navigationItem.title = "Movies"
        setupCollectionView()
        setupCells()
        setupHeader()
        setupFooter()
        viewModel.fetchTopMovies()
        bindData()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        setupNavigationBar()
        deselectItem(animated: animated)
    }

    init(viewModel: HomeViewModelProtocol = HomeViewModel()) {

        self.viewModel = viewModel
        super.init(nibName: nil, bundle:nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupNavigationBar() {

        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = .white

        navigationController?.navigationBar.standardAppearance = standardAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }

    func deselectItem(animated: Bool) {

        if let indexPath = self.collectionView.indexPathsForSelectedItems?.first {
            if let coordinator = self.transitionCoordinator {
                coordinator.animate(alongsideTransition: { context in
                    self.collectionView.deselectItem(at: indexPath, animated: true)
                }) { (context) in
                    if context.isCancelled {
                        self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                    }
                }
            } else {
                self.collectionView.deselectItem(at: indexPath, animated: animated)
            }
        }
    }

    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.delegate = self
    }

    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionIdentifier = self.dataSource?.snapshot().sectionIdentifiers[sectionIndex]
            return sectionIdentifier?.layoutSection(with: layoutEnvironment)
        }
    }

    func setupCells() {

        topMoviesRegistration = .init(cellNib: TopMoviesCollectionViewCell.nib, handler: { (cell, _, item) in

            cell.setup(withItem: item)
            cell.touchOnImageActionHandler {

                if let imageURL = item.posterPath {
                    self.presentModal(withImageURL: imageURL)
                }
            }
        })

        allMoviesRegistration = .init(cellNib: MovieCollectionViewCell.nib, handler: { (cell, _, item) in
            cell.setup(withItem: item)
        })

        genresRegistration = .init(handler: { (cell, indexPath, item) in
            cell.setup(withTitle: item)
        })
    }

    func setupHeader() {

        headerRegistration = .init(supplementaryNib: SectionHeaderTextReusableView.nib, elementKind: UICollectionView.elementKindSectionHeader, handler: { (header, _, indexPath) in


            if let item = self.dataSource?.itemIdentifier(for: indexPath) {

                switch item {
                case .topMovies:

                    let title = "\(HomeSectionTitle.topMovies.rawValue) \(self.viewModel.topMoviesLimit) Rated"
                    header.setup(title: title)

                case .allMovies:

                    header.setup(title: HomeSectionTitle.allMovies.rawValue, isHiddenButton: false, buttonTitle: "See All")

                    header.buttonActionHandler {
                        self.coordinator?.showAllMovies()
                    }

                case .genres:
                    header.setup(title: HomeSectionTitle.genres.rawValue)
                }
            }
        })
    }

    func setupFooter() {
        footerRegistration = .init(elementKind: UICollectionView.elementKindSectionFooter, handler: { (_, _, _) in })
    }

    func bindData() {

        var snapshot = NSDiffableDataSourceSnapshot<HomeLayoutSection, HomeSectionItem>()
        snapshot.appendSections(HomeLayoutSection.allCases)

        viewModel.topMovies.bind { topMovies in
            if let topMovies = topMovies, !topMovies.isEmpty {

                let items = topMovies.map { movie in
                    HomeSectionItem.topMovies(movie)
                }
                snapshot.appendItems(items, toSection: .topMovies)

                self.setupDataSource(withSnapshot: snapshot)
                self.viewModel.fetchMovies(limit: self.viewModel.moviesLimit)
            }
        }

        viewModel.allMovies.bind { allMovies in
            if let allMovies = allMovies, !allMovies.isEmpty {

                let items = allMovies.map { movie in
                    HomeSectionItem.allMovies(movie)
                }
                snapshot.appendItems(items, toSection: .allMovies)

                self.setupDataSource(withSnapshot: snapshot)
                self.viewModel.fetchGenres()
            }
        }

        viewModel.genres.bind { genres in
            if let genres = genres, !genres.isEmpty {

                let items = genres.map { genre in
                    HomeSectionItem.genres(genre)
                }
                snapshot.appendItems(items, toSection: .genres)

                self.setupDataSource(withSnapshot: snapshot)
            }
        }
    }

    func setupDataSource(withSnapshot snapshot: NSDiffableDataSourceSnapshot<HomeLayoutSection, HomeSectionItem>) {

        dataSource = UICollectionViewDiffableDataSource<HomeLayoutSection, HomeSectionItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: HomeSectionItem) -> UICollectionViewCell? in

            switch item {
            case .topMovies(let movie):
                return collectionView.dequeueConfiguredReusableCell(using: self.topMoviesRegistration, for: indexPath, item: movie)
            case .allMovies(let movie):
                return collectionView.dequeueConfiguredReusableCell(using: self.allMoviesRegistration, for: indexPath, item: movie)
            case .genres(let genre):
                return collectionView.dequeueConfiguredReusableCell(using: self.genresRegistration, for: indexPath, item: genre)
            }
        }

        dataSource?.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.headerRegistration, for: indexPath)
            } else {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.footerRegistration, for: indexPath)
            }
        }

        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
