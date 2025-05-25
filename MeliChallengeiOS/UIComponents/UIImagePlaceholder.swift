import Kingfisher
import UIKit

protocol UIImagePlaceholderProtocol: Placeholder {
    var image: UIImage? { get }
}

final class UIImagePlaceholder: UIImagePlaceholderProtocol {
    internal var image: UIImage?

    init(_ image: UIImage? = UIImage(systemName: "photo.fill")) {
        self.image = image
    }

    func add(to imageView: UIImageView) {
        imageView.image = image
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFill
    }

    func remove(from imageView: UIImageView) {
        imageView.image = nil
    }
}
