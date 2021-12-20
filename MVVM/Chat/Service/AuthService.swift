import FirebaseAuth
import Combine

final class AuthService {
    enum AuthError: Error {
        case signInError
        case notSignedIn
    }
    
    var authPublisher: CurrentValueSubject<Result<String, AuthError>, Never> = .init(.failure(.notSignedIn))
    
    
    init() {
        authenticate()
    }
    
    func authenticate() {
        Auth.auth().signInAnonymously { [authPublisher] data, error in
            guard let user = data?.user else {
                authPublisher.send(.failure(.signInError))
                return
            }
            authPublisher.send(.success(user.uid))
        }
    }
}
