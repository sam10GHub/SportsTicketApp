//
//  ViewController.swift
//  SportsTicket
//
//  Created by user269357 on 11/28/24.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblVenue: UILabel!
    @IBOutlet weak var lblDescription: UITextView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imageSport: UIImageView!
    
    private var currentEventIndex = 0
    private var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEvents()
        displayCurrentEvent()
    }
    
    private func setupEvents() {
        events = [
            Event(name: "NBA Finals 2024", 
                  date: "June 15, 2024",
                  description: "Experience the ultimate basketball showdown at the NBA Finals 2024! Watch the best teams battle for championship glory.",
                  venue: "Madison Square Garden",
                  price: 299.99,
                  imageUrl: "nba_finals",
                  websiteUrl: "https://www.nba.com/finals"),
            
            Event(name: "World Series 2024", 
                  date: "October 20, 2024",
                  description: "Don't miss the baseball event of the year! Watch history being made at the World Series 2024.",
                  venue: "Yankee Stadium",
                  price: 199.99,
                  imageUrl: "world_series",
                  websiteUrl: "https://www.mlb.com"),
            
            Event(name: "Super Bowl LIX", 
                  date: "February 9, 2025",
                  description: "The biggest game in football! Join us for Super Bowl LIX featuring the best teams in the NFL.",
                  venue: "Allegiant Stadium",
                  price: 499.99,
                  imageUrl: "super_bowl",
                  websiteUrl: "https://www.nfl.com/super-bowl")
        ]
    }
    
    private func displayCurrentEvent() {
        let event = events[currentEventIndex]
        
        lblName.text = event.name
        lblDescription.text = event.description
        lblVenue.text = event.venue
        lblPrice.text = String(format: "$%.2f", event.price)
        
        // Load image from assets
        imageSport.image = UIImage(named: event.imageUrl)
        imageSport.contentMode = .scaleAspectFit
    }
    
    @IBAction func nextEventTapped(_ sender: Any) {
        currentEventIndex = (currentEventIndex + 1) % events.count
        displayCurrentEvent()
    }
    
    @IBAction func buyNowTapped(_ sender: Any) {
        let event = events[currentEventIndex]
        let alert = UIAlertController(title: "Purchase Tickets",
                                    message: "How many tickets would you like to purchase?",
                                    preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.keyboardType = .numberPad
            textField.placeholder = "Number of tickets"
        }
        
        let purchaseAction = UIAlertAction(title: "Purchase", style: .default) { [weak self] _ in
            guard let textField = alert.textFields?.first,
                  let numberOfTickets = Int(textField.text ?? "0") else { return }
            
            let totalPrice = Double(numberOfTickets) * event.price
            self?.showPurchaseConfirmation(tickets: numberOfTickets, total: totalPrice)
        }
        
        alert.addAction(purchaseAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func showPurchaseConfirmation(tickets: Int, total: Double) {
        let alert = UIAlertController(title: "Purchase Successful!",
                                    message: "You have purchased \(tickets) ticket(s) for a total of $\(String(format: "%.2f", total))",
                                    preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func visitWebsiteTapped(_ sender: Any) {
        let event = events[currentEventIndex]
        if let url = URL(string: event.websiteUrl) {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true)
        }
    }
}

