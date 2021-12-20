import Foundation
import Combine
final class AuthenticationViewModel: ObservableObject {
    
    private let authenticationService = AuthService()
    
    private var cancalBags: [AnyCancellable] = []
    
    @Published
    var isPresented: Bool = true
    
    func authenticate() {
        authenticationService.authPublisher.sink { result in
            switch result {
            case .success:
                self.isPresented = false
                self.objectWillChange.send()
            case .failure(.notSignedIn):
                self.authenticationService.authenticate()
            case .failure:
                print("Autenticacao falout!")
                return
            }
        }.store(in: &cancalBags)
    }
}
