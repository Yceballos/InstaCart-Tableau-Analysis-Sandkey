# InstaCart-Tableau-Analysis
Grocery Basket Analysis

# Project Title: Sales Behavior Analysis Using Instacart Online Grocery Dataset
## Introduction
This Tableau project aims to analyze and identify sales behavior patterns using the Instacart Online Grocery Basket Analysis dataset. The dataset, sourced from Kaggle, contains detailed information about customer purchases, including products, order history, and department-wise segmentation. Our analysis focuses on understanding the sales trends, customer purchasing behavior, and the probability of product purchases across different departments.

### Data Source
1. Dataset: Instacart Online Grocery Basket Analysis
2. Source: Kaggle https://www.kaggle.com/datasets/yasserh/instacart-online-grocery-basket-analysis-dataset
3. Description: This dataset contains a large number of grocery orders over time. Each order is represented by a series of products purchased, along with metadata about the order itself.

### Objectives
1. Sales Trends: Identify and visualize the trends in sales across different time periods.
2. Customer Behavior: Analyze customer purchasing patterns and behaviors.
3. Departmental Insights: Provide insights into the performance of various product departments.
4. Purchase Probability: Calculate and visualize the probability of products being purchased again.

### Key Metrics
1. Order Count: Number of orders placed.
2. Product Frequency: Frequency of each product being ordered.
3. Department Performance: Sales performance metrics for different departments such as dairy, beverages, snacks, etc.
4. Reorder Probability: Likelihood of a product being reordered by customers.

### Visualizations
1. Sales Trends Over Time: Line charts showcasing the trend of sales over various time periods.
2. Customer Purchase Behavior: Heatmaps and bar charts illustrating customer purchase frequencies and patterns.
3. Department-wise Performance: Pie charts and bar charts representing the sales distribution among different departments.
4. Reorder Probability Analysis: Polygons and scatter plots showing the probability of product reorders.

### Data Dictionary
1. Order ID: Unique identifier for each order.
2. Product ID: Unique identifier for each product.
3. Add to Cart Order: Sequence in which products were added to the cart.
4. Reordered: Binary indicator of whether the product has been ordered previously.
5. Department: Category to which the product belongs.

### Usage Instructions
1. Data Preparation: Download the dataset from Kaggle, understand relation between variables and ensure it is properly formatted for Tableau.
![Relation diagram](https://github.com/Yceballos/InstaCart-Tableau-Analysis/assets/90511756/1d307444-2e6e-4e51-82e9-7c2c46de9ee5)

If you need to load .db extensions in tablee, I recommend to read: https://community.tableau.com/s/question/0D54T00000C6O8ASAV/connect-to-a-db-file
3. Tableau Workbook: Open the Tableau workbook provided with the project.
4. Data Connection: Connect the downloaded dataset to the Tableau workbook.
5. Visualization Customization: Customize the visualizations as per your requirements by adjusting filters, colors, and chart types.
6. Insights Extraction: Use the visualizations to extract meaningful insights about sales trends and customer behaviors.

### How to make purchase probability analysis
I strongly recommend to check this video, he really helps me to build my dashboard: https://www.youtube.com/watch?v=mxpDaRYRRdY 
For general licenses we don´t have the option to plot Sandkey graphs.

A Sankey diagram is a type of flow diagram where the width of the arrows is proportional to the flow rate. It is particularly useful for visualizing the distribution and flow of resources or information between different stages or categories.

Steps to Create a Sankey Diagram in Tableau
#### Prepare the Data:
Ensure your data is structured properly. The uploaded data contains points essential for creating a Sankey diagram. Here's a brief look at the data structure: https://docs.google.com/spreadsheets/d/1iPiNQTOiqTGBqYgluxoH9F7clcXEpmlA2wntwiWo054/edit?gid=0#gid=0

Take into account that we need to create an specific script to transform data for sandkey diagram, we need colum1 -> product_previously_purchased and column2 -> product_purchased

[Uploading sandkey_script.sql…](SELECT
    op.order_id,
    op.add_to_cart_order,
    op.product_id,
    p.department_id,
    (
        SELECT department_id
        FROM order_products op2
        INNER JOIN products p2 ON op2.product_id = p2.product_id
        WHERE op2.order_id = op.order_id
          AND op2.add_to_cart_order = op.add_to_cart_order - 1
    ) AS prev_department_id
FROM
    order_products op
    INNER JOIN products p ON op.product_id = p.product_id
WHERE
    op.add_to_cart_order > 1  -- Considerar solo productos que no son el primero en la orden
    AND EXISTS (
        SELECT 1
        FROM order_products op2
        INNER JOIN products p2 ON op2.product_id = p2.product_id
        WHERE op2.order_id = op.order_id
          AND op2.add_to_cart_order = op.add_to_cart_order - 1
          AND p2.department_id <> p.department_id
    );

--new
WITH product_order AS (
    SELECT
        op.order_id,
        op.add_to_cart_order,
        op.product_id,
        p.department_id,
        d.department AS department,
        LAG(p.department_id, 1) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS prev_department_id1,
        LAG(d.department, 1) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS previous1,
        LAG(p.department_id, 2) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS prev_department_id2,
        LAG(d.department, 2) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS previous2,
        LAG(p.department_id, 3) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS prev_department_id3,
        LAG(d.department, 3) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS previous3,
        LAG(p.department_id, 4) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS prev_department_id4,
        LAG(d.department, 4) OVER (PARTITION BY op.order_id ORDER BY op.add_to_cart_order) AS previous4
    FROM
        order_products op
        INNER JOIN products p ON op.product_id = p.product_id
        INNER JOIN departments d ON p.department_id = d.department_id
)
SELECT
    order_id,
    add_to_cart_order,
    product_id,
    department_id,
    department,
    COALESCE(previous1, 'Unknown') AS previous_department1,
    COALESCE(previous2, 'Unknown') AS previous_department2,
    COALESCE(previous3, 'Unknown') AS previous_department3,
    COALESCE(previous4, 'Unknown') AS previous_department4
FROM
    product_order
WHERE
    add_to_cart_order > 4  -- Considerar solo productos que no son los primeros 4 en la orden
    AND previous4 IS NOT NULL;  -- Filtrar aquellos productos que tienen los cuatro departamentos anteriores registrados
)

#### Data Points Explanation:

1. Link: Represents the connection between nodes in the Sankey diagram.
2. t: Likely a parameter related to time or sequence.
3. Path: Represents the specific path in the diagram.
4. Way of the walk: Describes the route or method of progression in the diagram.

#### Create a Calculated Field:
You need to create several calculated fields to define the curvature and flow of the Sankey diagram. For simplicity, we start by creating a few calculated fields:

Sigmoid: This function helps in smoothing the curves of the flows.
\[ \frac{1}{1 + \exp(-t)} \]



### Conclusion
This Tableau project provides a comprehensive analysis of sales behavior using the Instacart dataset. By leveraging the power of visual analytics, we can uncover significant trends and patterns that can drive data-driven decisions for improving sales strategies and customer satisfaction.

Author Information
Business Analyst: Yasmin Ceballos
Last Updated: 20/06/2024
Contact Information
For any queries or further information, please contact Yasmin Ceballos at [yasmin.ceballos98@gmail.com].

This README file serves as an introduction and guide to understanding and using the Tableau project on sales behavior analysis. Follow the instructions provided to replicate the analysis and derive valuable insights from the dataset.


