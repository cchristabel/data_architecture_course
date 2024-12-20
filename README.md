# data_architecture_course

# Introduction
This project involved individually designing a database to represent an eCommerce website, Dressman. The database was modeled to provide users access to all typical eCommerce functionalities, such as login, personal details, payment methods, and product catalogs. The project was divided into two parts:
## 1. Entity Relationship Diagram (ERD):
A logical ERD was created to represent the database, detailing all tables, columns, data types, relationships, and cardinalities.

## 2. Database Implementation in MS-SQL:
The database was implemented using MS-SQL syntax, creating all necessary tables and relationships. Once the database was complete, queries were designed to retrieve and manipulate the data.

### Part 1 – Entity Relationship Diagram
A logical ERD was created using a tool like Draw.io. It depicted the database structure, including:
- All tables and their columns.
- Data types for each column.
- Relationships and cardinalities between tables.
  
### Part 2 – The Database
The database was designed to meet several requirements provided by the client, ensuring it could support common eCommerce functionalities. The database included the following key features:
- Account Creation:
Users could create accounts and log in to the website.

- Contact Details:
Users could store all their contact details in the database.

- Addresses:
Users could store multiple addresses.
One address was marked as the default address for product delivery.

- Payment Methods:
Users could save multiple payment methods (e.g., Credit Card, Klarna, PayPal).
One payment method was marked as the default.

- Products:
The website offered a variety of products.
Each product was assigned to a category.

- Categories:
Products belonged to categories.
Categories could be nested, meaning a category could belong to another category.

- Quantity Tracking:
The database tracked the inventory levels for each product.

- Shopping Cart:
Users could add one or more products to their shopping cart.

- Order Status:
Orders could have multiple statuses, such as:
Processing
Out for delivery
Delivered

- Promotions:
Products could be offered at a discount (% off the original price) for a specific time period.

### Conclusion
The final deliverables included a fully modeled ERD, a complete MS-SQL implementation of the database, and several queries to demonstrate its functionality. This database design provided a comprehensive solution for supporting the Dressman eCommerce website.
