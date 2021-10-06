# Marvel Promoter

The [marvel-promoter](https://github.com/BrandonTruter/marvel-promoter) repository is an assessment project for integrating with the [MarvelAPI](http://developer.marvel.com/docs).

## Dependencies

Before you begin, ensure you have meet the following recommended requirements for `Ruby, Rails, Node`
  * Ruby >= v3.0
  * Rails >= v6.0
  * Node >= v12.0

## Technologies

The application was built using:
  - Node v16.10.0
  - Ruby v3.0.2
  - Rails v6.1.4.1
  - [RSpec-rails](https://github.com/rspec/rspec-rails) v5.0.2
  - [Webpacker](https://github.com/rails/webpacker) v5.4.3
  - [Tailwind CSS](https://tailwindcss.com) v2.2.14
  - [Yarn](https://classic.yarnpkg.com/en/) v1.22.11


## Getting Started

- Clone the repository:

      git clone git@github.com:BrandonTruter/marvel-promoter.git

- Navigate to project directory:

      cd marvel-promoter

- Install application dependencies:

  ```sh
  # Only required if they don't already exist on the local machine

  # yarn
  npm install --global yarn

  # tailwind
  yarn add tailwindcss
  ```

- Install project dependencies:

  ```sh
  # gems
  bundle install

  # yarn
  yarn install
  ```

- Start the application servers:

  ```sh
  # Terminal tab 1 (rails)
  rails s

  # Terminal tab 2 (webpack)
  ./bin/webpack-dev-server
  ```


Once your servers are up and running you can open `localhost:3000` in the browser and should see the following:

Marvel Character
![landing_page](readme_images/marvel_character.png)

Collection of series featuring the character
![landing_page](readme_images/series_collections.png)
