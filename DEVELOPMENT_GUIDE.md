## 🛠️ Development Guide - E-Commerce Flutter App

### Getting Started with Development

This guide will help you understand the codebase and extend it with new features.

---

## 📚 Understanding the Architecture

### State Management Flow

```
User Action → Provider.read() → CartProvider.updateState() → UI Rebuild
```

**Example**: Adding a product to cart
```dart
// User taps "Add to Cart"
context.read<CartProvider>().addToCart(product);

// CartProvider updates internal state
void addToCart(Product product) {
  _items.add(CartItem(product: product));
  notifyListeners(); // Triggers UI rebuild
}

// UI rebuilds with updated cart
```

### API Integration Flow

```
UI Widget → ApiService.fetchProducts() → HTTP GET → Parse JSON → Return Models → UI Display
```

**Example**: Fetching products
```dart
// In ProductListPage
Future<List<Product>> futureProducts = ApiService.fetchProducts();

// In ApiService
static Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse('$baseUrl/products'));
  return (json.decode(response.body) as List)
      .map((p) => Product.fromJson(p))
      .toList();
}
```

---

## 🔄 Key Patterns Used

### 1. Provider Pattern (State Management)

```dart
// Define a provider
class CartProvider extends ChangeNotifier {
  void addToCart(Product product) {
    _items.add(CartItem(product: product));
    notifyListeners(); // Notify listeners of change
  }
}

// Use in widget (read-only)
context.read<CartProvider>().addToCart(product);

// Use in widget (observe changes)
final cart = context.watch<CartProvider>();
Text('Items: ${cart.itemCount}');
```

### 2. Stateful Widget Pattern

```dart
class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({required this.product});
  final Product product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1; // Local state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // UI here
    );
  }
}
```

### 3. Future Builder Pattern

```dart
FutureBuilder<List<Product>>(
  future: ApiService.fetchProducts(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return ListView(children: ...);
    }
  },
)
```

---

## ➕ Adding New Features

### Feature 1: Add Product Search

**Step 1**: Add search to ProductListPage

```dart
// Add to _ProductListPageState
TextEditingController _searchController = TextEditingController();
String _searchQuery = '';

// Update futureProducts based on search
void _search(String query) {
  setState(() {
    _searchQuery = query;
    futureProducts = _getFilteredProducts();
  });
}

Future<List<Product>> _getFilteredProducts() async {
  final products = await ApiService.fetchProducts();
  return products
      .where((p) => p.title.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();
}
```

**Step 2**: Add SearchBar to AppBar

```dart
AppBar(
  title: TextField(
    controller: _searchController,
    onChanged: _search,
    decoration: InputDecoration(
      hintText: 'Search products...',
      border: InputBorder.none,
    ),
  ),
)
```

### Feature 2: Add Wish List

**Step 1**: Create WishListProvider

```dart
class WishListProvider extends ChangeNotifier {
  final List<int> _wishlist = [];

  List<int> get items => _wishlist;

  void toggleWishlist(int productId) {
    if (_wishlist.contains(productId)) {
      _wishlist.remove(productId);
    } else {
      _wishlist.add(productId);
    }
    notifyListeners();
  }

  bool isInWishlist(int productId) => _wishlist.contains(productId);
}
```

**Step 2**: Add to MultiProvider in main.dart

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => CartProvider()),
    ChangeNotifierProvider(create: (_) => WishListProvider()),
  ],
  // ...
)
```

**Step 3**: Use in ProductCard

```dart
GestureDetector(
  onTap: () {
    context.read<WishListProvider>().toggleWishlist(product.id);
  },
  child: Icon(
    context.watch<WishListProvider>().isInWishlist(product.id)
        ? Icons.favorite
        : Icons.favorite_border,
    color: Colors.red,
  ),
)
```

### Feature 3: Add Real Authentication

**Step 1**: Create AuthProvider

```dart
class AuthProvider extends ChangeNotifier {
  String? _token;
  User? _user;

  Future<void> login(String email, String password) async {
    try {
      // Call your backend API
      final response = await http.post(
        Uri.parse('https://your-api.com/login'),
        body: {'email': email, 'password': password},
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _token = data['token'];
        _user = User.fromJson(data['user']);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  bool get isAuthenticated => _token != null;
}
```

**Step 2**: Create LoginPage

```dart
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    await context.read<AuthProvider>().login(
      _emailController.text,
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(onPressed: _login, child: Text('Login')),
        ],
      ),
    );
  }
}
```

---

## 🧪 Testing

### Unit Test Example

```dart
// test/cart_provider_test.dart
void main() {
  test('CartProvider adds items correctly', () {
    final provider = CartProvider();
    final product = Product(
      id: 1,
      title: 'Test',
      price: 10.0,
      // ... other fields
    );

    provider.addToCart(product);
    
    expect(provider.itemCount, 1);
    expect(provider.items[0].product.id, 1);
  });
}
```

### Widget Test Example

```dart
// test/product_list_page_test.dart
void main() {
  testWidgets('ProductCard displays product', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ProductCard(product: testProduct),
      ),
    );

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.byIcon(Icons.add_circle), findsOneWidget);
  });
}
```

---

## 📦 Extending with Custom Packages

### Add Image Caching

```yaml
# pubspec.yaml
cached_network_image: ^3.2.0
```

```dart
// lib/pages/product_list_page.dart
CachedNetworkImage(
  imageUrl: product.image,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

### Add Database Persistence

```yaml
# pubspec.yaml
sqflite: ^2.0.0
```

```dart
// lib/services/database_service.dart
class DatabaseService {
  late Database _db;

  Future<void> init() async {
    _db = await openDatabase('ecommerce.db');
  }

  Future<void> saveOrder(Order order) async {
    await _db.insert('orders', order.toMap());
  }
}
```

---

## 🎨 UI Customization

### Change App Theme

```dart
// main.dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepOrange,  // Change primary color
      brightness: Brightness.light,  // or Brightness.dark
    ),
    useMaterial3: true,
  ),
)
```

### Add Custom Fonts

```yaml
# pubspec.yaml
flutter:
  fonts:
    - family: CustomFont
      fonts:
        - asset: assets/fonts/CustomFont-Regular.ttf
        - asset: assets/fonts/CustomFont-Bold.ttf
          weight: 700
```

```dart
// Use in widgets
Text(
  'Custom Font Text',
  style: TextStyle(fontFamily: 'CustomFont'),
)
```

---

## 🚀 Performance Optimization

### 1. Image Optimization

```dart
// Use cached_network_image with size constraints
CachedNetworkImage(
  imageUrl: product.image,
  width: 100,
  height: 100,
  fit: BoxFit.contain,
  cacheManager: CacheManager(
    Config('productImages', stalePeriod: Duration(days: 7)),
  ),
)
```

### 2. List Performance

```dart
// Use RepaintBoundary to reduce rebuild scope
RepaintBoundary(
  child: ProductCard(product: product),
)

// Or use addRepaintBoundary in GridView
GridView.builder(
  addRepaintBoundaries: true,
  itemBuilder: (context, index) => ProductCard(...),
)
```

### 3. Provider Performance

```dart
// Use select() to listen to specific fields only
context.select<CartProvider, int>((cart) => cart.itemCount)

// Or use Consumer for scoped rebuilds
Consumer<CartProvider>(
  builder: (context, cart, child) {
    return Text('Items: ${cart.itemCount}');
  },
)
```

---

## 🐛 Debugging

### Enable Debug Logging

```dart
// main.dart
void main() {
  debugPrint('App starting...');
  runApp(const MyApp());
}
```

### Use Flutter DevTools

```bash
# Start your app first, then:
flutter pub global activate devtools
devtools
```

### Log HTTP Requests

```dart
// Add to api_service.dart
print('Request: $url');
print('Response: ${response.statusCode}');
print('Body: ${response.body}');
```

---

## 📋 Code Review Checklist

Before committing code:

- [ ] Code is properly formatted (`flutter format lib/`)
- [ ] No analyze warnings (`flutter analyze`)
- [ ] State management is correct (no memory leaks)
- [ ] API errors are handled gracefully
- [ ] UI is responsive on all screen sizes
- [ ] Performance is optimized (images cached, lists efficient)
- [ ] Documentation is updated
- [ ] Tests pass (`flutter test`)

---

## 🔗 Common Integration Points

### Connect to Your Backend

1. **Update API Service**
   ```dart
   static const String baseUrl = 'https://your-api.com';
   ```

2. **Add Authentication Header**
   ```dart
   headers: {
     'Authorization': 'Bearer $token',
     'Content-Type': 'application/json',
   }
   ```

3. **Add Error Handling**
   ```dart
   if (response.statusCode == 401) {
     // Handle unauthorized - redirect to login
   }
   ```

### Add Push Notifications

```yaml
# pubspec.yaml
firebase_messaging: ^14.0.0
```

### Add Analytics

```yaml
# pubspec.yaml
firebase_analytics: ^10.0.0
```

---

## 📚 Useful Resources

- **State Management**: https://flutter.dev/docs/development/data-and-backend/state-mgmt
- **Networking**: https://flutter.dev/docs/cookbook/networking
- **Testing**: https://flutter.dev/docs/testing
- **Performance**: https://flutter.dev/docs/perf

---

**Happy developing!** 🚀

