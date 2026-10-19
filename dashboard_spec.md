# Dashboard Specification and Business Narrative

## Data Source
The dashboard connects directly to `data/orders_clean.csv`. The table below outlines each of its 13 columns with their technical data types and semantic role classifications for rebuilding within Tableau Public:

| Field Name | Data Type | Tableau Classification | Operational Description |
| :--- | :--- | :--- | :--- |
| `order_id` | Alphanumeric | **Dimension** | Unique row identifier key; treated as a dimension category. |
| `order_month` | Alphanumeric Text | **Dimension** | Categorical month string tracking metric intervals. |
| `clean_first_name`| Alphanumeric Text | **Dimension** | Sanitized and capitalized customer given name string. |
| `clean_last_name` | Alphanumeric Text | **Dimension** | Sanitized and capitalized customer family name string. |
| `region` | Alphanumeric Text | **Dimension** | Geographic sales operating territory category field. |
| `rep_name` | Alphanumeric Text | **Dimension** | Assigned sales professional account manager name string. |
| `item` | Alphanumeric Text | **Dimension** | Specific inventory product stock profile name. |
| `category` | Alphanumeric Text | **Dimension** | High-level product segment metadata division profile. |
| `unit_price` | Whole Number | **Measure** | Financial field capturing individual catalog base pricing. |
| `quantity` | Whole Number | **Measure** | Aggregate measure tracking volume of inventory units sold. |
| `amount` | Whole Number | **Measure** | Aggregate measure computing transaction final invoice value. |
| `revenue_calc` | Whole Number | **Measure** | Calculated measure verification cross-check (`unit_price * quantity`). |
| `status` | Alphanumeric Text | **Dimension** | Transaction completion pipeline marker string (`completed`). |

## KPI Cards
* **Total Revenue KPI Card**
  * **Tableau Configuration:** Canvas Text Card tracking `SUM(amount)`.
  * **Displayed Target Value:** **346,200 INR**
  * **Reconciliation Check:** This card value matches the database validation ledger total from Part A `q05` (`total_revenue`).
* **Total Units Sold KPI Card**
  * **Tableau Configuration:** Canvas Text Card tracking `SUM(quantity)`.
  * **Displayed Target Value:** **106 Units**

## Chart Sheets

### 1. Revenue by Region
* **Chart Type:** Horizontal Bar Chart
* **Rows Shelf:** `region`
* **Columns Shelf:** `SUM(amount)`
* **Color Shelf:** `region`
* **Justification:** A horizontal bar chart facilitates immediate sorting and comparative size evaluation of revenue volumes between competing geographic sectors.
* **Data Table:**

  | Region | Total Revenue (INR) |
  | :--- | :--- |
  | East | 69,500 |
  | North | 119,300 |
  | South | 82,500 |
  | West | 74,900 |
  | **Total** | **346,200** |

### 2. Revenue by Category
* **Chart Type:** Vertical Bar Chart
* **Rows Shelf:** `SUM(amount)`
* **Columns Shelf:** `category`
* **Color Shelf:** `category`
* **Justification:** A vertical bar chart isolates category sales benchmarks to evaluate overall consumer demand distribution across different product families.
* **Data Table:**

  | Category | Total Revenue (INR) |
  | :--- | :--- |
  | Apparel | 77,500 |
  | Electronics | 142,300 |
  | Home | 126,400 |
  | **Total** | **346,200** |

### 3. Revenue Trend by Month and Category
* **Chart Type:** Multi-Series Line Chart
* **Rows Shelf:** `SUM(amount)`
* **Columns Shelf:** `order_month`
* **Color Shelf:** `category`
* **Justification:** A line chart emphasizes continuous momentum trajectories over continuous time points while highlighting tracking deviations among categories.
* **Data Table:**

  | Order Month | Apparel (INR) | Electronics (INR) | Home (INR) | Monthly Total (INR) |
  | :--- | :--- | :--- | :--- | :--- |
  | 2026-09 | 24,500 | 47,700 | 26,100 | 98,300 |
  | 2026-10 | 29,200 | 44,900 | 19,000 | 93,100 |
  | 2026-11 | 23,800 | 49,700 | 81,300 | 154,800 |
  | **Total** | **77,500** | **142,300** | **126,400** | **346,200** |

### 4. Region x Category Detail
* **Chart Type:** Text Table Cross-Tab Matrix
* **Rows Shelf:** `category`
* **Columns Shelf:** `region`
* **Text Mark:** `SUM(amount)`
* **Justification:** A text table cross-tab layout provides accurate auditing of granular transactional revenue intersections.
* **Data Table:**

  | Category | East (INR) | North (INR) | South (INR) | West (INR) | Grand Total (INR) |
  | :--- | :--- | :--- | :--- | :--- | :--- |
  | Apparel | 10,600 | 19,400 | 10,000 | 37,500 | **77,500** |
  | Electronics | 21,400 | 73,400 | 28,700 | 18,800 | **142,300** |
  | Home | 37,500 | 26,500 | 43,800 | 18,600 | **126,400** |
  | **Grand Total** | **69,500** | **119,300** | **82,500** | **74,900** | **346,200** |

## Dashboard Layout
The dashboard layout is structured inside a fixed dashboard canvas frame utilizing nested horizontal and vertical formatting containers stacked from top to bottom:

* **Placement Sequence:**
  1. **Top Container (Horizontal):** Title block and brand asset parameters.
  2. **Upper Scorecard Ban (Horizontal):** Houses the `Total Revenue KPI` and `Total Units Sold KPI` side-by-side.
  3. **Global Filter Row (Horizontal Container):** Includes a single-value dropdown interface filter tied to the global `category` parameter field. This filter targets all four canvas worksheets simultaneously.
  4. **Middle Main Body (Vertical Container):** Embeds the `Revenue Trend by Month and Category` multi-series line chart.
  5. **Lower Comparison Split (Horizontal Container):** Places the `Revenue by Region` bar chart on the left half and the `Revenue by Category` bar chart on the right half.
  6. **Base Grid Panel (Vertical Container):** Direct cross-tab matrix detailing the foundational `Region x Category Detail` ledger values.
* **Interactive Dashboard Action Behavior:** When an interactive filter toggle `"Use as Filter"` is active on the `Revenue by Region` worksheet view, selecting any active data element bar (such as the **North** region segment) instantly filters the rest of the dashboard canvas. This dynamically re-scopes the charts to display only the metrics tied to that selection.

## Insight and Recommendation Narrative

### Visualization Summary
The executive operational dashboard tracks key metrics using **63 completed pipeline records** from the updated sales workbook. It serves as a unified corporate intelligence portal presenting **346,200 INR in total sales revenue** alongside **106 units sold**. The structured layout provides clear visibility into key operating dimensions, tracking regional variations, product category performance, and time-based sales momentum.

### Summary Analysis
* **Geographic Revenue Distribution:** The **North** region is the top performer, generating **119,300 INR** in total completed revenue. This is double the revenue produced by the lowest-performing zone, the **East**, which contributed **69,500 INR**.
* **Product Mix Dominance:** The **Electronics** product segment is our largest category, capturing **142,300 INR** in total sales volume. It leads **Home** products (**126,400 INR**) and doubles the performance of **Apparel** (**77,500 INR**).
* **Temporal Trend Accelerations:** Analysis of our monthly metrics reveals a significant peak in sales growth at the close of the period. Total corporate revenue expanded from **93,100 INR** in `2026-10` to **154,800 INR** in `2026-11`. This represents a **66.27% month-over-month growth surge**, driven primarily by a sudden spike in **Home** category orders, which jumped from **19,000 INR** to **81,300 INR** during that same time frame.

### Recommendations
1. **Capitalize on the North Electronics Stronghold:** Increase local marketing spend and allocate extra inventory to support the **Electronics** category inside the **North** region, where sales currently lead the business at **73,400 INR**. *Success Metric to Track:* Monthly total sales performance of North Electronics.
2. **Address Home Demand in the West:** Launch a targeted promotional push and optimize inventory mix for **Home** appliances in the underperforming **West** region, which brought in only **18,600 INR** compared to the **43,800 INR** generated in the **South**. *Success Metric to Track:* Gross monthly sales totals for West Home inventory lines.
3. **Replicate West Apparel Execution Modality:** Audit why **Apparel** products succeeded in the **West** region, where sales hit a category-leading **37,500 INR** (accounting for 48.38% of all apparel sales nationwide). Apply those local promotional tactics to improve performance in the trailing **South Apparel** market (**10,000 INR**). *Success Metric to Track:* Apparel category revenue growth in the South region.

## Reconciliation Table
The table below confirms absolute balance consistency across all data layers and sections of this project:

| Analytical Project Element Components | Total Audited Revenue (INR) | Match Validation Verdict |
| :--- | :--- | :--- |
| **Total Revenue KPI Scorecard Metric Box** | 346,200.00 | **Match** |
| **Summation Total: `Revenue by Region` Sheet** | 346,200.00 | **Match** |
| **Summation Total: `Revenue by Category` Sheet** | 346,200.00 | **Match** |
| **Part B Workbook Pivot Unified Grand Total** | 346,200.00 | **Match** |
