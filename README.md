# 📊 End-to-End Inventory Analysis & Management System

### 🚀 Project Overview
This project is a comprehensive data pipeline designed to automate inventory monitoring and procurement alerts. It integrates a **MySQL** database with a **Python**-based analytical engine and an interactive **Power BI** dashboard to provide real-time stock insights.

The system calculates a dynamic **Reorder Point** to ensure the business never faces a stockout, shifting inventory management from reactive to proactive.

### 🛠️ Technical Stack
* **Database:** MySQL (Structured storage for product metadata and inventory levels)
* **Data Processing:** Python (Pandas & SQLAlchemy for ETL and business logic)
* **Visualization:** Power BI (DAX-driven interactive reporting and KPI tracking)

### ⚙️ Core Logic: The Reorder Point (ROP)
I implemented a mathematical approach to determine when a product needs restocking:
$$ROP = (Daily\ Sales\ Velocity \times Lead\ Time) + Safety\ Stock$$

**Status Triggers:**
* **⚠️ REORDER NOW:** If `Current Stock` <= `Reorder Point`.
* **✅ STOCK OK:** If `Current Stock` > `Reorder Point`.

### 📈 Key Features & Insights
* **Real-time Alerts:** A "REORDER NOW" slicer that instantly filters the 53+ items needing urgent attention.
* **KPI Cards:** High-level metrics showing Total Product Count and critical stock alerts.
* **Data Pipeline:** Automated transformation of raw SQL data into a clean, Power BI-ready CSV format via Python.
* **Visual Analysis:** Comparative charts showing the gap between current inventory and safety thresholds.

### 📂 Repository Structure
* `Database_SQL/`: Contains `Inventory_setup.sql` for table schema and data population.
* `Python_Script/`: Contains `Inventory_Analysis.py` (ETL logic) and the output `inventory_report.csv`.
* `PowerBI_Dashboard/`: Contains the `.pbit`/`.pbix` file and dashboard previews.

### 💡 How to Reproduce
1. Execute the SQL script to initialize the `inventory_db`.
2. Execute the Python script to process data and generate the inventory report.
3. Open the Power BI file and refresh the data source to view the dashboard.
