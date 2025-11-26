# E-Commerce Flutter App

A minimal, fully functional cross-platform e-commerce application built with Flutter. This app demonstrates how to build a production-ready mobile and web application with product listing, shopping cart, and payment processing capabilities.

## Features

✅ **Product Listing** - Browse products from FakeStore API  
✅ **Category Filtering** - Filter products by category  
✅ **Product Details** - View detailed product information  
✅ **Shopping Cart** - Add/remove items, manage quantities  
✅ **Cart Management** - Update quantities, clear cart  
✅ **Payment Processing** - Simulate payment checkout  
✅ **Order Confirmation** - Order summary and status  
✅ **Cross-Platform** - Works on iOS, Android, Web, Windows, macOS

## Tech Stack

- **Framework**: Flutter 3.x
- **State Management**: Provider
- **HTTP Client**: http package
- **API**: FakeStore API (https://fakestoreapi.com)
- **Design**: Material Design 3

## Project Structure

```
ecommerce_app/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── models/
│   │   ├── product.dart         # Product model
│   │   ├── cart_item.dart       # Cart item model
│   │   └── order.dart           # Order model
│   ├── services/
│   │   └── api_service.dart     # FakeStore API integration
│   ├── providers/
│   │   └── cart_provider.dart   # Cart state management
│   └── pages/
│       ├── product_list_page.dart      # Product listing
│       ├── product_detail_page.dart    # Product details
│       ├── cart_page.dart              # Shopping cart
│       ├── payment_page.dart           # Payment form
│       └── order_confirmation_page.dart # Order confirmation
├── pubspec.yaml                 # Dependencies
└── README.md                    # This file
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.1.0              # HTTP requests
  provider: ^6.0.0          # State management
  intl: ^0.19.0             # Internationalization
```

## Getting Started

### Prerequisites

- **Flutter SDK**: Install from [flutter.dev](https://flutter.dev/docs/get-started/install)
- **Platform Requirements**:
  - **iOS**: Xcode 12.0 or later
  - **Android**: Android SDK 21 or later
  - **Web**: Chrome or any modern browser
  - **Windows**: Windows 10 or later
  - **macOS**: macOS 10.13 or later

### Installation & Setup

1. **Install dependencies**:
   ```bash
   cd ecommerce_app
   flutter pub get
   ```

2. **Clean build** (recommended):
   ```bash
   flutter clean
   flutter pub get
   ```

## Running the Application

### Run on Mobile/Tablet

**Android**:
```bash
flutter run
```

**iOS**:
```bash
open -a Simulator && flutter run
```

### Run on Web

```bash
flutter run -d chrome
```

### Run on Desktop

**Windows**:
```bash
flutter run -d windows
```

**macOS**:
```bash
flutter run -d macos
```

### Build for Production

**Android APK**:
```bash
flutter build apk --release
```

**iOS**:
```bash
flutter build ios --release
```

**Web**:
```bash
flutter build web --release
```

## How to Use

### 1. **Browse Products**
   - See all products from FakeStore API
   - Filter by category
   - View product cards with images and prices

### 2. **View Product Details**
   - Tap product card for details
   - Adjust quantity
   - View ratings and description

### 3. **Manage Cart**
   - Add/remove items
   - Update quantities
   - View order summary

### 4. **Checkout**
   - Enter payment details (test mode)
   - Test Card: `4111 1111 1111 1111`
   - Complete purchase

### 5. **Order Confirmation**
   - View order details
   - Return to shopping

## API Integration

Uses **FakeStore API** - a free REST API for e-commerce testing.

**Base URL**: `https://fakestoreapi.com`

**Endpoints**:
- `GET /products` - All products
- `GET /products/category/{category}` - Products by category
- `GET /products/categories` - All categories

## State Management

### CartProvider

```dart
final cart = Provider.of<CartProvider>(context);

// Add to cart
cart.addToCart(product);

// Update quantity
cart.updateQuantity(productId, quantity);

// Remove from cart
cart.removeFromCart(productId);

// Clear cart
cart.clearCart();

// Get total
double total = cart.totalPrice;
```

## Customization

### Change API

Edit `lib/services/api_service.dart`:
```dart
static const String baseUrl = 'https://your-api.com/api';
```

### Add Authentication

Create `providers/auth_provider.dart` and add to `main.dart`

### Add Real Payment

Replace mock payment with Stripe or PayPal integration

## Troubleshooting

**Dependencies issue**:
```bash
flutter clean && flutter pub get
```

**Build fails**:
```bash
flutter clean
flutter pub get
flutter run
```

**API not working**:
- Check internet connection
- Test: `curl https://fakestoreapi.com/products`

## Next Steps

1. **User Authentication** - Login/signup
2. **Real Payment** - Stripe/PayPal integration
3. **Backend API** - Replace FakeStore with your own
4. **Advanced Features** - Search, filters, wish lists
5. **Dark Mode** - Add theme support
6. **Notifications** - Push notifications

## Resources

- [Flutter Docs](https://flutter.dev/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [FakeStore API](https://fakestoreapi.com)
- [Material Design](https://material.io)

## License

MIT License - Open for learning and commercial use.

---

**Happy Coding! 🚀** Start with this minimal app, customize it, and build amazing e-commerce applications!
