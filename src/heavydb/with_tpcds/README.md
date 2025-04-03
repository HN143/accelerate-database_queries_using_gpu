# Accelerate Database Queries Using GPU

A project to accelerate database query performance using GPU capabilities.

## Description

This repository contains tools and methods to optimize database queries by leveraging GPU processing power.

## Installation(need computer has GPU)

1. Grant permission:

   ```sh
   chmod +x main.sh
   ```
1. Run main to grenerate 1 Gb tpc-ds data and download a half of heavydb:

   ```sh
   ./main.sh
   ```
1. After computer is reboot, run main_reboot to download the other half of heavydb:

   ```sh
   ./main_reboot.sh
   ```
1. After that, run source ~/.bashrc to load environment path:

   ```sh
   source ~/.bashrc
   ```
1. And run main_reboot again to benchmark heavydb:

   ```sh
   ./main_reboot.sh
   ```
## Usage

_Coming soon_
