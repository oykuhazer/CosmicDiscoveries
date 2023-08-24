# CosmicDiscoveries

[Click here to watch the video of the app](https://youtu.be/e8NlalYOQ_o)

The Cosmic Discoveries App is an iOS application built on the foundation of the **MVVM architecture**. It offers users a visually stunning experience that draws them into the depths of the universe. The app manages data exchange using powerful frameworks such as **Alamofire, URLSession and Combine**. Leveraging the capabilities of Modern Swift, the Cosmic Discoveries App effectively operates with JSON data. It utilizes the **Codable** and **Decodable** protocols to model and parse the data.

## Main Screen

<p align="center">
  <img src="https://github.com/oykuhazer/CosmicDiscoveries/assets/130215854/bfb52f78-28ad-4d0c-819a-deebd39f97bd" alt="zyro-image" width="200" height="450">
</p>

On the main page, visually rich content is presented to users who are eager to explore the mysteries of space. Through a UICollectionView, users can browse through captivating images and headlines related to the universe. This page boasts a clean and modern design, capturing attention with customized shading effects and background colors on each cell.

## APOD by Date Screen

<p align="center">
  <img src="https://github.com/oykuhazer/CosmicDiscoveries/assets/130215854/d5fa3397-e82d-4b56-8161-5d2cad1835fd" alt="zyro-image" width="200" height="450" />
  <img src="https://github.com/oykuhazer/CosmicDiscoveries/assets/130215854/32fbf7a3-ceba-4fdd-b14e-048c56154085" alt="zyro-image" width="200" height="450" />
  <img src="https://github.com/oykuhazer/CosmicDiscoveries/assets/130215854/ddeac3f5-1a80-45c9-ae87-1abf5ac0af7a" alt="zyro-image" width="200" height="450" />
  </p>

On the 'APOD by Date' page, users can view 'Astronomy Picture of the Day' (APOD) content for the date of their choice using a date selector (UIDatePicker). The title, description, and image for the selected date are automatically updated. While managing data exchange with Alamofire, this page seamlessly integrates UI updates with the Combine framework.

## Favorites Screen

<p align="center">
  <img src="https://github.com/oykuhazer/CosmicDiscoveries/assets/130215854/7527a20b-ef85-4058-9149-73fbe51c6d9d" alt="zyro-image" width="200" height="450" />
  <img src="https://github.com/oykuhazer/CosmicDiscoveries/assets/130215854/0ad4bbbb-2fde-4e88-a7c9-69044fa8833d" alt="zyro-image" width="200" height="450" />
  <img src="https://github.com/oykuhazer/CosmicDiscoveries/assets/130215854/f14abbe5-9798-4f67-9b7f-643971f88dfb" alt="zyro-image" width="200" height="450" />
  </p>

The 'Favorites' page presents users with a collection where they can store their favorite dates. Using User Defaults, these favorite dates are managed, and the user interface is created through UIKit and UITableView. Users can delete favorite dates by swiping the cells.

## Weekly News Screen

<p align="center">
  <img src="https://github.com/oykuhazer/CosmicDiscoveries/assets/130215854/e3d06ce1-7c1b-4f6d-84e7-4d47054eecdc" alt="zyro-image" width="200" height="450" />
  <img src="https://github.com/oykuhazer/CosmicDiscoveries/assets/130215854/9a7ac4a8-5fba-4608-adde-774bb3c50241" alt="zyro-image" width="200" height="450" />
  </p>
The 'Weekly News' page offers a collection of space news. Represented using a UICollectionView, this collection fetches space news from an API using Alamofire. Users can view details by clicking on the news articles. On this page as well, the collection updates are managed using Combine.

## More Information Screen

<p align="center">
  <img src="https://github.com/oykuhazer/CosmicDiscoveries/assets/130215854/158f0d8a-4178-404c-9a34-c0f73b5d7023" alt="zyro-image" width="200" height="450" />
   <img src="https://github.com/oykuhazer/CosmicDiscoveries/assets/130215854/71a47a97-6e31-4fe5-80b8-bf4277f5b762" alt="zyro-image" width="200" height="450" />
  <img src="https://github.com/oykuhazer/CosmicDiscoveries/assets/130215854/3c13f0b2-3141-47e0-ab77-3902373f9eb2" alt="zyro-image" width="200" height="450" />
  </p>

On the 'More Information' page, users can view a list encompassing various space topics. Represented using a UITableView, this list fetches data using Alamofire. The sections of the TableView can be dynamically expanded and collapsed. By clicking on the titles, users are directed to pages with more detailed information.














  
</p>
