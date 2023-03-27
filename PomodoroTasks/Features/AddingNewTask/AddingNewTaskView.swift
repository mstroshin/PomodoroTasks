import SwiftUI
import ComposableArchitecture

struct AddingNewTaskView: View {
    let store: StoreOf<AddingNewTaskFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                TextField("Title", text: viewStore.binding(get: \.title, send: AddingNewTaskFeature.Action.type))
                    .frame(width: 200)
                
                Button("Done", action: { viewStore.send(.done) })
            }
            .padding(16)
        }
    }

}
