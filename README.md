#Boston Bar Review

[ ![Codeship Status for aimeebachari/boston-bar-review](https://app.codeship.com/projects/41a46fe0-bf10-0134-42bb-7a625a3fabd4/status?branch=master)](https://app.codeship.com/projects/196483)

![Code Climate](https://codeclimate.com/github/aimeebachari/boston-bar-review.png)

![Coverage Status](https://coveralls.io/repos/aimeebachari/boston-bar-review/badge.png)


Boston Bar Review is a group project undertaken by Launch Academy apprentices to demonstrate full stack and git version workflow skills. Users can review Boston bars, rate them, and also upvote or downvote other users' reviews.

##Getting Started

###This project uses the following components:

* Ruby 2.2.5

* Rails 5

* CarrierWave/Fog

* PostgreSQL

* React

* Fetch

* Javascript

* Foundation

##Demo

Visit our Heroku page, (https://boston-bar-review.herokuapp.com/ "Boston Bar Review")

##Set up Rails

``git clone https://github.com/aimeebachari/boston-bar-review
cd boston-bar-review
bundle install
rake db:create
rake db:migrate```

##Set up Webpack

`npm install`

To store image, you will need to sign up for Amazon Web Services. Once you have your AWS secret keys, create a .env file in the root directory, and add the keys:

`AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY>
AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_ACCESS_KEY>
S3_BUCKET=<YOUR_S3_BUCKET>`

##Run the application

Run the following commands in your terminal from `Boston Bar Review` directory:

`rails s
npm start`

Open the browser and enter `localhost:3000`.

##Testing

To run the test suite, type `rake` in the terminal.
