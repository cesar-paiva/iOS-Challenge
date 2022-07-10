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
    var dataSource: UICollectionViewDiffableDataSource<MovieDetailsLayoutSection, MovieDetailsSectionItem>?
    var coordinator: MovieDetailsCoordinator?
    var movieId: Int

    var movieDetailsRegistration: UICollectionView.CellRegistration<MovieDetailsCollectionViewCell, MovieDetails>!
    var castRegistration: UICollectionView.CellRegistration<CastCollectionViewCell, Cast>!
    var headerRegistration: UICollectionView.SupplementaryRegistration<SectionHeaderTextReusableView>!
    var footerRegistration: UICollectionView.SupplementaryRegistration<SeparatorCollectionReusableView>!

    override func viewDidLoad() {

        super.viewDidLoad()

        setupNavigationBar()
        setupCollectionView()
        setupCells()
        setupHeader()
        setupFooter()
        viewModel.fetchMovie(withId: movieId)
        bindData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.didFinishShowMovieDetails()
    }

    init(viewModel: MovieDetailsViewModelProtocol = MovieDetailsViewModel(),
         movieId: Int) {

        self.viewModel = viewModel
        self.movieId = movieId
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
            cell.setup(withMovieDetails: item)
        })

        castRegistration = .init(cellNib: CastCollectionViewCell.nib, handler: { (cell, indexPath, item) in
            cell.setup(withCast: item)
        })
    }

    func setupHeader() {

        headerRegistration = .init(supplementaryNib: SectionHeaderTextReusableView.nib, elementKind: UICollectionView.elementKindSectionHeader, handler: { (header, _, indexPath) in

            if let title = self.dataSource?.sectionIdentifier(for: indexPath.section) {
                header.setup(title: title.rawValue)
            }
        })
    }

    func setupFooter() {
        footerRegistration = .init(elementKind: UICollectionView.elementKindSectionFooter, handler: { (_, _, _) in })
    }

    func setupDataSource(withSnapshot snapshot: NSDiffableDataSourceSnapshot<MovieDetailsLayoutSection, MovieDetailsSectionItem>) {

        dataSource = UICollectionViewDiffableDataSource<MovieDetailsLayoutSection, MovieDetailsSectionItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: MovieDetailsSectionItem) -> UICollectionViewCell? in

            switch item {
            case .details(let movieDetails):
                return collectionView.dequeueConfiguredReusableCell(using: self.movieDetailsRegistration, for: indexPath, item: movieDetails)
            case .cast(let cast):
                return collectionView.dequeueConfiguredReusableCell(using: self.castRegistration, for: indexPath, item: cast)
            }
        }

        dataSource?.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.headerRegistration, for: indexPath)
            } else {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.footerRegistration, for: indexPath)
            }
        }

        self.dataSource?.apply(snapshot, animatingDifferences: false)


    }

    func bindData() {

        viewModel.movie.bind { movie in

            if let movie = movie {

                var snapshot = NSDiffableDataSourceSnapshot<MovieDetailsLayoutSection, MovieDetailsSectionItem>()
                snapshot.appendSections(MovieDetailsLayoutSection.allCases)


                let movieDetailsItem = MovieDetailsSectionItem.details(movie)
                snapshot.appendItems([movieDetailsItem], toSection: MovieDetailsLayoutSection.details)

                let castItems = movie.cast.map { cast in
                    MovieDetailsSectionItem.cast(cast)
                }
                snapshot.appendItems(castItems, toSection: MovieDetailsLayoutSection.cast)

                self.setupDataSource(withSnapshot: snapshot)
            }
        }
    }
}
