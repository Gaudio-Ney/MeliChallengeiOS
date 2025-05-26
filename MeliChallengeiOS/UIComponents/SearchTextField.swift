import SnapKit
import UIKit

final class SearchTextField: UITextField {

    // MARK: - View Componentes
    private lazy var iconView: UIImageView = {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .mainBlue
        return $0
    }(UIImageView())

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
}

// MARK: - Private Extension
private extension SearchTextField {
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
        backgroundColor = .backgroundWhite
        leftView = buildIconViewWithPadding()
        leftViewMode = .always
    }
}

private extension SearchTextField {
    func buildIconViewWithPadding() -> UIView {
        let padding: CGFloat = 8
        let iconSize: CGFloat = 18
        let view = UIView(frame: CGRect(x: 0, y: 0, width: iconSize + padding * 2, height: iconSize))

        iconView.frame = CGRect(x: padding, y: 0, width: iconSize, height: iconSize)
        iconView.center = view.center
        view.addSubview(iconView)

        return view
    }
}
