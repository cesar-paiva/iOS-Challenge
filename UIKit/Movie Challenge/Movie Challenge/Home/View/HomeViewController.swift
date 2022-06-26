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
    var dataSource: UICollectionViewDiffableDataSource<HomeLayoutSection, SectionItem>?
    var sections = [Section<HomeLayoutSection>]()
    var coordinator: HomeCoordinator?

    var topMoviesRegistration: UICollectionView.CellRegistration<TopMoviesCollectionViewCell, SectionItem>!
    var allMoviesRegistration: UICollectionView.CellRegistration<MovieCollectionViewCell, SectionItem>!
    var genresRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, SectionItem>!
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

        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = .white

        navigationController?.navigationBar.standardAppearance = standardAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }

    init(viewModel: HomeViewModelProtocol = HomeViewModel()) {

        self.viewModel = viewModel
        super.init(nibName: nil, bundle:nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        })

        allMoviesRegistration = .init(cellNib: MovieCollectionViewCell.nib, handler: { (cell, _, item) in
            cell.setup(withItem: item)
        })

        genresRegistration = .init(handler: { (cell, indexPath, item) in
            cell.setup(withItem: item)
        })
    }

    func setupHeader() {

        headerRegistration = .init(supplementaryNib: SectionHeaderTextReusableView.nib, elementKind: UICollectionView.elementKindSectionHeader, handler: { (header, _, indexPath) in

            let title = self.sections[indexPath.section].title
            let isHiddenButton = self.sections[indexPath.section].isHiddenButton
            let buttonTitle = self.sections[indexPath.section].titleButton

            header.setup(title: title, isHiddenButton: isHiddenButton, buttonTitle: buttonTitle)
            header.buttonActionHandler {
                self.coordinator?.showAllMovies()
            }
        })
    }

    func setupFooter() {
        footerRegistration = .init(elementKind: UICollectionView.elementKindSectionFooter, handler: { (_, _, _) in })
    }

    func bindData() {

        viewModel.topMovies.bind { topMovies in
            if let topMovies = topMovies, !topMovies.isEmpty {
                self.sections.append(Section(title: "Movies: Top \(self.viewModel.topMoviesLimit) Rated", layout: .topMovies, items: topMovies))
                self.viewModel.fetchMovies(limit: self.viewModel.moviesLimit)
                self.setupDataSource()
            }
        }

        viewModel.allMovies.bind { allMovies in
            if let allMovies = allMovies, !allMovies.isEmpty {
                self.sections.append(Section(title: "Browse by All",
                                             layout: .movies,
                                             items: allMovies,
                                             isHiddenButton: false,
                                             titleButton: "See All"))
                self.viewModel.fetchGenres()
                self.setupDataSource()
            }
        }

        viewModel.genres.bind { genres in
            if let genres = genres, !genres.isEmpty {
                self.sections.append(Section(title: "Browse By Genre", layout: .genres, items: genres))
                self.setupDataSource()
            }
        }
    }

    func setupDataSource() {

        dataSource = UICollectionViewDiffableDataSource<HomeLayoutSection, SectionItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: SectionItem) -> UICollectionViewCell? in
            guard let sectionIdentifier = self.dataSource?.snapshot().sectionIdentifier(containingItem: item) else {
                return nil
            }

            switch sectionIdentifier {
            case .topMovies:
                return collectionView.dequeueConfiguredReusableCell(using: self.topMoviesRegistration, for: indexPath, item: item)
            case .movies:
                return collectionView.dequeueConfiguredReusableCell(using: self.allMoviesRegistration, for: indexPath, item: item)
            case .genres:
                return collectionView.dequeueConfiguredReusableCell(using: self.genresRegistration, for: indexPath, item: item)
            }
        }

        dataSource?.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.headerRegistration, for: indexPath)
            } else {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.footerRegistration, for: indexPath)
            }
        }

        var snapshot = NSDiffableDataSourceSnapshot<HomeLayoutSection, SectionItem>()
        sections.forEach { section in
            snapshot.appendSections([section.layout])
            snapshot.appendItems(section.items)
        }

        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
