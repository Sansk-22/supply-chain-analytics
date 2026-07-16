# Supply Chain Performance Analytics

An end-to-end analytics project examining delivery performance, profitability, and operational inefficiencies across a global supply chain dataset of 180,000+ orders.

---

## Tools & Technologies
- **Python** (pandas) — data cleaning, EDA, feature engineering
- **MySQL** — structured querying and aggregation
- **Power BI** — interactive dashboard for business reporting

---

## Dataset
**Source:** [DataCo Smart Supply Chain Dataset](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis) — Kaggle  
**Size:** ~180,000 orders across global markets (Europe, LATAM, USCA, Pacific Asia, Africa)

> Dataset not included in this repo due to size. Download from Kaggle and place as `data/DataCoSupplyChainDataset.csv`.

---

## Project Structure

```
supply-chain-analytics/
├── notebooks/
│   └── supply_chain_analysis.ipynb   # Data cleaning, EDA, analysis
├── sql/
│   └── supply_chain_queries.sql      # MySQL table setup and business queries
├── dashboard/
│   └── supply_chain_dashboard.pbix   # Power BI dashboard
└── README.md
```

---

## Key Findings

### Delivery Performance
- **54% of all orders** are delivered late — a systemic issue across the supply chain
- **First Class shipping has a 95.3% late delivery rate** — the worst performer, despite being a premium option
- **Standard Class shipping performs best** at 38.1% late rate

### Profitability
- Average profit per order: **$23.23**
- Most profitable product: **Dell Laptop** ($157.59/order avg)
- Most profitable market: **Europe** ($23.27/order avg)
- Most profitable category: **Computers & Electronics**

### Discount Impact
- Low discounts (0–5%): **$23.26 avg profit per order**
- High discounts (20%+): **$18.41 avg profit per order**
- Heavy discounting reduces profit by **~21%** without meaningful volume offset

### Sales Trend
- Peak monthly sales: **$1.14M (Sept 2017)**
- Declined ~71% to $331K by Jan 2018 — signals a demand or reporting anomaly requiring investigation

### Fraud & Cancellations
- **4,062 suspected fraud orders** detected via Order Status flags
- Fraud concentrated in high-order-volume markets

---

## Business Recommendations

1. **Investigate First Class shipping operations** — a 95% late rate is operationally unsustainable and a customer experience risk
2. **Cap discounts at 10%** — discounts beyond this threshold erode profit without evidence of proportional volume gain
3. **Audit the Sept 2017 sales peak** — whether a data artifact or real demand event, the 71% decline needs explanation
4. **Prioritize Computers/Electronics** in inventory and marketing — highest per-order profitability
5. **Implement automated fraud detection** — 4,000+ suspected fraud orders represent significant revenue leakage

---

## How to Run

**Python Notebook:**
```bash
pip install pandas
jupyter notebook notebooks/supply_chain_analysis.ipynb
```

**SQL Queries:**
```sql
-- Update the LOAD DATA path in sql/supply_chain_queries.sql to your local dataset path
-- Then run in MySQL Workbench or any MySQL client
```

**Power BI Dashboard:**
- Open `dashboard/supply_chain_dashboard.pbix` in Power BI Desktop
- Reconnect data source to your local `supply_chain_cleaned.csv`

---

## Author
**Sanskriti Kesharwani** | B.Tech Mechanical Engineering, MANIT Bhopal  
Aspiring Data & Business Analyst | Supply Chain & Operations Analytics
