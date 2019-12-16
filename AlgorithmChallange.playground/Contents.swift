import Foundation

struct Trip {
    let id: NSUUID
    let currentTotalPrice: Int
}

func findUserTrip(forPrice price: Int, in trips: [Trip]) -> Trip? {
    trips.min(by: { abs($0.currentTotalPrice - price) < abs($1.currentTotalPrice - price) })
}


let trip1 = Trip(id: NSUUID(), currentTotalPrice: 5)
let trip2 = Trip(id: NSUUID(), currentTotalPrice: 55)
let trip3 = Trip(id: NSUUID(), currentTotalPrice: 53)
let trip4 = Trip(id: NSUUID(), currentTotalPrice: 51)
let trip5 = Trip(id: NSUUID(), currentTotalPrice: 15)
let trip6 = Trip(id: NSUUID(), currentTotalPrice: 123)
let trip7 = Trip(id: NSUUID(), currentTotalPrice: 5324)


let tripArray = [trip1,trip2,trip3,trip4,trip5,trip6,trip7]

print(findUserTrip(forPrice: 204, in: tripArray)!.currentTotalPrice)
