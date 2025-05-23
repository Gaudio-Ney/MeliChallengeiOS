import UIKit

final class ListingProductsViewController: UIViewController {
    // MARK: - Properties

    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - View Componentes

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

    }

    func setupConstraints() {

    }

    func additionalConfigurations() {
        view.backgroundColor = .backgroundWhite
        title = "Lista da Busca"
    }
}

