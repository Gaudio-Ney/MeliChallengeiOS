import SnapKit
import UIKit

final class SearchViewController: UIViewController {
    // MARK: - Properties

    // MARK: - View Components
    private lazy var mainVerticalStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 16
        return $0
    }(UIStackView())

    private lazy var appLogoImageView: UIImageView = {
        $0.image = .meliLogoImage
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())

    private lazy var searchBar: SearchTextField = {
        $0.delegate = self
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        return $0
    }(SearchTextField())

    private lazy var searchButton: UIButton = {
        $0.setTitle(SearchStrings.searchButtonTitle.localized, for: .normal)
        $0.setTitleColor(.backgroundWhite, for: .normal)
        $0.backgroundColor = .mainBlue
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.addTarget(
            self,
            action: #selector(didTapSearchButton),
            for: .touchUpInside
        )
        $0.isEnabled = false
        return $0
    }(UIButton())

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
        view.addSubview(mainVerticalStack)
        mainVerticalStack.addArrangedSubview(appLogoImageView)
        mainVerticalStack.addArrangedSubview(searchBar)
        mainVerticalStack.addArrangedSubview(searchButton)
    }

    func setupConstraints() {
        mainVerticalStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(200)
        }

        searchBar.snp.makeConstraints {
            $0.height.equalTo(35)
        }

        searchButton.snp.makeConstraints { 
            $0.width.equalTo(mainVerticalStack.snp.width)
            $0.height.equalTo(45)
        }
    }

    func additionalConfigurations() {
        view.backgroundColor = .mainYellow
        title = SearchStrings.searchNavigationBarTitle.localized
    }

    // MARK: - Objetive-C Methods
    @objc
    func didTapSearchButton() {
        let viewController = ListingProductsFactory.makeSearchViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UITextFieldDelegate {

}
