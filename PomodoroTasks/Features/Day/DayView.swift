import SwiftUI
import ComposableArchitecture

struct DayView: View {
    let store: StoreOf<DayFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                ForEach(viewStore.tasks) { task in
                    Text("\(task.title)")
                }

                PlusButtonView(didPressAction: { viewStore.send(.addTaskPressed) })
                    .frame(width: 52, height: 52)
                    .foregroundColor(Color(hex: 0xBC60D4))
                    .popover(store: store.scope(state: \.$addingNewTask, action: DayFeature.Action.addingNewTask)) {
                        AddingNewTaskView(store: $0)
                    }
            }
        }
    }
}
