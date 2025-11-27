# 📘 SQL Data Warehouse Project

Modern Data Warehouse | ETL | Medallion Architecture | Dimensional Modelling | Analytics

 ### 📌 Project Overview 

This project demonstrates the design and implementation of a Modern Data Warehouse using SQL Server, following the Medallion Architecture (Bronze → Silver → Gold).
It includes:

Multi-source ingestion (CRM & ERP)

ETL/ELT processes using stored procedures

Data cleansing & standardization

Dimensional modelling (Star Schema)

Data Quality Checks

Documentation (Architecture, Data Flow, Data Model, Data Catalog)

This project is part of the course “SQL Full Course for Beginners (30 hours) – Data With Baraa” and is developed as a portfolio-ready Data Engineering project.


## 🏗️ High-Level Architecture
<img width="1654" height="1169" alt="image" src="https://github.com/user-attachments/assets/e26a8822-05c9-4402-b839-a82e1ba036e5" />

The warehouse follows a Medallion Architecture:

Layer	Purpose	Object Type	Description

Bronze	Raw data ingestion	Tables	Loaded as-is (no transformations).

Silver	Cleaned, standardized data	Tables	Data cleansing, normalization, derived fields.

Gold	Business-ready analytics layer	Views	Integrated dimensional model (Star Schema).


### 🔄 Data Flow (Data Lineage)

Data originates from two systems:

CRM → sales, customer, product

ERP → customer birthdate, location, product categories

Data moves through:
Source → Bronze → Silver → Gold


### 🔌 Integration Model

CRM and ERP data are integrated during Silver → Gold transformations to create:

Unified Customer Dimension, Unified Product Dimension, Fully integrated Sales Fact Table


## ⭐ Gold Layer Data Model (Star Schema)

**Fact Table**

fact_sales:

order_number, product_key, customer_key, order_date, shipping_date, due_date,  sales_amount, quantity, price

**Dimension Tables**

dim_customers :

customer_key (PK), customer_id, customer_number, first_name, last_name, country,  marital_status, gender, birthdate, country 

dim_products:

product_key (PK), product_id, product_number, product_name, category_id, category, subcategory, maintenance, cost, product_line, start_date


### 🧪 Data Quality Checks

Quality checks are implemented in the Silver and Gold layers (/tests folder).

**✔ Silver Layer QC:**

Null or duplicate primary keys

TRIM checks for string cleanup

Negative or invalid numeric values

Date format & logical order checks

sales = quantity × price validation

Category, marital status, gender consistency

Out-of-range birthdates

**✔ Gold Layer QC:**

Surrogate key uniqueness (dim tables)

Fact/dim join completeness (no orphan rows)

These checks ensure the warehouse meets analytical and business requirements.

# 📂 Repository Structure

```
data-warehouse-project/
├── datasets/            # Raw datasets used for the project (ERP and CRM data)
│
├── docs/                # Project documentation and architecture details
│   ├── data_architecture.drawio      # Architecture diagram (Draw.io)
│   ├── data_catalog.md               # Data catalog with field descriptions & metadata
│   ├── data_flow.drawio              # Data flow diagram
│   ├── data_integration.drawio       # Data integration model
│   ├── data_models.drawio            # Data models (star schema)
│   └── naming-conventions.md         # Naming guidelines (tables, columns, files)
│
├── scripts/             # SQL scripts for ETL and transformations
│   ├── bronze/          # For extracting & loading raw data
│   ├── silver/          # For cleaning & transforming data
│   └── gold/            # For building analytical models (Gold Layer)
│
├── tests/               # SQL scripts for data quality & testing
│
├── README.md            # Project overview and instructions
├── LICENSE              # License information
├── .gitignore           # Git ignore settings
└── requirements.txt     # Project dependencies and requirements
```



### 🧱 Technologies Used

SQL Server

T-SQL (Stored Procedures)

Medallion Architecture (Bronze/Silver/Gold)

Dimensional Modelling (Kimball)

Git & Version Control

📊 Analytics & Reporting (Future Work with a separate Repo)

This project provides the Gold Views required for the analytics layer.

**📚 Documentation**

Data Catalog — docs/data_catalog.md

Business Logic & Definitions — included in Gold views

Data Flow, Architecture, Model Diagrams — docs/

👤 Author

Marsel Luase
📧 luaseachell@gmail.com

🔗 LinkedIn: https://www.linkedin.com/in/marsel-pongdatu-luase-24249836a/

⚖️ License

This project is licensed under the MIT License.
Feel free to use, modify, or share with attribution.




