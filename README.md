# Marvel Promoter

The [marvel-promoter](https://github.com/BrandonTruter/marvel-promoter) repository is an assessment project for integrating with the [MarvelAPI](http://developer.marvel.com/docs) and displaying a character with associated series collections.

## Dependencies

Before you begin, ensure you have met the following requirements:  
  - Node >= v12.0
  - Ruby >= v3.0
  - Rails >= v6.0

## Getting Started

Clone the repo

```bash
git clone git@github.com:BrandonTruter/marvel-promoter.git
```

Navigate to project

```bash
cd marvel-promoter
```

Checkout this branch

```bash
git checkout develop
```

Install app dependencies

```bash
# gems
bundle install

# yarn
yarn install
```

Start the servers

```bash
```sh
# Terminal tab 1 (rails)
rails s

# Terminal tab 2 (webpack)
./bin/webpack-dev-server
```

You should now see the character landing page if you can navigate to `localhost:3000` in your browser.

Marvel Character
![landing_page](readme_images/marvel_character.png)

Collection of series featuring the character
![landing_page](readme_images/series_collections.png)
