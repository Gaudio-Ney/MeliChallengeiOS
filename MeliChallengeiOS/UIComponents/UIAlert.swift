import UIKit

enum AlertStyle {
    case `default`
    case destructive
    case cancel
}

struct AlertAction {
    let title: String
    let style: AlertStyle
    let handler: (() -> Void)?
}

final class UIAlert {

    static func showAlert(
        on viewController: UIViewController,
        title: String?,
        message: String?,
        actions: [AlertAction] = [AlertAction(title: "OK", style: .default, handler: nil)]
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        actions.forEach { action in
            let style: UIAlertAction.Style
            switch action.style {
            case .default: style = .default
            case .destructive: style = .destructive
            case .cancel: style = .cancel
            }

            let alertAction = UIAlertAction(title: action.title, style: style) { _ in
                action.handler?()
            }

            alertController.addAction(alertAction)
        }

        viewController.present(alertController, animated: true, completion: nil)
    }
}
