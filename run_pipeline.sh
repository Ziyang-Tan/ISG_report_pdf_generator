#!/bin/bash
# save as run_pipeline.sh

# clean up
rm -rf r_analysis/output/*
rm -rf flutter_report/assets/data/*

# Ensure directories exist
mkdir -p flutter_report/assets/data

# Run R analysis
echo "Running R analysis..."
Rscript r_analysis/ISG_analysis.R

# Copy files if they're not already in the right place
cp -f r_analysis/output/*.png flutter_report/assets/data/
cp -f r_analysis/output/*.json flutter_report/assets/data/


# Set up and run Flutter app
echo "Setting up Flutter app..."
cd flutter_report

# Run Flutter app
flutter clean
flutter run -d chrome
