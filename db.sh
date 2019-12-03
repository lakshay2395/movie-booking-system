#!/bin/sh
date "+%Y%m%d%H%M%S"
rails generate model Theatre name:string regions:references
rails generate model Hall name:string address:string seats:integer theatre:references
rails generate model Movie name:string director_name:string release_date:date is_active:boolean
rails generate model Timing name:string start_time:time end_time:time
rails generate model User first_name:string last_name:string email_id:string:unique password:string
rails generate model Show movie:references hall:references show_date:date timing:references available_seats:integer seat_price:float
rails generate model Booking user:references show:references seats:integer