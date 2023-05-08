# Rent App

A platform connecting college students and local landlords to streamline the off-campus housing search process.

## Overview

Rent App aims to solve the problem of students struggling to find suitable off-campus housing and landlords having difficulty reaching their target market and managing rental applications. This platform allows students to create profiles, search for housing based on their preferences, and submit rental applications. Landlords can list their properties, review applications, and communicate with potential tenants.

The inspiration for this project comes from the difficulties faced by students and landlords during the off-campus housing search process.

## Prerequisites

- Ruby version 3.2.1

## Installation

1. Clone the repository:

```
  git clone https://github.com/lasteeh/rent-app.git
```

2. Install dependencies:

```
bundle install
```

3. Configure your database in config/database.yml file.

4. Create the database:

```
rails db:create

```

5. Initialize the database:

```
rails db:migrate

```

## Running the Application

1. Start the Rails server

```
rails server
```

2. Open your browser and navigate to (http://localhost:3000)

## Running Tests

To run the test suite, execute the following command:

```
bundle exec rspec
```

## Built With

Ruby on Rails
PostgreSQL (production)
