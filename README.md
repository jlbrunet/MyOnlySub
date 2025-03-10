<br />
<a name="readme-top"></a>
<br />
<div align="center">
  <a href="https://github.com/jlbrunet/portfolio">
    <img src="app/assets/images/logomos.png" alt="Logo" width="100" height="40">
  </a>
  <h3 align="center">My Only Sub</h3>
  <p align="center">
     This application allows the user to create a list with a selection of movies and series to watch on streaming platforms and an available number of hours to watch them during the month. From this list and availability, the application renders the platform to subscribe the following month and the movies and series to watch. It allows the user to subscribe to one platform only each month and not to accumulate subscriptions. 
    <br />
    <br />
  </p>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#installation">Available scripts</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
  <br />
</details>


## About The Project

<br />
<div align="center"><img src="app/assets/images/mosImage.png" alt="presentation of portfolio" width="400" height="350"></div>
<br />

<div>This project has two main features :
  <ul>
    <li><b>The streaming platform to subscribe for the following month:</b> the user create a list with a selection of movies and series to watch on streaming platforms and an available number of hours to watch them during the month. From this list and availability, the application renders the platform to subscribe the following month and the movies and series to watch. It allows the visitor to subscribe to one platform only each month and not to accumulate subscriptions. </li>
    <li><b>A social feature:</b> the user can mark movies and series as favorites and share their list with friends</li>
  </ul>
</div>


### Built With

* [![Ruby.com][Ruby.com]][Ruby-url]
* [![RoR.com][RoR.com]][RoR-url]
* [![PostgreSql.com][PostgreSql.com]][PostgreSql-url]
* [![Bootstrap.com][Bootstrap.com]][Bootstrap-url]
<br />

## Getting Started

### Prerequisites

Make sure you have the following installed on your system:

* [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
* [Rails](https://guides.rubyonrails.org/getting_started.html#installing-rails)
* [Node.js](https://nodejs.org/)
* [npm](https://www.npmjs.com/)
* [PostgreSQL](https://www.postgresql.org/download/)

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/jlbrunet/MyOnlySub.git
   ```
2. Install dependencies
   ```sh
   yarn install
   ```
   ```sh
   bundle install
   ```
3. Set up the database
   ```sh
   rails db:create
   ```
   ```sh
   rails db:migrate
   ```

  
### Available Scripts

Runs the app in the development mode :
```sh
dev
```

<br />

## Roadmap

- [x] Implement the streaming platform to subscribe for the following month
    - [x] Implement a homepage with carousel of recent movies and series by streaming platform and by type (comedy, horror,...) and a searchbar. The user can add a movie/serie to their list and/or to their favorite. 
    - [x] Implement a wishlist page with all the movies/series added and the possibility to order them by priority. The user can also add their availability time for the next month. 
    - [x] Implement a sub page where the user can see the optimise platform to subscribe for the following month with the list of movies/series associated.
- [x] Impletement the social feature
    - [x] Implement a social page where the user can see their favorites and the favorites of their friends

## Contact

juliebrunet.pro@outlook.fr

[https://github.com/jlbrunet/portfolio](https://github.com/jlbrunet/portfolio)

<!-- MARKDOWN LINKS & IMAGES -->
[Ruby.com]: https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[Ruby-url]: https://www.ruby-lang.org/fr/
[RoR.com]: https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white
[RoR-url]: https://rubyonrails.org/
[PostgreSql.com]: https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white
[PostgreSql-url]: https://www.postgresql.org/
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
