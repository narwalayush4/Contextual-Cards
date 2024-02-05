# Contextual-Cards

This iOS app fetches cards data and attributes from an API endpoint and formats the UI based on the received data.

## Usage

This repository contains the code for the Contextual Cards SwiftUI assignment.

The main SwiftUI view is called `ContextualCardsView`, which contains links to all the major destinations.

The app supports different types of cards, each implemented as a separate SwiftUI view:

- `HC3CardsView`: A SwiftUI view containing cards of type "HC3". Each card has an action button, a background image, and some text. The view is split into subviews for cleaner code:

  - `HC3MainCardView`: This view mainly contains the cards.
  - `HC3ActionView`: This view is hidden behind `HC3MainCardView` and is shown on long press. It has two buttons:
    - "Remind Later": Tapping this button removes the card from the display. The card will be shown again on the next app start.
    - "Dismiss Now": Tapping this button removes the card from the display permanently.

- `HC6CardsView`: A SwiftUI view containing cards of type "HC6". Each card has an icon image and some text.
- `HC5CardsView`: A SwiftUI view containing cards of type "HC5". Each card has only a background image.
- `HC9CardsView`: A SwiftUI view containing cards of type "HC9". Each card contains gradients.
- `HC1CardsView`: A SwiftUI view containing multiple cards of type "HC1". Each card has an icon image and some text.

## Utilities

### Network Manager

- The `NetworkManager` class is responsible for fetching data from a specified URL. It uses Combine framework publishers to perform the network request and handle the response asynchronously.

##### Usage

1. Create an instance of `NetworkManager`.
2. Call the `fetchData` method, passing a completion handler to be executed when the data is fetched successfully.
3. The completion handler is called with the decoded data from the API response.

```swift
let networkManager = NetworkManager()
do {
    try await networkManager.fetchData {
        // Handle the fetched data
        print(networkManager.wcElement)
    }
} catch {
    // Handle errors
    print("Error fetching data: \(error)")
}
```

##### Handling Network Responses

The handleOutput method is used to validate the HTTP response. It checks if the response status code is within the success range (200-299). If not, it throws a URLError

### UIImage Extension - Asynchronous Image Loading

- The extension on `UIImage` provides a convenience initializer for loading images asynchronously from a URL string. It uses Swift's concurrency features (async/await) and the URLSession dataTaskPublisher.

##### Usage

```swift
// Example: Load an image asynchronously
let imageURLString = "https://example.com/image.jpg"
do {
    let image = try await UIImage(urlString: imageURLString)
    // Use the loaded image
} catch {
    // Handle errors
    print("Error loading image: \(error)")
}
```

### Refreshable Scroll View Modifier
- The `RefreshableScrollView` SwiftUI view is designed to provide a pull-to-refresh behavior in a scroll view. It takes an action closure to be executed when the user pulls down beyond a specified threshold.
- The `RefreshableScrollViewModifier` is a view modifier that simplifies the usage of RefreshableScrollView within SwiftUI views.

##### Usage
```swift
// Example: Using RefreshableScrollViewModifier
struct ContentView: View {
    var body: some View {
        Text("Your content")
            .modifier(RefreshableScrollViewModifier {
                // Your refresh action here
                print("Refreshing data...")
            })
    }
}
```

### Color Helper
- The `ColorHelper` class is a utility for converting hexadecimal color codes into corresponding `UIColor` objects. It follows the Singleton pattern by providing a shared instance (`shared`) for easy access throughout the app.

##### Usage 
```swift
// Example: Using ColorHelper to convert hex code to UIColor
let hexCode = "#3498db"
let color = ColorHelper.shared.color(from: hexCode)
// Use the obtained UIColor
```

### Prerequisites

- Xcode (Version X.X or later)
- SwiftUI knowledge
