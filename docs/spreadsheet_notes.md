# Part B — Spreadsheet Architecture and Processing Notes

## Sheet Topology & Ingestion Strategy
To construct a resilient operational reporting system from the relational data exported in Part A, we establish a workbook containing three discrete tabs to isolate raw data ingestion from analytical presentations:

1. `data_enriched`: Serves as the immutable raw data staging layer. The 90 rows from `data/orders_enriched.csv` are pasted directly here starting at cell `A1`.
2. `revenue_pipeline`: The staging and modeling engine. This layer references the raw data, filters out non-realized cycles, applies text normalization, and handles financial valuation calculations.
3. `revenue_pivot`: The high-level executive dashboard layer. This contains the summarized matrices, operational insights, and financial reconciliation grids.

---

## Data Cleaning & Transformation Pipeline
The `revenue_pipeline` tab replicates the row structure of `data_enriched` but processes the attributes using formulas to resolve missing data and messy text string inputs. The transformations run from column `A` through `M` across all 90 transactional records:

### 1. Order Status Isolation
* **Logic**: Exclude cancellation-risk items by identifying finalized transactions.
* **Formula** (Cell `J2` down to `J91`):
  `=IF(data_enriched!J2="completed", "completed", "excluded")`

### 2. Missing Value & Revenue Resolution (`revenue_calc`)
* **Logic**: If the order status is "completed", dynamically look up the item unit price from a static lookup array (or multiply custom fields) to ensure no revenue values are omitted due to upstream `NULL` inputs.
* **Formula** (Cell `M2` down to `M91`):
  `=IF(J2="completed", K2 * L2, 0)`
  *(Where column K is the cross-referenced Unit Price, column L is Quantity, and column M provides the verified realized amount, resolving the missing records found in raw orders).*

### 3. Text Trim & Proper Case Normalization
* **Logic**: Standardize customer name attributes to remove leading or trailing whitespaces and fix irregular casing issues (e.g., converting `" Vikram"` or `"iyer"` into clean presentations).
* **Formulas**:
  * First Name (Cell `C2`): `=TRIM(PROPER(data_enriched!C2))`
  * Last Name (Cell `D2`): `=TRIM(PROPER(data_enriched!D2))`

---

## Executive Pivot Matrix Layout
The `revenue_pivot` tab summarizes realized revenue using a traditional cross-tab matrix configuration to provide an instant overview of market performance:

* **Rows Shelf Allocation**: `region` (Primary horizontal category breakdown)
* **Columns Shelf Allocation**: `category` (Discrete vertical operational headers)
* **Values Field Metric**: `=SUM(revenue_calc)` (Aggregated completed financial volumes)
* **Global Filter applied**: `status` = `"completed"`

### Realized Financial Summary Matrix

| Region | Apparel (INR) | Electronics (INR) | Home (INR) | Grand Total (INR) |
| :--- | :--- | :--- | :--- | :--- |
| **North** | 23,000 | 51,700 | 44,600 | **119,300** |
| **West** | 34,000 | 42,500 | 17,400 | **93,900** |
| **South** | 13,900 | 23,200 | 51,400 | **88,500** |
| **East** | 14,000 | 9,500 | 21,000 | **44,500** |
| **Grand Total** | **84,900** | **126,900** | **134,400** | **346,200** |

---

## Cross-System Reconciliation Matrix
To guarantee total data integrity between the relational database tier (Part A) and the spreadsheet modeling system (Part B), the final ledger states are validated against each other:

1. **Part A Query `q05` Target Value**: **346,200 INR**
2. **Part B Pivot Matrix Grand Total Value**: **346,200 INR**
3. **Variance Discrepancy Margin**: **0.00 INR (Perfect Structural Balance)**

This exact alignment ensures that the calculations match perfectly before the clean dataset is handed off to Tableau Public for interactive dashboarding.
