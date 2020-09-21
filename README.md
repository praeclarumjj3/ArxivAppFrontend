# ArxivAppFrontend

![Dart CI](https://github.com/praeclarumjj3/ArxivAppFrontend/workflows/Dart%20CI/badge.svg?branch=master)
![Framework: Flutter](https://img.shields.io/badge/Framework-Flutter-blue.svg)

## Contribution Guidelines

Use of files

    models -> All data models and response models
    enums -> All enums files
    services -> Any services and API service classes
    ui/views -> All app views
    ui/utils -> All utility functions
    ui/components -> All view components like custom buttons, custom cards etc.
    viewmodels -> All viewmodels

Structure code in this way:

    // Inside widget class
    -- variables (private if possible)
    -- build method (Inside build(), use sub methods like _buildAppBar()
    -- sub-build methods
    -- other methods
    -- utility methods

## For commit messages

- Please start your commits with [emojis](https://gist.github.com/parmentf/035de27d6ed1dce0b36a).
- The commit messages should be clear and concise about the feature implemented.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

