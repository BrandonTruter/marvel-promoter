# Marvel Promoter

The [marvel-promoter](https://github.com/BrandonTruter/marvel-promoter) repository serves as a learning experience and integrates with the [MarvelAPI](http://developer.marvel.com/docs).

## TODO

### marvel_performance

Branch created for performance improvements, such as caching, profiling, etc

#### CACHE

##### Implementations

- rails caching

  - simple `rails cache` using `memcached-dalli` store

- http caching

  - based on API request, response, headers, etc

    - ETAG with `If-None-Match` headers

    - Last Modified Timestamp

    - GZIP Compression

- page caching

- modal caching

- fragment caching
