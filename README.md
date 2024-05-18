# Anime Search Application

## Overview

This mobile application is developed using the Flutter framework to allow users to search for anime titles and view relevant information. The application retrieves data from the Jikan API and displays it in a user-friendly manner. Key features include search functionality, result representation, and integration with YouTube for watching trailers.

## Features

### Search Functionality
- **Search Bar**: Users can input the name of the anime they want to search for.
- **Data Fetching**: Fetches data from the Jikan API using the endpoint `https://api.jikan.moe/v4/anime?q=<name_here>`.
- **Display Results**: Shows search results in a scrollable list, displaying the anime name, title, URL, and trailer thumbnail (if available).

### Result Representation
- **Anime Details**: Each search result displays the following information:
  - Anime name
  - Title
  - URL
  - Trailer thumbnail
- **User Interface**: Designed to be visually appealing and intuitive for easy navigation.

### Integration with YouTube
- **Trailer Viewing**: Redirects users to the YouTube app or website to watch trailers upon clicking a search result.
- **Error Handling**: Ensures smooth transitions and handles any errors or exceptions during redirection.

## Technical Requirements
- **Framework**: Developed using the Flutter framework for cross-platform compatibility.
- **API Calls**: Utilizes REST API calls to fetch data from the Jikan API.
- **Error Handling**: Implements mechanisms for handling network request errors and data parsing.
- **Compatibility**: Ensures compatibility with both Android and iOS platforms.
- **Code Practices**: Follows best practices for code organization, readability, and maintainability.

## Packages Used
- **carousel_slider: ^4.2.1**: For creating the AnimeCarousel.
- **shadow_overlay: ^1.0.5**: Adds visual enhancement to the UI.
- **shimmer: ^3.0.0**: Adds shimmer loading effects while fetching data.
- **url_launcher: ^6.2.6**: Launches URLs for watching trailers.

## User Interface

<img width="5560" alt="Group 21" src="https://github.com/Atharva-Werulkar/anime_search/assets/110187613/80b557fc-79c4-4f49-ad8b-892ecee5c866">



## Demonstration Video

https://github.com/Atharva-Werulkar/anime_search/assets/110187613/0e1aad3a-8c05-4a6f-80a8-4d32fb2d5ae0


## 💻Installation and Setup

1. **Clone the repository**:
    ```bash
    git clone https://github.com/Atharva-Werulkar/anime_search.git
    cd anime_search
    ```

2. **Install dependencies**:
    ```bash
    flutter pub get
    ```

3. **🧑🏻‍💻Run the application**:
    ```bash
    flutter run
    ```

## 📄License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🖊️Authors

- [Atharva Werulkar](https://github.com/Atharva-Werulkar) - (werulkaratharva@gmail.com)

## Contributing

Contributions are always welcome! Your feedback will help us grow as a developer and build better and more reusable apps.

Please adhere to this project's `code of conduct`.
