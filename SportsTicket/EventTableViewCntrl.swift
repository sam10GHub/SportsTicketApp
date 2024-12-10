import UIKit

class EventTableViewController: UITableViewController {
    
    private var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EventCell")
        
        // Set up navigation
        title = "Sports Events"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Load events
        setupEvents()
    }
    
    private func setupEvents() {
        events = [
            Event(name: "NBA Finals 2024", 
                  date: "June 15, 2024",
                  description: "Experience the ultimate basketball showdown at the NBA Finals 2024!",
                  venue: "Madison Square Garden",
                  price: 299.99,
                  imageUrl: "nba_finals",
                  websiteUrl: "https://www.nba.com/finals"),
            Event(name: "Super Bowl LIX",
                  date: "February 11, 2024",
                  description: "Watch the biggest game in American football live!",
                  venue: "Allegiant Stadium",
                  price: 499.99,
                  imageUrl: "super_bowl",
                  websiteUrl: "https://www.nfl.com/super-bowl"),
            Event(name: "Wimbledon Finals",
                  date: "July 14, 2024",
                  description: "Witness tennis excellence at the prestigious Wimbledon Championships.",
                  venue: "All England Club",
                  price: 399.99,
                  imageUrl: "wimbledon",
                  websiteUrl: "https://www.wimbledon.com"),
            Event(name: "FIFA World Cup Final",
                  date: "December 18, 2024",
                  description: "The world's most watched sporting event comes to its thrilling conclusion!",
                  venue: "Lusail Stadium",
                  price: 599.99,
                  imageUrl: "world_cup",
                  websiteUrl: "https://www.fifa.com/worldcup"),
            Event(name: "UFC 300",
                  date: "April 13, 2024",
                  description: "An historic night of mixed martial arts featuring championship bouts!",
                  venue: "T-Mobile Arena",
                  price: 199.99,
                  imageUrl: "ufc_300",
                  websiteUrl: "https://www.ufc.com"),
            Event(name: "MLB World Series 2024",
                  date: "October 20, 2024",
                  description: "Baseball's fall classic brings the season to an epic conclusion!",
                  venue: "Yankee Stadium",
                  price: 249.99,
                  imageUrl: "world_series",
                  websiteUrl: "https://www.mlb.com/postseason")
        ]
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        let event = events[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = event.name
        content.secondaryText = "\(event.date) - \(event.formattedPrice)"
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "EventDetailVC") as? ViewController {
            detailVC.currentEventIndex = indexPath.row
            navigationController?.pushViewController(detailVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}