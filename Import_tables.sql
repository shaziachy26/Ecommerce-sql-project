COPY time_dim 
FROM 'E:\Ecommerce_data_SQL_project\SQL_Project_Ecommerce_Data\time_dim.csv' 
WITH (  FORMAT csv, HEADER, DELIMITER ',' );

COPY Trans_dim
FROM 'E:\Ecommerce_data_SQL_project\SQL_Project_Ecommerce_Data\Trans_dim.csv'
WITH (  FORMAT csv, HEADER, DELIMITER ',' );

COPY customer_dim
FROM 'E:\Ecommerce_data_SQL_project\SQL_Project_Ecommerce_Data\customer_dim.csv'
WITH (  FORMAT csv, HEADER, DELIMITER ',' );

COPY item_dim
FROM 'E:\Ecommerce_data_SQL_project\SQL_Project_Ecommerce_Data\item_dim.csv'
WITH (  FORMAT csv, HEADER, DELIMITER ',' );

COPY store_dim
FROM 'E:\Ecommerce_data_SQL_project\SQL_Project_Ecommerce_Data\store_dim.csv'
WITH (  FORMAT csv, HEADER, DELIMITER ',' );

COPY fact_table
FROM 'E:\Ecommerce_data_SQL_project\SQL_Project_Ecommerce_Data\fact_table.csv'
WITH (  FORMAT csv, HEADER, DELIMITER ',' );





