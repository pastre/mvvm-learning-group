import Combine
final class SendMessageUseCase {
    
    private let firebaseService = FirebaseService()
    private var authService: AuthService = AuthService()
    
    private var cancelBag: [AnyCancellable] = []
    
    func execute(using message: String) {
        
        authService.authPublisher.sink { _ in } receiveValue: { authResult in
            guard case let .success(userId) = authResult  else {
                return
            }
            self.firebaseService.add(message: .init(
                content: message, authorId: userId
            ))
        }.store(in: &cancelBag)
    }
}
