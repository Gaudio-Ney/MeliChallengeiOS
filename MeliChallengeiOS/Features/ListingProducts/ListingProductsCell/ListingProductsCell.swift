import Kingfisher
import SnapKit
import UIKit

final class ListingProductsCell: UICollectionViewCell { 
    // MARK: - Properties
    static let identifier = "ListingProductsCell"

    private var product: Product?

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Components
    private lazy var nameLabel: UILabel = {
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.numberOfLines = 3
        $0.textColor = .black
        return $0
    }(UILabel())

    private lazy var priceLabel: UILabel = {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.numberOfLines = 0
        $0.textColor = .black
        return $0
    }(UILabel())

    private lazy var freeShippingLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.numberOfLines = 1
        $0.text = ListingProductsCellStrings.freeShippingTitle.localized
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

    private lazy var imageView: UIImageView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        return $0
    }(UIImageView())

    private lazy var mainHorizontalStack: UIStackView = {
        $0.spacing = 6
        return $0
    }(UIStackView())

    private lazy var informationalVerticalStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 8
        return $0
    }(UIStackView())

    private lazy var verticalEmptyView: UIView = {
        $0.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        return $0
    }(UIView())

    // MARK: - Public Methods
    func updateCellWith(_ product: Product) {
        self.product = product
        setupCellUIComponents(with: product)
    }
}

// MARK: - Setup View
private extension ListingProductsCell {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        additionalConfigurations()
    }

    func buildViewHierarchy() {
        addSubview(mainHorizontalStack)

        mainHorizontalStack.addArrangedSubview(imageView)
        mainHorizontalStack.addArrangedSubview(informationalVerticalStack)

        informationalVerticalStack.addArrangedSubview(nameLabel)
        informationalVerticalStack.addArrangedSubview(priceLabel)
        informationalVerticalStack.addArrangedSubview(quantityLabel)
        informationalVerticalStack.addArrangedSubview(freeShippingLabel)
        informationalVerticalStack.addArrangedSubview(verticalEmptyView)
    }

    func setupConstraints() {
        mainHorizontalStack.snp.makeConstraints { 
            $0.top.equalToSuperview().offset(2)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(2)
        }

        imageView.snp.makeConstraints {
            $0.width.equalTo(150)
        }

        informationalVerticalStack.snp.makeConstraints { 
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().inset(12)
        }
    }

    func additionalConfigurations() {
        backgroundColor = .white
    }
}

// MARK: - Private Methods
private extension ListingProductsCell {
    func setupCellUIComponents(with product: Product) {
        guard let price = product.price,
              let name = product.name else {
            isHidden = true
            return
        }

        nameLabel.text = name
        priceLabel.text = price.formatPrice()

        if let freeShipping = product.freeShipping {
            freeShippingLabel.isHidden = freeShipping ? false : true
        }

        if let quantity = product.quantity {
            quantityLabel.text = ListingProductsCellStrings.productQuantityDescription.localized + String(quantity)
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

