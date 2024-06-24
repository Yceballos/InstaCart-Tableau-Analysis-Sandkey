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
1. Data Preparation: Download the dataset from Kaggle and ensure it is properly formatted for Tableau.
![Relation diagram](https://github.com/Yceballos/InstaCart-Tableau-Analysis/assets/90511756/1d307444-2e6e-4e51-82e9-7c2c46de9ee5)

3. Tableau Workbook: Open the Tableau workbook provided with the project.
4. Data Connection: Connect the downloaded dataset to the Tableau workbook.
5. Visualization Customization: Customize the visualizations as per your requirements by adjusting filters, colors, and chart types.
6. Insights Extraction: Use the visualizations to extract meaningful insights about sales trends and customer behaviors.

### How to make purchase probability analysis
I strongly recommend to check this video, he really helps me to build my dashboard: https://www.youtube.com/watch?v=mxpDaRYRRdY 
For general licenses we don´t have the option to plot Sandkey graphs.

A Sankey diagram is a type of flow diagram where the width of the arrows is proportional to the flow rate. It is particularly useful for visualizing the distribution and flow of resources or information between different stages or categories.

Steps to Create a Sankey Diagram in Tableau
Prepare the Data:
Ensure your data is structured properly. The uploaded data contains points essential for creating a Sankey diagram. Here's a brief look at the data structure: https://docs.google.com/spreadsheets/d/1iPiNQTOiqTGBqYgluxoH9F7clcXEpmlA2wntwiWo054/edit?gid=0#gid=0

#### Data Points Explanation:

1. Link: Represents the connection between nodes in the Sankey diagram.
2. t: Likely a parameter related to time or sequence.
3. Path: Represents the specific path in the diagram.
4. Way of the walk: Describes the route or method of progression in the diagram.

#### Create a Calculated Field:
You need to create several calculated fields to define the curvature and flow of the Sankey diagram. For simplicity, we start by creating a few calculated fields:

Sigmoid: This function helps in smoothing the curves of the flows.
\frac{1}{1 + \exp(-t)}



### Conclusion
This Tableau project provides a comprehensive analysis of sales behavior using the Instacart dataset. By leveraging the power of visual analytics, we can uncover significant trends and patterns that can drive data-driven decisions for improving sales strategies and customer satisfaction.

Author Information
Business Analyst: Yasmin Ceballos
Last Updated: 20/06/2024
Contact Information
For any queries or further information, please contact Yasmin Ceballos at [yasmin.ceballos98@gmail.com].

This README file serves as an introduction and guide to understanding and using the Tableau project on sales behavior analysis. Follow the instructions provided to replicate the analysis and derive valuable insights from the dataset.


