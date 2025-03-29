# Grocery Shop App

**Grocery Shop App** is a simple mobile application built using Flutter. The app allows users to browse products, add them to the shopping cart, and complete orders. It features a login screen, product categories, a shopping cart with item quantity management, and various payment methods.

## Features

- **Splash Screen**: Display a loading indicator before showing the login screen.
- **Login Screen**: Users can log in with pre-configured credentials (username: `Dilshan`, password: `123456`).
- **Product Categories**: Browse products categorized into vegetables, meats, beverages, fruits, snacks, and bread.
- **Product Promotions**: View and add promotional products to the cart.
- **Shopping Cart**: Users can view the cart, update quantities, or remove items.
- **Order Confirmation**: After reviewing the cart, users can confirm their order with payment options: `Credit Card` or `Grocery Point`.
- **Simple UI**: User-friendly and modern interface with smooth transitions and animations.

## Screens

1. **Splash Screen**: Displays a loading animation for 2 seconds before navigating to the login screen.
2. **Login Screen**: Users enter their credentials to access the product screen.
3. **Product Screen**: Displays product categories and a list of promotional items. Users can add items to the cart.
4. **Cart Screen**: Users can review their cart, modify item quantities, select a payment method, and place the order.

## Technologies Used

- **Flutter**: Framework used for building the mobile app.
- **Dart**: Programming language used to write the Flutter app.

## Setup Instructions

To run this app locally, follow these steps:

### 1. Clone the repository:

    git clone https://github.com/Dilo1999/grocery_shop_app.git
    cd grocery_shop_app

2. Install dependencies:
    Make sure you have Flutter installed on your system. If not, follow the installation guide here.
    Run the following command to get the dependencies:
    flutter pub get

3. Run the app:
    To run the app on an emulator or device, use:
    flutter run

4. Testing:
    You can run tests for the app using:
    flutter test
