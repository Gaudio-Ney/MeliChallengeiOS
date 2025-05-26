import UIKit
import SnapKit

final class ListingProductsViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: ListingProductViewModelProtocol

    // MARK: - ViewComponents
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 4
        flowLayout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(ListingProductsCell.self, forCellWithReuseIdentifier: ListingProductsCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .backgroundWhite
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    // MARK: - Initializers
    init(viewModel: ListingProductViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
        viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Public Methods
}

// MARK: - Private Extension
private extension ListingProductsViewController {
    // MARK: Setup View
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        additionalConfigurations()
    }

    func buildViewHierarchy() {
        view.addSubview(collectionView)
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func additionalConfigurations() {
        view.backgroundColor = .backgroundWhite
        title = "Lista da Busca"
    }
}

// MARK: - Private Methods
private extension ListingProductsViewController {
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - ListingProductsViewModelProtocol
extension ListingProductsViewController: ListingProductViewModelDelegate {

}

// MARK: - UICollectionViewDelegate + UICollectionViewDataSource
extension ListingProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.getProducts().count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListingProductsCell.identifier,
            for: indexPath) as? ListingProductsCell else {
            return UICollectionViewCell()
        }
        let products = viewModel.getProducts()

        guard indexPath.row < products.count else {
            return UICollectionViewCell()
        }

        let cellProduct = products[indexPath.row]
        cell.updateCellWith(cellProduct)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let size = CGSize(
            width: self.collectionView.frame.width,
            height: 200
        )
        return size
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let products = viewModel.getProducts()

        guard indexPath.row < products.count else {
            return
        }

        let product = products[indexPath.row]
        let viewController = ProductDetailFactory.makeSearchViewController(product: product)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListingProductsViewController: UICollectionViewDelegateFlowLayout {

}

