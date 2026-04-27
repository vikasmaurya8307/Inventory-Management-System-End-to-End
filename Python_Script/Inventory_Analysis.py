import pandas as pd
from sqlalchemy import create_engine
import matplotlib.pyplot as plt
import seaborn as sns

# --- STEP 1: Database Connectivity ---
# Establishing connection to MySQL using SQLAlchemy
# Format: mysql+pymysql://user:password@host/database
engine = create_engine('mysql+pymysql://root:@localhost/ecommerce_db')

# --- STEP 2: Data Extraction (SQL) ---
# Fetching joined data from Products, Sales, and Suppliers tables
query = """
SELECT 
    p.product_id, 
    p.product_name, 
    p.current_stock, 
    p.min_stock_level,
    s.lead_time_days,
    SUM(sl.quantity_sold) as total_sold
FROM products p
LEFT JOIN sales sl ON p.product_id = sl.product_id
JOIN suppliers s ON p.supplier_id = s.supplier_id
GROUP BY p.product_id, p.product_name, p.current_stock, p.min_stock_level, s.lead_time_days;
"""

# Loading SQL result into a Pandas DataFrame
df = pd.read_sql(query, engine)

# --- STEP 3: Business Logic & Optimization ---

# 1. Calculate Daily Sales Velocity (Average sales per day over 30 days)
df['daily_sales'] = df['total_sold'] / 30

# 2. Calculate Reorder Point (ROP)
# Formula: (Daily Sales * Lead Time) + Safety Stock
df['reorder_point'] = (df['daily_sales'] * df['lead_time_days']) + df['min_stock_level']

# 3. Decision Logic: Identifying stock-out risks
def check_inventory_status(row):
    if row['current_stock'] <= row['reorder_point']:
        return "⚠️ REORDER NOW"
    else:
        return "✅ STOCK OK"

df['status'] = df.apply(check_inventory_status, axis=1)

# Displaying the analytical report in console
print("\n" + "="*50)
print("FINAL INVENTORY OPTIMIZATION REPORT".center(50))
print("="*50)
print(df[['product_name', 'current_stock', 'reorder_point', 'status']])
print("="*50)

# --- STEP 4: Data Visualization ---

# Setting up the visual dashboard
plt.figure(figsize=(12, 6))
sns.set_style("whitegrid")

# Visualizing current stock levels
sns.barplot(x='product_name', y='current_stock', data=df, color='skyblue', label='Current Stock')

# Overlaying the Reorder Threshold (Danger Line)
plt.plot(df['product_name'], df['reorder_point'], color='red', marker='o', linestyle='--', label='Reorder Threshold')

plt.title('Inventory Analysis: Stock Levels vs. Reorder Thresholds', fontsize=14, fontweight='bold')
plt.xlabel('Product Name')
plt.ylabel('Quantity')
plt.legend()

# Display the final dashboard
plt.tight_layout()
plt.show()

print("\n🎉 Analysis Complete! The dashboard is ready for presentation.")
# Save the results to a CSV file
df.to_csv("inventory_report.csv", index=False)
print("✅ CSV file 'inventory_report.csv' has been created successfully!")