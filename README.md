# Movie Booking System

Sample movie booking system implemented in rails.
Database schema: [Link](https://ibb.co/PZ9GtC2)

# Setup
 - Installation
 ```
 bundle install
 ```

 - Run the server
 ```
 rails s -p 8080
 ```
 
 - Running tests
 ```
 JRUBY_OPTS="--debug" bundle exec rspec
 ```

 OR

 - Dockerized setup
 ```
 docker build -t movie-booking-system:v1 .
 docker run -p 8080:8080 movie-booking-system:v1  
 ```
