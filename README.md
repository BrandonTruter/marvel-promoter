# Marvel Promoter

The [marvel-promoter](https://github.com/BrandonTruter/marvel-promoter) repository is a solution to the [promote](https://promoteint.com) assessment for integrating with the [MarvelAPI](http://developer.marvel.com/docs) and display a character with associated series collections.

## Dependencies

Before you begin, ensure you have met the following requirements:

  * Recommended versions for `Ruby, Rails, Node`
    * Node >= v12.0
    * Ruby >= v3.0
    * Rails >= v6.0

## Technologies

The application was built using:
  - Node v16.10.0
  - Ruby v3.0.2
  - Rails v6.1.4.1
  - RSpec-rails v5.0.2
  - Webpacker v5.4.3
  - Tailwind v2.2.14

## Getting Started

- Cloning the repository:

      git clone git@github.com:BrandonTruter/marvel-promoter.git

- Navigating to the directory:

      cd marvel-promoter

- Installing application dependencies:

  ```sh
  # gems
  bundle install

  # yarn
  yarn install
  ```

- Starting application servers:

  ```sh
  # Terminal tab 1 (rails)
  rails s

  # Terminal tab 2 (webpack)
  ./bin/webpack-dev-server
  ```

- Running all the tests

      rspec spec


Once your servers are up and running you can open `localhost:3000` in the browser and should see the following:

Marvel Character
![landing_page](readme_images/marvel_character.png)

Collection of series featuring the character
![landing_page](readme_images/series_collections.png)
