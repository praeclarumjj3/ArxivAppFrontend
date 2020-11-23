# ArxivAppFrontend

![Dart CI](https://github.com/praeclarumjj3/ArxivAppFrontend/workflows/Dart%20CI/badge.svg?branch=master)
![Framework: Flutter](https://img.shields.io/badge/Framework-Flutter-blue.svg)

## Overview

**ArxivApp** lets you *read, bookmark and download* papers from arXiv.org. It also has a *forum screen* that lets you read and create notes/blogs about the different research papers you read!

## Contribution Guidelines

**Don't push straight to master. Always open a Pull Request**.

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

### For commit messages

- Please start your commits with [emojis](https://gist.github.com/parmentf/035de27d6ed1dce0b36a).
- The commit messages should be clear and concise about the feature implemented.

