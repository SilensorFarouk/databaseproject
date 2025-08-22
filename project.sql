-- Create Database
create database Home_Energy_Management_System;

--Create table HomeOwners
use Home_Energy_Management_System;
CREATE TABLE HomeOwners (
    OwnerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address VARCHAR(500) NOT NULL,
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_email_format CHECK (Email LIKE '%@%.%')
);


--Create table Homes
use Home_Energy_Management_System;
CREATE TABLE Homes (
    HomeID INT AUTO_INCREMENT PRIMARY KEY,
    OwnerID INT NOT NULL,
    HomeName VARCHAR(100) NOT NULL,
    SquareFootage INT NOT NULL CHECK (SquareFootage > 0),
    ConstructionYear YEAR NOT NULL,
    EnergyEfficiencyRating ENUM('A', 'B', 'C', 'D', 'E', 'F', 'G') DEFAULT 'G',
    Timezone VARCHAR(50) NOT NULL DEFAULT 'UTC',
    FOREIGN KEY (OwnerID) REFERENCES HomeOwners(OwnerID) ON DELETE CASCADE,
    UNIQUE (OwnerID, HomeName)
);


-- Create EnergyDevices Table
use Home_Energy_Management_System;
CREATE TABLE EnergyDevices (
    DeviceID INT AUTO_INCREMENT PRIMARY KEY,
    HomeID INT NOT NULL,
    DeviceName VARCHAR(100) NOT NULL,
    DeviceType ENUM('SOLAR_PANEL', 'WIND_TURBINE', 'BATTERY_STORAGE', 'SMART_METER', 'ENERGY_MONITOR') NOT NULL,
    Manufacturer VARCHAR(100) NOT NULL,
    Model VARCHAR(100) NOT NULL,
    CapacityKW DECIMAL(8,2) NOT NULL CHECK (CapacityKW >= 0),
    InstallationDate DATE NOT NULL,
    Status ENUM('ACTIVE', 'INACTIVE', 'MAINTENANCE', 'OFFLINE') DEFAULT 'ACTIVE',
    FOREIGN KEY (HomeID) REFERENCES Homes(HomeID) ON DELETE CASCADE,
    UNIQUE (HomeID, DeviceName)
);

-- Create EnergyConsumption Table
use Home_Energy_Management_System;
CREATE TABLE EnergyConsumption (
    ConsumptionID BIGINT AUTO_INCREMENT PRIMARY KEY,
    HomeID INT NOT NULL,
    DeviceID INT,
    Timestamp TIMESTAMP NOT NULL,
    PowerConsumedKW DECIMAL(10,4) NOT NULL CHECK (PowerConsumedKW >= 0),
    PowerGeneratedKW DECIMAL(10,4) NOT NULL CHECK (PowerGeneratedKW >= 0),
    Temperature DECIMAL(5,2),
    Humidity DECIMAL(5,2),
    FOREIGN KEY (HomeID) REFERENCES Homes(HomeID) ON DELETE CASCADE,
    FOREIGN KEY (DeviceID) REFERENCES EnergyDevices(DeviceID) ON DELETE SET NULL,
    UNIQUE (HomeID, DeviceID, Timestamp)
);

-- Create ElectricityRates Table
use Home_Energy_Management_System;
CREATE TABLE ElectricityRates (
    RateID INT AUTO_INCREMENT PRIMARY KEY,
    UtilityCompany VARCHAR(100) NOT NULL,
    RatePlan VARCHAR(100) NOT NULL,
    RatePerKWH DECIMAL(8,4) NOT NULL CHECK (RatePerKWH >= 0),
    PeakStart TIME,
    PeakEnd TIME,
    PeakRateMultiplier DECIMAL(4,2) DEFAULT 1.0,
    EffectiveDate DATE NOT NULL,
    ExpirationDate DATE,
    Region VARCHAR(100) NOT NULL,
    UNIQUE (UtilityCompany, RatePlan, EffectiveDate, Region)
);

-- Create EnergyRecommendations Table
use Home_Energy_Management_System;
CREATE TABLE EnergyRecommendations (
    RecommendationID INT AUTO_INCREMENT PRIMARY KEY,
    HomeID INT NOT NULL,
    RecommendationType ENUM('COST_SAVING', 'EFFICIENCY', 'MAINTENANCE', 'UPGRADE') NOT NULL,
    Description TEXT NOT NULL,
    EstimatedSavings DECIMAL(10,2) CHECK (EstimatedSavings >= 0),
    EstimatedCost DECIMAL(10,2) CHECK (EstimatedCost >= 0),
    Priority ENUM('LOW', 'MEDIUM', 'HIGH', 'CRITICAL') DEFAULT 'MEDIUM',
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('PENDING', 'IN_PROGRESS', 'COMPLETED', 'REJECTED') DEFAULT 'PENDING',
    FOREIGN KEY (HomeID) REFERENCES Homes(HomeID) ON DELETE CASCADE
);

-- Create WeatherData Table
use Home_Energy_Management_System;
CREATE TABLE WeatherData (
    WeatherID BIGINT AUTO_INCREMENT PRIMARY KEY,
    HomeID INT NOT NULL,
    Timestamp TIMESTAMP NOT NULL,
    Temperature DECIMAL(5,2) NOT NULL,
    Humidity DECIMAL(5,2) NOT NULL,
    CloudCover DECIMAL(5,2) CHECK (CloudCover BETWEEN 0 AND 100),
    WindSpeed DECIMAL(6,2) CHECK (WindSpeed >= 0),
    SolarRadiation DECIMAL(8,2) CHECK (SolarRadiation >= 0),
    FOREIGN KEY (HomeID) REFERENCES Homes(HomeID) ON DELETE CASCADE,
    UNIQUE (HomeID, Timestamp)
);

-- Create EnergyGoals Table
use Home_Energy_Management_System;
CREATE TABLE EnergyGoals (
    GoalID INT AUTO_INCREMENT PRIMARY KEY,
    HomeID INT NOT NULL,
    GoalType ENUM('CONSUMPTION_REDUCTION', 'COST_REDUCTION', 'SELF_SUFFICIENCY', 'CARBON_NEUTRAL') NOT NULL,
    TargetValue DECIMAL(10,2) NOT NULL,
    CurrentValue DECIMAL(10,2) NOT NULL,
    TargetDate DATE NOT NULL,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('ACTIVE', 'COMPLETED', 'FAILED', 'CANCELLED') DEFAULT 'ACTIVE',
    FOREIGN KEY (HomeID) REFERENCES Homes(HomeID) ON DELETE CASCADE,
    CHECK (TargetDate > CreatedDate)
);

-- Indexes for better performance
use Home_Energy_Management_System;
CREATE INDEX idx_energy_consumption_home_timestamp ON EnergyConsumption(HomeID, Timestamp);
CREATE INDEX idx_energy_consumption_device ON EnergyConsumption(DeviceID);
CREATE INDEX idx_weather_data_home_timestamp ON WeatherData(HomeID, Timestamp);
CREATE INDEX idx_energy_goals_home_status ON EnergyGoals(HomeID, Status);
CREATE INDEX idx_energy_devices_home_type ON EnergyDevices(HomeID, DeviceType);
CREATE INDEX idx_energy_recommendations_home_status ON EnergyRecommendations(HomeID, Status);


