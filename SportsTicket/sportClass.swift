import Foundation

struct SportsTick {
    var eventName: String
    var eventDate: String
    var eventVenue: String
    var eventDescription: String
    var ticketPrice: Double
    var eventImage: String
    var eventWebsite: String
    var quantity: Int = 0
}

struct CartItem {
    var event: SportsTick
    var quantity: Int
}

struct Event {
    let name: String
    let date: String
    let description: String
    let venue: String
    let price: Double
    let imageUrl: String
    let websiteUrl: String
    
    var formattedPrice: String {
        return String(format: "$%.2f", price)
    }
}