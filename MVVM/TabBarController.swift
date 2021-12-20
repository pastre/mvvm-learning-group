import UIKit
import SwiftUI

final class MVVMTabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = self.getTabBars()
    }
    
    private func getTabBars() -> [UIViewController] {
        let vcs = [
            PokemonListViewController(),
            UIHostingController(rootView:
                                    ChatView()
                                    .authenticated()
                               ),
        ]
        
        let icons = [
            UIImage.add, 
            UIImage.checkmark
        ]
        
        let titles = [
            "Pokemons",
            "Chat"
        ]
        
        
        vcs.enumerated().forEach { (index, viewController) in
            let image = icons[index]
            let title = titles[index]
            viewController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        }
        
        let ret =  vcs.map { UINavigationController(rootViewController: $0) }
        
        ret.forEach {
            $0.navigationBar.prefersLargeTitles = true
            $0.navigationItem.largeTitleDisplayMode = .always
        }
        
        return ret
    }
}

