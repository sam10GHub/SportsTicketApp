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
    @IBOutlet weak var imageSport: UIImageView!
    
    private var currentEventIndex = 0
    private var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style the buttons
        let buttons = [buyNowButton, nextEventButton, websiteButton]
        buttons.forEach { button in
            button?.layer.cornerRadius = 10
            button?.layer.shadowColor = UIColor.black.cgColor
            button?.layer.shadowOffset = CGSize(width: 0, height: 2)
            button?.layer.shadowRadius = 4
            button?.layer.shadowOpacity = 0.2
        }
        
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
                  websiteUrl: "https://www.nfl.com/super-bowl"),
            
            Event(name: "FIFA World Cup Final 2026", 
                  date: "July 19, 2026",
                  description: "The world's most-watched sporting event! Experience the magic of the FIFA World Cup Final live in person.",
                  venue: "MetLife Stadium",
                  price: 899.99,
                  imageUrl: "world_cup",
                  websiteUrl: "https://www.fifa.com"),
            
            Event(name: "NHL Winter Classic 2025", 
                  date: "January 1, 2025",
                  description: "Hockey returns to its outdoor roots! Watch two NHL teams battle it out under the open sky in this unique winter spectacle.",
                  venue: "Fenway Park",
                  price: 249.99,
                  imageUrl: "winter_classic",
                  websiteUrl: "https://www.nhl.com/winterclassic")
        ]
    }
    
    private func displayCurrentEvent() {
        let event = events[currentEventIndex]
        
        // Apply shadow and corner radius to image
        imageSport.layer.cornerRadius = 15
        imageSport.layer.shadowColor = UIColor.black.cgColor
        imageSport.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageSport.layer.shadowRadius = 4
        imageSport.layer.shadowOpacity = 0.3
        imageSport.clipsToBounds = true
        
        // Style the text view
        lblDescription.layer.cornerRadius = 10
        lblDescription.layer.borderWidth = 1
        lblDescription.layer.borderColor = UIColor(red: 0.7, green: 0.65, blue: 0.55, alpha: 1.0).cgColor
        lblDescription.backgroundColor = UIColor(red: 1, green: 0.95, blue: 0.9, alpha: 1.0)
        
        // Style the price and venue labels
        lblPrice.layer.cornerRadius = 8
        lblVenue.layer.cornerRadius = 8
        lblPrice.backgroundColor = UIColor(red: 0.95, green: 0.9, blue: 0.8, alpha: 1.0)
        lblVenue.backgroundColor = UIColor(red: 0.95, green: 0.9, blue: 0.8, alpha: 1.0)
        
        // Add gradient to the event name
        lblName.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        lblName.textColor = UIColor(red: 0.4, green: 0.3, blue: 0.2, alpha: 1.0)
        
        // Set the content
        lblName.text = event.name
        lblDate.text = "Date: \(event.date)"
        lblDescription.text = event.description
        lblVenue.text = event.venue
        lblPrice.text = String(format: "$%.2f", event.price)
        
        if let image = UIImage(named: event.imageUrl) {
            imageSport.image = image
            imageSport.contentMode = .scaleAspectFill
        }
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
                  let numberOfTicketsStr = textField.text,
                  let numberOfTickets = Int(numberOfTicketsStr),
                  numberOfTickets > 0 else {
                // Show error for invalid input
                self?.showError(message: "Please enter a valid number of tickets")
                return
            }
            
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
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Error",
                                    message: message,
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

