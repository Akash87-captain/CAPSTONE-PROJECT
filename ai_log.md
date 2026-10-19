# AI-Assisted Analysis and Human-in-the-Loop Verification Log

## 1. Five-Part Prompt for Part A (Query q13 Generation)
* **Role:** Senior Data Analyst and Expert SQL Engineer.
* **Task:** Generate a clean SQL query to construct the summary framework requested for query `q13`. The query must calculate total revenue and categorize sales accounts into distinct service performance tier profiles based on volume thresholds.
* **Context:** The database is hosted on a PostgreSQL dialect engine containing three physical base tables:
  * `reps` with column schemas: `rep_id`, `rep_name`, `region`, `monthly_target`.
  * `customers` with column schemas: `customer_id`, `first_name`, `last_name`, `city`, `region`, `age`, `rep_id`.
  * `orders` with column schemas: `order_id`, `customer_id`, `item`, `quantity`, `amount`, `status`, `order_month`.
* **Constraints:** 
  * Restrict all records to completed metrics only (`status = 'completed'`).
  * Integrate an inline conditional evaluation case hierarchy to establish tiers: `Tier 3` for sales revenue volumes strictly greater than 100,000; `Tier 2` for sales revenue volumes between 50,000 and 100,000 inclusive; and `Tier 1` for all volumes remaining below 50,000.
  * Do **not** use common table expressions (`WITH` clauses) or stored database procedures.
* **Format:** Provide raw, executable SQL text exclusively. Ensure meaningful inline comments explain the join criteria and case conditional evaluations.

---

## 2. Scenario D1 Assessment

### AI Response Defect Analysis Matrix
The table below logs every structural error and hallucination verified within the AI assistant's response:

| Identified Defect Element | Defect Classification | Foundational Logic Flaw | Corrective Resolution Action |
| :--- | :--- | :--- | :--- |
| **`FROM sales`** | Fake Method / Function | The `sales` table does not exist anywhere within the verified database schema. | Point the query to target the actual transaction schema table by using `FROM orders`. |
| **`region_name`, `total_sales`** | Fake Method / Function | Neither column column attributes exist in the real database structure. | Replace `region_name` with `customers.region` (or `reps.region`) and `total_sales` with the real `amount` metric. |
| **`WHERE SUM(total_sales) > 80000`** | Logic Error | Group aggregate operations cannot be evaluated inside a filtering `WHERE` clause block. | Relocate the group valuation filter into a syntactically correct trailing statement: `HAVING SUM(amount) > 80000`. |
| **"Revenue grew 38% MoM"** | Phantom Statistic | The statement is a hallucinated metric that directly contradicts our empirical ledger trends. | Replace with verified real data values calculated directly from verified pipeline files. |

---

## 3. Scenario D1 Corrected File Verification

### Script Code Block (`sql/d1_corrected.sql`)
```sql
-- Corrected region revenue performance query matching constraints
SELECT 
    c.region, 
    SUM(o.amount) AS sales
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.status = 'completed'
GROUP BY c.region
HAVING SUM(o.amount) > 80000
ORDER BY sales DESC;
```

### Script Execution Results Ledger
Running the verified query block against our active database repository yields the following dataset matrix:

| region | sales (INR) |
| :--- | :--- |
| North | 119,300 |
| South | 82,500 |

### Month-over-Month Temporal Velocity Audit
* **North Real Completed Revenue (`2026-09`):** 53,500 INR
* **North Real Completed Revenue (`2026-10`):** 41,300 INR
* **North True Percentage Metric Variant:** `((41,300 - 53,500) / 53,500) * 100` = **-22.8%** (A net performance drop)
* **Empirical Validation Check:** The assistant's assertion that the North grew **38%** month-over-month is **completely contradicted by the data**. Instead of expanding, the North region experienced a clear **-22.8% decrease** in total completed revenue.

---

## 4. Human-in-the-Loop Verification Protocol

* **Specification Step:** The initial process request failed because the employee submitted a vague, unstructured natural language prompt ("which regions sell the most?") without providing schema keys, target status metrics, column anchors, or dialect instructions.
* **Execution Step:** The AI system generated an uncompilable SQL statement containing invalid table references, non-existent columns, syntax errors, and a fabricated business insight narrative.
* **Inspection Step:** Reviewing the code immediately identified severe logical flaws, such as attempting to run a `SUM()` aggregate inside a `WHERE` clause, along with incorrect mapping of database objects.
* **Verification Step:** Running the corrected query confirmed that only two regions passed the 80,000 threshold (North at 119,300 INR and South at 82,500 INR). Furthermore, historical analysis proved that North region revenue actually fell by **-22.8%** rather than growing by 38%.
* **Decision Step:** We **reject the original AI answer** due to critical codebase errors and fabricated statistics. We **accept the corrected query version** because it compiles successfully, aligns perfectly with our data ledger, and matches all verified metrics from Part A and Part B.

---

## 5. Scenario D2 Diagnostic and Repair Blueprint

### Five-Part Diagnostic Request Prompt
* **Role:** Expert Spreadsheet Systems Analyst and Formula Debugger.
* **Task:** Identify the cause of a standard search error response within an active worksheet matrix.
* **Context:** The spreadsheet workbook contains two specific sheets:
  * A lookup target sheet named `products` that spans cells `A1:C10` (Header row in row 1, unique item identifiers listed in Column A, and item unit prices tracked in Column C).
  * A transaction processing sheet named `orders` containing cell row items to evaluate.
* **Constraints:** 
  * Cell `G2` on the `orders` sheet contains the string `" Smart Watch"` (Note the presence of an accidental leading white-space character before the word).
  * The baseline evaluation cell formula entered is `=VLOOKUP(G2, products!$A$2:$C$10, 3, FALSE)`.
* **Format:** Explain why this layout fails and provide the updated formula syntax to resolve the issue.

### Root Cause Analysis
The search error occurs because the text value in cell `G2` contains a leading space (`" Smart Watch"`), preventing an exact match against the clean string (`"Smart Watch"`) stored in column A of the `products` table. Standard lookups require an exact string match when using `FALSE` or `0` for match parameters.

### Corrected Spreadsheet Formula
Wrap the lookup key reference in a `TRIM()` function to clean any accidental padding spaces before executing the search:
```excel
=VLOOKUP(TRIM(G2), products!$A$2:$C$10, 3, FALSE)
```

---

## 6. Skeptical-Analyst Check on Part C

### Skeptical Verification Request Prompt
* **Role:** Highly Skeptical Business Analytics Auditor.
* **Task:** Critically evaluate our first recommendation from Part C, which suggests expanding regional marketing spend in the North Electronics market based on its leading sales volume of 73,400 INR. 
* **Context:** Challenge the underlying business logic by separating true cause-and-effect from simple data correlation. Identify unstated assumptions, risks, and gaps in our metrics.
* **Format:** Present a structured list detailing at least 3 unstated assumptions, and provide specific data metrics to confirm or disprove each one.

### Unstated Assumptions and Data Verification Controls

* **Assumption 1: High revenue equals high profitability.** The recommendation assumes top-line sales volume translates to strong net profit margins. If unit delivery costs are too high, scaling up could hurt profitability.
  * *Verification Step:* Cross-reference product unit costs against net margins. Check the `unit_price` field (4,500 INR for Smart Watches) against actual wholesale costs to confirm total profitability.
* **Assumption 2: Sales distribution is balanced across representatives.** The advice assumes the North region has consistent market demand across all accounts rather than being driven by a single salesperson.
  * *Verification Step:* Run an internal sales distribution check by grouping the data by representative: `GROUP BY rep_name`. If Arjun Mehta is driving all the volume, success depends on one individual rather than regional product demand.
* **Assumption 3: Transaction activity is stable over time.** The recommendation assumes steady, predictable customer demand rather than a temporary spike.
  * *Verification Step:* Analyze month-over-month category volume trends for the North region from `2026-09` to `2026-11`. If most orders occurred during a single promotional event, long-term investments may not see a return.
