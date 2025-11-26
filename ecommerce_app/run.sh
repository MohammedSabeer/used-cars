#!/bin/bash
# Quick Start Script for E-Commerce Flutter App

echo "🚀 E-Commerce Flutter App - Quick Start"
echo "======================================="
echo ""

# Navigate to project
cd "e:\Project\used-cars\ecommerce_app" || exit 1

echo "📦 Project location: $(pwd)"
echo ""

# Check if dependencies are installed
if [ ! -d "pubspec.lock" ]; then
    echo "📥 Installing dependencies..."
    flutter pub get
fi

echo ""
echo "🎯 Choose your platform:"
echo "  1) Android/Default"
echo "  2) iOS"
echo "  3) Web (Chrome)"
echo "  4) Windows"
echo "  5) macOS"
echo ""
echo "Running: flutter run"
echo ""

# Run the app
flutter run

echo ""
echo "✅ App started!"
