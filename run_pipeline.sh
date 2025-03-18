#!/bin/bash
# save as run_pipeline.sh

# Run R analysis
echo "Running R analysis..."
Rscript r_analysis/generate_data.R
Rscript r_analysis/analyze_data.R

# Ensure directories exist
mkdir -p flutter_report/assets/data

# Copy files if they're not already in the right place
cp -f r_analysis/output/histogram.png flutter_report/assets/data/
cp -f r_analysis/output/scatter.png flutter_report/assets/data/
cp -f r_analysis/output/analysis_results.json flutter_report/assets/data/

# Set up and run Flutter app
echo "Setting up Flutter app..."
cd flutter_report

# Run Flutter app
flutter clean
flutter run -d chrome
