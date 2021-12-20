import SwiftUI

struct AuthenticationView: View {
   
    @ObservedObject
    var viewModel: AuthenticationViewModel
    
    var body: some View {
        Text("Loading")
    }
}

extension View {
    func authenticated() -> some View {
        modifier(AuthenticationModifier())
    }
}

struct AuthenticationModifier: ViewModifier {
    func body(content: Content) -> some View {
        let viewModel = AuthenticationViewModel()
        let view = AuthenticationView(viewModel: viewModel)
        
        return content
            .onAppear(perform: viewModel.authenticate)
            .fullScreenCover(
                isPresented: view.$viewModel.isPresented,
                onDismiss: nil) { view }
    }
}
