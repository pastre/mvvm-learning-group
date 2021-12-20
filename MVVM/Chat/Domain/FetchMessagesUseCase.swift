import Combine

final class FetchMessagesUseCase {
    private let firebaseService = FirebaseService()
    private let authService = AuthService()
    
    private var cancelBag: [AnyCancellable] = []
    
    private var messagePublisher: PassthroughSubject<Message, Never> = .init()
    
    func onMessage() -> PassthroughSubject<Message, Never> {
        let cancellable = Publishers.Zip(
            firebaseService.messagePublisher,
            authService.authPublisher.mapError { $0 }
        ).sink { result in
            switch result {
            case .failure: break
            case .finished: break
            }
        } receiveValue: { messageDTO, authResult in
            guard case let .success(myId) = authResult else {
                return
            }
            self.messagePublisher.send(.init(
                content: messageDTO.content,
                amITheAuthor: messageDTO.authorId == myId
            ))
        }
        cancelBag.append(cancellable)
        return messagePublisher
    }
    
    deinit {
        cancelBag.removeAll()
    }
}
