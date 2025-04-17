


Transform your weak passwords into super strong password.

## About

This is app help you to generate a strong password. It combines two password to generate a strong password.

It is implemented using flutter, so it can run in any platform, wether on mac, ios, android, or in browser.

## Algorithm

1. Provide your own secret from example secret
2. Provide your weak password for example mbags
3. Perfom hashing and encoding for your provided secret and weak password to generat a fixed length strong password
4. Get your strong password 

- No information is saved in browser or database, you own your own password












A cross-platform password strengthening tool
[Passbag](./lib/assets/images/logo.png)
## Purpose

Transforms weak passwords into stronger ones by combining two weak passwords into a single, more secure password using a one-way algorithm.

## Motivation

Browser password managers often generate random passwords that are hard to reproduce. Passbags solves this by:

- Taking two easy-to-remember passwords as input
- Combining them using a consistent algorithm
- Producing the same strong password every time

This allows users to:

1. Generate strong passwords
2. Recreate the same password when needed
3. Keep using simple passwords as seeds

## How It Works

Just input two weak passwords, and passbags will combine them into one stronger password that you can reliably regenerate anytime.

