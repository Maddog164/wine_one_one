# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* This Wine_One_One Application was written using the rails (version 6.0.3.4) framework of ruby version 2.6.1p33

* System dependencies

* Configuration

* The database is comprised of four tables - User, Wine, Food, and Pairings.
    A wine belongs to a user
    A Wine has many foods through pairings
    A food has many wines through pairings
    The pairings join table also contains a user-submittable attribute 'pairing_type'
    There is also a TastingNotes table, the functionality of which has not been built out

* The database was initially built by generating basic migration files. There are two additional migration files - adding user_id to wines and adding provider to users

* How to run the test suite

* This application makes use of the omniauth gem to allow users to Sign Up and LogIn with their Google account credentials

* Deployment instructions

* ...
