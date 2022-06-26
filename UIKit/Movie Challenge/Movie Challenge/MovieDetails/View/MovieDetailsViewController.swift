//
//  MovieDetailsViewController.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var collectionView: UICollectionView! = nil
    var viewModel: MovieDetailsViewModelProtocol
    var dataSource: UICollectionViewDiffableDataSource<MovieDetailsLayoutSection, MoviesDetailsSectionItem>?
    var sections = [MovieDetailsSection]()
    var coordinator: MovieDetailsCoordinator?

    var movieDetailsRegistration: UICollectionView.CellRegistration<MovieDetailsCollectionViewCell, MoviesDetailsSectionItem>!
    var castRegistration: UICollectionView.CellRegistration<CastCollectionViewCell, MoviesDetailsSectionItem>!
    var headerRegistration: UICollectionView.SupplementaryRegistration<SectionHeaderTextReusableView>!
    var footerRegistration: UICollectionView.SupplementaryRegistration<SeparatorCollectionReusableView>!

    override func viewDidLoad() {

        super.viewDidLoad()

        setupNavigationBar()
        setupCollectionView()
        setupCells()
        setupHeader()
        setupFooter()
        setupSections()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.didFinishShowMovieDetails()
    }

    init(viewModel: MovieDetailsViewModelProtocol) {

        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupNavigationBar() {
        navigationItem.title = "Movie Details"
    }

    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
    }

    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionIdentifier = self.dataSource?.snapshot().sectionIdentifiers[sectionIndex]
            return sectionIdentifier?.layoutSection(with: layoutEnvironment)
        }
    }

    func setupCells() {

        movieDetailsRegistration = .init(cellNib: MovieDetailsCollectionViewCell.nib, handler: { (cell, _, item) in
            cell.setup(withItem: item)
        })

        castRegistration = .init(cellNib: CastCollectionViewCell.nib, handler: { (cell, indexPath, item) in
            cell.setup(withItem: item)
        })
    }

    func setupHeader() {

        headerRegistration = .init(supplementaryNib: SectionHeaderTextReusableView.nib, elementKind: UICollectionView.elementKindSectionHeader, handler: { (header, _, indexPath) in

            let title = self.sections[indexPath.section].title
            header.setup(title: title)
        })
    }

    func setupFooter() {
        footerRegistration = .init(elementKind: UICollectionView.elementKindSectionFooter, handler: { (_, _, _) in })
    }

    func setupSections() {

        sections.append(MovieDetailsSection(title: String(), layout: .details, items: viewModel.movieDetail))
        sections.append(MovieDetailsSection(title: "Cast", layout: .cast, items: viewModel.cast))
        setupDataSource()

    }

    func setupDataSource() {

        dataSource = UICollectionViewDiffableDataSource<MovieDetailsLayoutSection, MoviesDetailsSectionItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: MoviesDetailsSectionItem) -> UICollectionViewCell? in
            guard let sectionIdentifier = self.dataSource?.snapshot().sectionIdentifier(containingItem: item) else {
                return nil
            }

            switch sectionIdentifier {
            case .details:
                return collectionView.dequeueConfiguredReusableCell(using: self.movieDetailsRegistration, for: indexPath, item: item)
            case .cast:
                return collectionView.dequeueConfiguredReusableCell(using: self.castRegistration, for: indexPath, item: item)
            }
        }

        dataSource?.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.headerRegistration, for: indexPath)
            } else {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.footerRegistration, for: indexPath)
            }
        }

        var snapshot = NSDiffableDataSourceSnapshot<MovieDetailsLayoutSection, MoviesDetailsSectionItem>()
        sections.forEach { section in
            snapshot.appendSections([section.layout])
            snapshot.appendItems(section.items)
        }

        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
