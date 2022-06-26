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
    var coordinator: MoviesCoordinator?

    var movieByGenreRegistration: UICollectionView.CellRegistration<MovieByGenreCollectionViewCell, SectionItem>!

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

    func sortDataSource(withItems items: [SectionItem]) {

        var snapshot = NSDiffableDataSourceSnapshot<MoviesByGenreLayoutSection, SectionItem>()
        snapshot.appendSections([.movies])
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

        movieByGenreRegistration = .init(cellNib: MovieByGenreCollectionViewCell.nib, handler: { (cell, _, item) in
            cell.setup(withItem: item)
        })
    }

    func bindData() {

        viewModel.movies.bind { movies in
            if let movies = movies, !movies.isEmpty {
                self.sections.append(Section(title: String(), layout: .movies, items: movies))
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
            case .movies:
                return collectionView.dequeueConfiguredReusableCell(using: self.movieByGenreRegistration, for: indexPath, item: item)
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
