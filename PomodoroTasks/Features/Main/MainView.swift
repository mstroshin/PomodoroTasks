import SwiftUI
import ComposableArchitecture
import SwiftUINavigation

struct MainView: View {
    let store: StoreOf<MainFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                weekDaysPicker(viewStore)

                DayView(store: store.scope(state: \.selectedDay, action: MainFeature.Action.day))
            }
            .frame(width: 300)
            .padding()
        }
    }

    private func weekDaysPicker(_ viewStore: ViewStoreOf<MainFeature>) -> some View {
        Picker(selection: viewStore.binding(get: \.selectedDay.id, send: MainFeature.Action.dayPressed)) {
            ForEach(viewStore.days) { day in
                Text(day.title)
                    .tag(day.id)
            }
        } label: {}
        .pickerStyle(.segmented)
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let weekDates = IdentifiedArray(uniqueElements: Date.weekDates.map {
            DayFeature.State(date: $0)
        })

        let store = StoreOf<MainFeature>(
            initialState: .init(days: weekDates, selectedDay: weekDates[0]),
            reducer: MainFeature()
        )
        return MainView(store: store)
    }
}
