import UIKit

extension UIImage {
    // MARK: - Initializer
    fileprivate class func initialize(with name: String) -> UIImage {
        return UIImage(
            named: name,
            in: Bundle.main,
            compatibleWith: nil
        )?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    }

    static var meliLogoImage: UIImage {
        return initialize(with: "MeliLogoImg")
    }

    static var defaultProductNotFoundImage: UIImage {
        return initialize(with: "DefaultProductNotFoundImage")
    }
}
