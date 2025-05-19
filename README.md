# module_gym

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Start application in simulator
- open -a Simulator
- flutter devices
- flutter run -d 22DF1687-381E-44E1-B709-186639090426 

## To Configure App
- $HOME/.pub-cache/bin/flutterfire configure  

## Test payments with stripe
- brew install stripe/stripe-cli/stripe
- stripe login
- stripe listen --forward-to localhost:8080/api/stripe

## To enable google token validation (server)
- set environment variable with path to service account credentials GOOGLE_APPLICATION_CREDENTIALS=/Users/ybutko/Documents/Projects/ModuleGymFirebase/module_gym/server/src/main/resources/secure/modulegym-5a3cd99eb442.json
