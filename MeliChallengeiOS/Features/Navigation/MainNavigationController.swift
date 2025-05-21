import UIKit

final class MainNavigationController: UINavigationController {
    // MARK: - Properties

    // MARK: - Initializers

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = .clear

        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        navigationBar.tintColor = .clear
        navigationBar.isTranslucent = false
    }
}
