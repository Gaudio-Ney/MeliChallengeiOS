import UIKit

final class MainNavigationController: UINavigationController {
    // MARK: - Properties

    // MARK: - Initializers

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = .mainYellow

        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        navigationBar.backItem?.title = MainNavigationStrings.backButtonTitle.localized
        navigationBar.tintColor = .mainBlue
        navigationBar.isTranslucent = false
    }
}
