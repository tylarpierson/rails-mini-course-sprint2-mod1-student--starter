# Ruby on Rails - Intermediate Ruby on Rails - Migrations, Routing, Controllers - Project

## Setup

Clone the application and then bundle install. Then, create, migrate, and seed the database.

## Intro

This app is a partially completed API that will power a warehouse fulfillment client application. We have already built the customer and products portions but need to add orders and a way to associate orders with products.

Here is a breakdown of the existing data models for the application:

**`Customer`**

| attribute  | type     |
| ---------- | -------- |
| id         | integer  |
| email      | string   |
| created_at | datetime |
| updated_at | datetime |

**`Product`**

| attribute  | type     |
| ---------- | -------- |
| id         | integer  |
| name       | string   |
| cost_cents | integer  |
| inventory  | integer  |
| created_at | datetime |
| updated_at | datetime |

Here is a breakdown of the existing resource API for the application:

### Resources

| verb   | resource | route                 | controller#action        | note                   |
| ------ | -------- | --------------------- | ------------------------ | ---------------------- |
| GET    | customer | /api/v1/customers     | api/v1/customers#index   | list all customers     |
| POST   | customer | /api/v1/customers     | api/v1/customers#create  | create a customer      |
| GET    | customer | /api/v1/customers/:id | api/v1/customers#show    | get a customer         |
| PATCH  | customer | /api/v1/customers/:id | api/v1/customers#update  | update a customer      |
| PUT    | customer | /api/v1/customers/:id | api/v1/customers#update  | update a customer      |
| DELETE | customer | /api/v1/customers/:id | api/v1/customers#destroy | delete a customer      |
| GET    | product  | /api/v1/products      | api/v1/products#index    | list all products      |
| GET    | product  | /api/v1/products/:id  | api/v1/products#show     | get a specific product |

## Step One - Add Order and OrderProduct Models

Our application has customers and products, but now it needs to manage orders and order_products. For now we just need to set up the model files and the database to match our specifications below. Our application will be able to create and ship orders and add products to orders via order_products.

**`Order`**

| attribute   | type     |
| ----------- | -------- |
| id          | integer  |
| status      | string   |
| customer_id | integer  |
| created_at  | datetime |
| updated_at  | datetime |

**`OrderProduct`**

| attribute  | type     |
| ---------- | -------- |
| id         | integer  |
| order_id   | integer  |
| product_id | integer  |
| created_at | datetime |
| updated_at | datetime |

1. Create and run a migration for the orders table with the above columns and types
2. Create an Order ActiveRecord model file
3. Create and run a migration for the order_products table with the above columns and types
4. Create an OrderProduct ActiveRecord model file

## Step Two - Add Order Routes

We need to add new routes for our orders resource.

| verb | resource | route                                 | controller#action      | note                           |
| ---- | -------- | ------------------------------------- | ---------------------- | ------------------------------ |
| GET  | order    | /api/v1/orders                        | api/v1/orders#index    | list all orders                |
| GET  | order    | /api/v1/customers/:customer_id/orders | api/v1/orders#index    | list all orders for a customer |
| POST | order    | /api/v1/customers/:customer_id/orders | api/v1/orders#create   | create an order for a customer |
| GET  | order    | /api/v1/orders/:id                    | api/v1/orders#show     | get a specific order           |
| POST | order    | /api/v1/orders/:id/ship               | api/v1/orders#ship     | ship a specific order          |
| GET  | product  | /api/v1/orders/:order_id/products     | api/v1/products#index  | list all products for an order |
| POST | product  | /api/v1/orders/:order_id/products     | api/v1/products#create | add a product to an order      |

1. Add the order route to list all orders
2. Add the order route to show a specific order
3. Add a custom POST member route to the orders resource to `ship` an order
4. Nested within the order resource, add the products routes to list and create products
5. Nested within the customer resource, add the order routes to list and create orders
6. Limit new routes to only the ones expected above

## Step Three - Add Orders Controller

Create an orders controller and implement the `index`, `create`, `show` and `ship` actions to respond to the routes you created. All the actions should return an appropriate JSON response.

1. The orders index should work for showing all orders and orders scoped to a specific customer

   - If a `customer_id` param is present, set `@orders = Order.where(customer_id: params[:customer_id])`
   - If `customer_id` is not present, set `@orders = Order.all`
   - Render `@orders` as json

2. The orders `create` action should set the `customer_id` attribute and default the status to "pending"
3. The orders `show` action should get a specific order from the database
4. The custom `ship` action should update the order status to `"shipped"` and render the order as JSON
5. There should be no update or destroy actions
