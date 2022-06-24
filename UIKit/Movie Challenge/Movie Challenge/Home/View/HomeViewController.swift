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
    var dataSource: UICollectionViewDiffableDataSource<LayoutSection, SectionItem>?
    var sections: [Section] = []

    var topMoviesRegistration: UICollectionView.CellRegistration<TopMoviesCollectionViewCell, SectionItem>!
    var allMoviesRegistration: UICollectionView.CellRegistration<MovieCollectionViewCell, SectionItem>!
    var headerRegistration: UICollectionView.SupplementaryRegistration<SectionHeaderTextReusableView>!
    var footerRegistration: UICollectionView.SupplementaryRegistration<SeparatorCollectionReusableView>!

    override func viewDidLoad() {

        super.viewDidLoad()

        navigationItem.title = "Movies"
        setupCollectionView()
        setupCells()
        setupHeader()
        setupFooter()
        viewModel.fetchTopFiveMovies()
        bindData()
    }

    init(viewModel: HomeViewModelProtocol = HomeViewModel()) {

        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self),
                   bundle: Bundle(for: type(of: self)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
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
    }

    func setupHeader() {

        headerRegistration = .init(supplementaryNib: SectionHeaderTextReusableView.nib, elementKind: UICollectionView.elementKindSectionHeader, handler: { (header, _, indexPath) in
            let title = self.sections[indexPath.section].title
            header.titleLabel.text = title
        })
    }

    func setupFooter() {
        footerRegistration = .init(elementKind: UICollectionView.elementKindSectionFooter, handler: { (_, _, _) in })
    }

    func bindData() {

        viewModel.topFiveMovies.bind { topFiveMovies in
            if let topFiveMovies = topFiveMovies, !topFiveMovies.isEmpty {
                self.sections.append(Section("Top Five Rated", .topMovies, topFiveMovies))
                self.viewModel.fetchAllMovies()
                self.setupDataSource()
            }
        }

        viewModel.allMovies.bind { allMovies in
            if let allMovies = allMovies, !allMovies.isEmpty {
                self.sections.append(Section("Browse By All", .allMovies, allMovies))
                self.setupDataSource()
            }
        }
    }

    func setupDataSource() {

        dataSource = UICollectionViewDiffableDataSource<LayoutSection, SectionItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: SectionItem) -> UICollectionViewCell? in
            guard let sectionIdentifier = self.dataSource?.snapshot().sectionIdentifier(containingItem: item) else {
                return nil
            }

            switch sectionIdentifier {
            case .topMovies:
                return collectionView.dequeueConfiguredReusableCell(using: self.topMoviesRegistration, for: indexPath, item: item)
            case .allMovies:
                return collectionView.dequeueConfiguredReusableCell(using: self.allMoviesRegistration, for: indexPath, item: item)
            }
        }

        dataSource?.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.headerRegistration, for: indexPath)
            } else {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.footerRegistration, for: indexPath)
            }
        }

        var snapshot = NSDiffableDataSourceSnapshot<LayoutSection, SectionItem>()
        sections.forEach { section in
            snapshot.appendSections([section.layout])
            snapshot.appendItems(section.items)
        }

        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
