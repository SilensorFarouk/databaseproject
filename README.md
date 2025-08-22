# Home Energy Management System

## Project Description

The Home Energy Management System is a comprehensive database solution designed to help homeowners optimize energy consumption, reduce electricity costs, and increase sustainability. This system tracks real-time energy usage, monitors renewable energy generation, and provides data-driven insights for better energy management decisions.

### Key Features:
- **Real-time Energy Monitoring**: Tracks both energy consumption and generation
- **Renewable Energy Integration**: Manages solar panels, wind turbines, and battery storage systems
- **Cost Optimization**: Links to utility rate plans with peak/off-peak pricing
- **Environmental Analysis**: Integrates weather data for energy prediction
- **Smart Recommendations**: AI-driven suggestions for energy efficiency improvements
- **Goal Tracking**: Allows setting and monitoring energy conservation targets

## Database Schema Overview

The system includes the following main tables:
- `HomeOwners` - Homeowner information and contact details
- `Homes` - Property details and energy efficiency ratings
- `EnergyDevices` - Renewable energy devices and smart meters
- `EnergyConsumption` - Real-time energy usage and generation data
- `ElectricityRates` - Utility company rate plans and pricing
- `EnergyRecommendations` - Personalized efficiency suggestions
- `WeatherData` - Environmental conditions affecting energy usage
- `EnergyGoals` - Conservation targets and progress tracking

## How to Setup and Run

### Prerequisites
- MySQL Server (version 8.0 or higher)
- MySQL Workbench or any SQL client
- Basic knowledge of SQL database management

### How to run the database

1. **Create a new database**:
   ```sql
   CREATE DATABASE Home_Energy_Management_System;
   USE Home_Energy_Management_System;

2. **copy the querry from project.sql and paste on your editor**.
3. **Run the codes and your tables will be created**.

## The ERD diagram
**The pdf file has the ERD df the database**.
