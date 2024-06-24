# InstaCart-Tableau-Analysis
**Grocery Basket Analysis**

# Project Title: Sales Behavior Analysis Using Instacart Online Grocery Dataset
## Introduction
This Tableau project aims to analyze and identify sales behavior patterns using the Instacart Online Grocery Basket Analysis dataset. The dataset, sourced from Kaggle, contains detailed information about customer purchases, including products, order history, and department-wise segmentation. Our analysis focuses on understanding the sales trends, customer purchasing behavior, and the probability of product purchases across different departments.

### Data Source
**1. Dataset:** Instacart Online Grocery Basket Analysis
**2. Source:** Kaggle https://www.kaggle.com/datasets/yasserh/instacart-online-grocery-basket-analysis-dataset
**3. Description** This dataset contains a large number of grocery orders over time. Each order is represented by a series of products purchased, along with metadata about the order itself.

### Objectives
**1. Sales Trends:** Identify and visualize the trends in sales across different time periods.
**2. Customer Behavior:** Analyze customer purchasing patterns and behaviors.
**3. Departmental Insights:** Provide insights into the performance of various product departments.
**4. Purchase Probability:** Calculate and visualize the probability of products being purchased again.

### Key Metrics
**1. Order Count:** Number of orders placed.
**2. Product Frequency:** Frequency of each product being ordered.
**3. Department Performance:** Sales performance metrics for different departments such as dairy, beverages, snacks, etc.
**4. Reorder Probability:** Likelihood of a product being reordered by customers.

### Visualizations
**1. Sales Trends Over Time:** Line charts showcasing the trend of sales over various time periods.
**2. Customer Purchase Behavior:** Heatmaps and bar charts illustrating customer purchase frequencies and patterns.
**3. Department-wise Performance:** Pie charts and bar charts representing the sales distribution among different departments.
**4. Reorder Probability Analysis:** Polygons and scatter plots showing the probability of product reorders.

### Data Dictionary
**1. Order ID:** Unique identifier for each order.
**2. Product ID:** Unique identifier for each product.
**3. Add to Cart Order:** Sequence in which products were added to the cart.
**4. Reordered:** Binary indicator of whether the product has been ordered previously.
**5. Department:** Category to which the product belongs.

### Usage Instructions
**1. Data Preparation:** Download the dataset from Kaggle, understand relation between variables and ensure it is properly formatted for Tableau.

![Relation diagram](https://github.com/Yceballos/InstaCart-Tableau-Analysis/assets/90511756/1d307444-2e6e-4e51-82e9-7c2c46de9ee5)

If you need to load .db extensions in tablee, I recommend to read: https://community.tableau.com/s/question/0D54T00000C6O8ASAV/connect-to-a-db-file

**2. Tableau Workbook:** Open the Tableau workbook provided with the project.
**3. Data Connection:** Connect the downloaded dataset to the Tableau workbook.
**4. Visualization Customization:** Customize the visualizations as per your requirements by adjusting filters, colors, and chart types.
**5. Insights Extraction:** Use the visualizations to extract meaningful insights about sales trends and customer behaviors.

### How to make purchase probability analysis
I strongly recommend to check this video, he really helps me to build my dashboard: https://www.youtube.com/watch?v=mxpDaRYRRdY 
For general licenses we don´t have the option to plot Sandkey graphs.

A Sankey diagram is a type of flow diagram where the width of the arrows is proportional to the flow rate. It is particularly useful for visualizing the distribution and flow of resources or information between different stages or categories.

Steps to Create a Sankey Diagram in Tableau

#### Prepare the Data:
Ensure your data is structured properly. The uploaded data contains points essential for creating a Sankey diagram. Here's a brief look at the data structure: https://docs.google.com/spreadsheets/d/1iPiNQTOiqTGBqYgluxoH9F7clcXEpmlA2wntwiWo054/edit?gid=0#gid=0

Take into account that we need to create an specific script to transform data for sandkey diagram, we need colum1 -> product_previously_purchased and column2 -> product_purchased

#### Data Points Explanation:

**1. Link:** Represents the connection between nodes in the Sankey diagram.
**2. t:** Likely a parameter related to time or sequence.
**3. Path:** Represents the specific path in the diagram.
**4. Way of the walk:** Describes the route or method of progression in the diagram.

#### Create a Calculated Field:
You need to create several calculated fields to define the curvature and flow of the Sankey diagram. For simplicity, we start by creating a few calculated fields:

**1. Sigmoid:** This function helps in smoothing the curves of the flows.
$1/(1+exp(-t))$
**2. Link Position:** This field helps in positioning the links in the diagram.
$[Path] + [Sigmoid]$
**3. Flow size indicator:** This field will help us indicate the size of the flow, in this case we are going to use the number of orders.
$COUNTD([Order Id])$
**4. Flow size:** Will indicate the flow size.
   Note that we use TOTAL formula to determine the total (sum) of numbers
$[Flow Size Indicator]/TOTAL([Flow Size Indicator])$

Other calculations:

**Point A**

**1. Point A bar position:** This field helps in determining the starting position of the bars.
$RUNNING_SUM(1/(SIZE()+1))+RUNNING_SUM([Flow Size]) - [Flow Size]$
**2. Point A Index:** This field assigns an index to each row, which is useful for positioning.
$INDEX()$
**3. Point A Position:** This field normalizes the index to ensure uniform spacing. By dividing the index by the total size plus one, we ensure that the points are evenly distributed.
$[Point A Index]/(SIZE()+1)$
**4. Point A Position Max:** This field calculates the maximum position for Point A by adding the cumulative size of the flow. Adds the cumulative size of the flow to the normalized position, determining the endpoint of the flow.
$[Point A Position] + RUNNING_SUM([Flow Size])$
**5. Point A Position Min:** This field calculates the minimum position for Point A by subtracting the flow size from the maximum position. Subtracts the flow size from the maximum position to find the starting point of the flow.
$[Point A Position Max]-[Flow Size]$


**Point B**

**1. Point B bar position:** This field helps in determining the starting position of the bars.
$RUNNING_SUM(1/(SIZE()+1))+RUNNING_SUM([Flow Size]) - [Flow Size]$
**2. Point B Index:** This field assigns an index to each row, which is useful for positioning.
$INDEX()$
**3. Point B Position:** This field normalizes the index to ensure uniform spacing. By dividing the index by the total size plus one, we ensure that the points are evenly distributed.
$[Point B Index]/(SIZE()+1)$
**4. Point B Position Max:** This field calculates the maximum position for Point B by adding the cumulative size of the flow. Adds the cumulative size of the flow to the normalized position, determining the endpoint of the flow.
$[Point B Position] + RUNNING_SUM([Flow Size])$
**5. Point B Position Min:** This field calculates the minimum position for Point B by subtracting the flow size from the maximum position. Subtracts the flow size from the maximum position to find the starting point of the flow.
$[Point B Position Max]-[Flow Size]$


**Curve**
To create the curved paths typical in Sankey diagrams, we need to incorporate a sigmoid function for smoothness and calculate the curve between points A and B.

**1. Curve:** This formula calculates the intermediate points along the curve from A to B using the sigmoid function to ensure smoothness.
$[Point A Position]+([Point B Position]-[Point A Position])*ATTR([Sigmoid])$
**2. Curve Max:** Help us calculate curve poligonic.
$[Point A Position Max]+([Point B Position Max]-[Point A Position Max]) * ATTR([Sigmoid])$
**3. Curve Min:** Help us calculate curve poligonic.
$[Point A Position Min]+([Point B Position Min]-[Point A Position Min]) * ATTR([Sigmoid])$
**4. Curve Poligonic:** Uses a CASE statement to assign either the minimum or maximum curve value based on the "Way of the walk".
$CASE ATTR([Way of the walk]) WHEN 'Min' THEN [Curve Min] WHEN 'Max' THEN [Curve Max] END$

#### Plotting the Data:
**1. Rows and Columns:** Place the calculated fields in the Rows and Columns shelves to plot the data points.
**2. Dual-Axis:** Use a dual-axis to overlay the paths and links to form a smooth flow.
**3. Path Shelf:** Use the Path field to ensure that Tableau connects the points in sequence.

![image](https://github.com/Yceballos/InstaCart-Tableau-Analysis/assets/90511756/e22ad390-3b06-4596-bfd0-1f73040688ed)

**The key is to edit table calculation:**
For A Values, Flow Size and B Values
![image](https://github.com/Yceballos/InstaCart-Tableau-Analysis/assets/90511756/f30b36c9-4b1d-4ec1-b0e3-59249b1b518f)


#### Customize the Visualization:
**1. Color and Size:** Adjust the color and size of the flows to represent different categories or volumes.
**2. Filters:** Use filters to allow users to focus on specific parts of the Sankey diagram.

#### Final Adjustments:
**1. Tooltips:** Customize tooltips to display relevant information about each flow.
**2. Labels:** Add labels to nodes and flows for better readability.
**3. Interactivity:** Ensure the diagram is interactive, allowing users to explore different paths and flows.

#### Example Visualization Process
**1. Initial Setup:** Import your dataset into Tableau.
**2. Create the necessary calculated fields as mentioned above.**
**3. Building the Diagram:** Drag Link Position to Columns.
* Drag t to Rows.
* Create a dual-axis by right-clicking on the axis and selecting "Dual-Axis".
* Synchronize the axes.

**4. Customization:**
* Use the Path on the Path shelf to connect points.
* Adjust colors and sizes using the Link and Way of the walk fields.
* By following these steps, you can effectively create a Sankey diagram in Tableau using the provided data without needing any additional extensions. The key is to
* properly structure your data and use calculated fields to define the flow and curvature of the diagram.

### Conclusion
This Tableau project provides a comprehensive analysis of sales behavior using the Instacart dataset. By leveraging the power of visual analytics, we can uncover significant trends and patterns that can drive data-driven decisions for improving sales strategies and customer satisfaction.

Author Information
Business Analyst: Yasmin Ceballos
Last Updated: 20/06/2024

This README file serves as an introduction and guide to understanding and using the Tableau project on sales behavior analysis. Follow the instructions provided to replicate the analysis and derive valuable insights from the dataset.


