import SnapKit
import UIKit

final class SearchViewController: UIViewController {
    // MARK: - Properties
    let viewModel: SearchViewModelProtocol

    private var screenWidth: Int {
        Int(view.window?.windowScene?.screen.bounds.size.width ?? 0)
    }

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

    private lazy var searchBarTextField: SearchTextField = {
        $0.delegate = self
        $0.layer.cornerRadius = 18
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        return $0
    }(SearchTextField())

    private lazy var searchButton: UIButton = {
        $0.addTarget(
            self,
            action: #selector(didTapSearchButton),
            for: .touchUpInside
        )
        $0.backgroundColor = .mainBlue
        $0.isEnabled = false
        $0.setTitle(SearchStrings.searchButtonTitle.localized, for: .normal)
        $0.setTitleColor(.backgroundWhite, for: .normal)
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        return $0
    }(UIButton())

    // MARK: - Initializers
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
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
        mainVerticalStack.addArrangedSubview(searchBarTextField)
        mainVerticalStack.addArrangedSubview(searchButton)
    }

    func setupConstraints() {
        mainVerticalStack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(200)
        }

        searchBarTextField.snp.makeConstraints {
            $0.height.equalTo(36)
        }

        searchButton.snp.makeConstraints { 
            $0.width.equalTo(mainVerticalStack.snp.width)
            $0.height.equalTo(45)
        }
    }

    func additionalConfigurations() {
        view.backgroundColor = .mainYellow
        title = SearchStrings.searchNavigationBarTitle.localized
        handleButtonStateDueTextInput(text: searchBarTextField.text)
        addTapGestureToBackground()
    }
}

// MARK: - Private Methods
private extension SearchViewController {
    func handleButtonStateDueTextInput(text: String?) {
        searchButton.isEnabled = !(text?.isEmpty ?? true) && text != nil
        searchButton.backgroundColor = searchButton.isEnabled ? .mainBlue : .secondaryBlue
    }

    func addTapGestureToBackground() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }

    // MARK: - Objetive-C Methods
    @objc
    func didTapSearchButton() {
        viewModel.getSearch(inputValue: searchBarTextField.text?.lowercased(), isMock: false)
    }

    @objc 
    func dismissKeyboard(){
        searchBarTextField.resignFirstResponder()
    }
}

// MARK: - SearchViewModelDelegate
extension SearchViewController: SearchViewModelDelegate {
    func updateCollectionViewWithResponse(products: [Product]) {
        let viewController = ListingProductsFactory.makeListingViewController(products: products)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showError(error: Error) {
        guard let erro = error as? APIError else {
            UIAlert.showAlert(on: self, title: SearchStrings.searchErroAlertTitle.localized, message: error.localizedDescription)
            return
        }
        UIAlert.showAlert(on: self, title: SearchStrings.searchErroAlertTitle.localized, message: erro.errorDescription)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        handleButtonStateDueTextInput(text: textField.text)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        handleButtonStateDueTextInput(text: textField.text)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
