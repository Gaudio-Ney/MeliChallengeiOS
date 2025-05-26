import UIKit
import SnapKit
import Kingfisher

final class ProductDetailViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: ProductDetailViewModelProtocol
    
    // MARK: - Initializers
    init(viewModel: ProductDetailViewModelProtocol) {
        self.viewModel = viewModel
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
    private lazy var mainScrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UIScrollView())

    private lazy var nameLabel: UILabel = {
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.numberOfLines = 3
        $0.textColor = .black
        return $0
    }(UILabel())

    private lazy var imageView: UIImageView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        return $0
    }(UIImageView())

    private lazy var priceLabel: UILabel = {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.numberOfLines = 0
        $0.textColor = .black
        return $0
    }(UILabel())

    private lazy var freeShippingLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.numberOfLines = 1
        $0.text = ProductDetailStrings.freeShippingTitle.localized
        $0.textColor = .successGreen
        $0.isHidden = true
        return $0
    }(UILabel())

    private lazy var quantityLabel: UILabel = {
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .black
        return $0
    }(UILabel())

    private lazy var mainVerticalStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 16
        return $0
    }(UIStackView())

    private lazy var verticalEmptyView: UIView = {
        $0.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        return $0
    }(UIView())

    // MARK: - Public Methods
}

// MARK: - Private Extension
private extension ProductDetailViewController {
    // MARK: Setup View
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        additionalConfigurations()
    }

    func buildViewHierarchy() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainVerticalStack)
        mainVerticalStack.addArrangedSubview(nameLabel)
        mainVerticalStack.addArrangedSubview(imageView)
        mainVerticalStack.addArrangedSubview(priceLabel)
        mainVerticalStack.addArrangedSubview(quantityLabel)
        mainVerticalStack.addArrangedSubview(freeShippingLabel)
    }

    func setupConstraints() {
        mainScrollView.snp.makeConstraints { 
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        mainVerticalStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.width.equalTo(view.bounds.width - 32)
            $0.bottom.equalToSuperview().inset(16)
        }

        imageView.snp.makeConstraints {
            $0.height.equalTo(400)
        }
    }

    func additionalConfigurations() {
        view.backgroundColor = .white
        title = ProductDetailStrings.detailNavigationBarTitle.localized
        let product = viewModel.getProduct()
        setupCellUIComponents(with: product)
    }
}

// MARK: - Private Methods
private extension ProductDetailViewController {
    func setupCellUIComponents(with product: Product) {
        guard let price = product.price,
              let name = product.name else {
            view.isHidden = true
            return
        }

        nameLabel.text = name
        priceLabel.text = price.formatPrice()

        if let freeShipping = product.freeShipping {
            freeShippingLabel.isHidden = freeShipping ? false : true
        }

        if let quantity = product.quantity {
            quantityLabel.text = ProductDetailStrings.productQuantityDescription.localized + String(quantity)
        }

        let defaultImage = UIImagePlaceholder()
        imageView.kf.setImage(
            with: URL(string: product.imageURL ?? ""),
            placeholder: defaultImage
        )
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
    }
}
