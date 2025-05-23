import SnapKit
import UIKit

final class SearchViewController: UIViewController {
    // MARK: - Properties
    let viewModel: SearchViewModelProtocol

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

    private lazy var doneButton: UIBarButtonItem = {
        return $0
    }(UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapToolbarDoneButton)))

    private lazy var toolbarView: UIToolbar = {
        $0.items?.append(doneButton)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIToolbar())

    private lazy var searchBarTextField: SearchTextField = {
        $0.delegate = self
        $0.layer.cornerRadius = 4
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
        view.addSubview(toolbarView)
    }

    func setupConstraints() {
        mainVerticalStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(200)
        }

        searchBarTextField.snp.makeConstraints {
            $0.height.equalTo(35)
        }

        searchButton.snp.makeConstraints { 
            $0.width.equalTo(mainVerticalStack.snp.width)
            $0.height.equalTo(45)
        }

        toolbarView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(44)
        }
    }

    func additionalConfigurations() {
        view.backgroundColor = .mainYellow
        title = SearchStrings.searchNavigationBarTitle.localized
        handleButtonStateDueTextInput(text: searchBarTextField.text)
    }
}

// MARK: - Private Methods
private extension SearchViewController {
    func handleButtonStateDueTextInput(text: String?) {
        searchButton.isEnabled = !(text?.isEmpty ?? true) && text != nil
        searchButton.backgroundColor = searchButton.isEnabled ? .mainBlue : .secondaryBlue
    }

    // MARK: - Objetive-C Methods
    @objc
    func didTapSearchButton() {
        viewModel.getSearch(inputValue: searchBarTextField.text?.lowercased())
        let viewController = ListingProductsFactory.makeSearchViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc
    func didTapToolbarDoneButton() {
        searchBarTextField.resignFirstResponder()
    }
}

// MARK: - SearchViewModelDelegate
extension SearchViewController: SearchViewModelDelegate {
    func showError() {
        UIAlert.showAlert(on: self, title: "Campo de busca faltante", message: "Preencha o campo de texto com o produto que deseja procurar.")
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
        return true;
    }
}
