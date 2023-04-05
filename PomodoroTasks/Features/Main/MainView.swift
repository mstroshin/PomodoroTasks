import SwiftUI
import ComposableArchitecture
import SwiftUINavigation

struct MainView: View {
    let store: StoreOf<MainFeature>

    var body: some View {
        WithViewStore(store, observe: \.selectedWeekDayIndex) { viewStore in
            VStack {
                weekDaysPicker(viewStore)

                DayView(store: store.scope(
                    state: { $0.days[$0.selectedWeekDayIndex] },
                    action: MainFeature.Action.day
                ))
            }
            .frame(width: 300)
            .padding()
        }
    }

    private func weekDaysPicker(_ viewStore: ViewStore<Int, MainFeature.Action>) -> some View {
        Picker(selection: viewStore.binding(send: MainFeature.Action.weekDayPressed)) {
            ForEach(Array(MainFeature.State.weekdayNames.enumerated()), id: \.offset) { index, day in
                Text(day)
                    .tag(index)
            }
        } label: {}
        .pickerStyle(.segmented)
    }

}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        let weekDates = IdentifiedArray(uniqueElements: Date.weekDates.map {
//            DayFeature.State(date: $0)
//        })
//
//        let store = StoreOf<MainFeature>(
//            initialState: .init(days: weekDates, selectedDay: weekDates[0]),
//            reducer: MainFeature()
//        )
//        return MainView(store: store)
//    }
//}
