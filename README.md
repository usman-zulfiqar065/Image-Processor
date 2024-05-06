# Image Processor Rails Application

## Introduction

Welcome to the Image Processor Rails Application! This project is designed to process images and highlight specific words within them. It utilizes the power of the `rtesseract` and `rmagick` gems to achieve this functionality. Users can upload images, search for specific words within those images, and download the processed images with highlighted words.

<img width="1792" alt="Screenshot 2024-05-06 at 2 17 49 AM" src="https://github.com/usman-zulfiqar065/Image-Processor/assets/125230430/a8c2ad7d-3d53-4258-88e1-cd6698b73ad2">

<img width="1792" alt="Screenshot 2024-05-06 at 2 18 48 AM" src="https://github.com/usman-zulfiqar065/Image-Processor/assets/125230430/01fa3f63-a1cb-414d-b56f-5270a6a52d7a">



## Prerequisites

Before running this project locally, ensure you have the following prerequisites installed:

- Ruby version: 3.2.2
- Rails version: 7.1.3 (or higher) - (`gem "rails", "~> 7.1.3", ">= 7.1.3.2"`)
- ImageMagick: This project requires ImageMagick for image processing. If you don't have it installed, you can install it locally using Homebrew:
  brew install imagemagick

## Installation

1. Clone this repository to your local machine:
   git clone <repository_url>

2. Navigate into the project directory:
   cd image_processor

3. Install dependencies:
   bundle install

## Running the Project

To run this project locally, follow these steps:

1. Start the Rails server:
   rails s

2. Open your web browser and visit [http://127.0.0.1:3000/](http://127.0.0.1:3000/)

## Running Tests

This project uses RSpec for testing. To run the tests, simply execute the following command:
rspec

## Usage

Once the project is running locally, users can perform the following actions:

- Upload an image.
- Search for specific words within the uploaded image.
- View the processed image with highlighted words.
- Download the processed image.
