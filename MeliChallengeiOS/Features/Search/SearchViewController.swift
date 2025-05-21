import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    // MARK: - Properties
    private lazy var extempleView: UIView = {
        $0.backgroundColor = .red
        return $0
    }(UIView())
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - View Componentes

    // MARK: - Public Methods
}

// MARK: - Private Extension
private extension SearchViewController {
    // MARK: Setup View
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        additionalConfigurations()
    }

    func buildViewHierarchy() {
        view.addSubview(extempleView)
    }

    func setupConstraints() {
        extempleView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func additionalConfigurations() {
        view.backgroundColor = .green
    }
}
