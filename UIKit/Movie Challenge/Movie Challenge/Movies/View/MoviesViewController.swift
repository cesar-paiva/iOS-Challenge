//
//  MoviesViewController.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import UIKit

class MoviesViewController: UIViewController {

    var dataSource: UICollectionViewDiffableDataSource<MoviesByGenreLayoutSection, SectionItem>!
    var collectionView: UICollectionView!
    var viewModel: MoviesViewModelProtocol
    var sections = [Section<MoviesByGenreLayoutSection>]()

    var movieByGenreRegistration: UICollectionView.CellRegistration<MovieByGenreCollectionViewCell, SectionItem>!
    var headerRegistration: UICollectionView.SupplementaryRegistration<SectionHeaderTextReusableView>!
    var footerRegistration: UICollectionView.SupplementaryRegistration<SeparatorCollectionReusableView>!

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "Movies"

        setupCollectionView()
        setupCells()
        viewModel.fetchAllMovies()
        bindData()
    }

    init(viewModel: MoviesViewModelProtocol = MoviesViewModel()) {

        self.viewModel = viewModel
        super.init(nibName: String(describing: HomeViewController.self),
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

        movieByGenreRegistration = .init(cellNib: MovieByGenreCollectionViewCell.nib, handler: { (cell, _, item) in
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

        viewModel.movies.bind { movies in
            if let movies = movies, !movies.isEmpty {
                self.sections.append(Section(title: String(), layout: .main, items: movies))
                self.setupDataSource()
            }
        }
    }

    func setupDataSource() {

        dataSource = UICollectionViewDiffableDataSource<MoviesByGenreLayoutSection, SectionItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: SectionItem) -> UICollectionViewCell? in
            guard let sectionIdentifier = self.dataSource.snapshot().sectionIdentifier(containingItem: item) else {
                return nil
            }

            switch sectionIdentifier {
            case .main:
                return collectionView.dequeueConfiguredReusableCell(using: self.movieByGenreRegistration, for: indexPath, item: item)
            }
        }

        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.headerRegistration, for: indexPath)
            } else {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.footerRegistration, for: indexPath)
            }
        }

        var snapshot = NSDiffableDataSourceSnapshot<MoviesByGenreLayoutSection, SectionItem>()
        sections.forEach { section in
            snapshot.appendSections([section.layout])
            snapshot.appendItems(section.items)
        }

        dataSource.apply(snapshot, animatingDifferences: false)
    }


}
