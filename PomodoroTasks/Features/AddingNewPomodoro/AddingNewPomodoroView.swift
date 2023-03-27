import SwiftUI
import ComposableArchitecture

struct AddingNewPomodoroView: View {
    let store: StoreOf<AddingNewPomodoroFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                Picker(
                    selection: viewStore.binding(get: \.type, send: AddingNewPomodoroFeature.Action.selectedType),
                    content: {
                        ForEach(PomodoroType.allCases) { type in
                            Text(type.rawValue)
                                .tag(type)
                        }
                    },
                    label: {}
                )
                .pickerStyle(.segmented)

                TextField(
                    "Minutes",
                    text: viewStore.binding(get: {
                        if let time = $0.timeInMinutes { return "\(time)" }
                        return ""
                    }, send: AddingNewPomodoroFeature.Action.typeTime)
                )
                .multilineTextAlignment(.center)
                .scaledToFit()
                .frame(maxWidth: 100)

                Button("Done", action: { viewStore.send(.done) })
                    .disabled(!viewStore.isTimeValid)
            }
            .padding(16)
            .frame(width: 200)
        }
    }

}

struct AddingNewPomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        let store = StoreOf<AddingNewPomodoroFeature>(
            initialState: .init(),
            reducer: AddingNewPomodoroFeature()
        )

        return AddingNewPomodoroView(store: store)
    }
}
