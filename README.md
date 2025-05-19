# README

🔧 How to Run This App:
1. Configure Database Settings
Open config/database.yml and update the credentials (username, password, database, etc.) to match your local database setup.

2. Run Database Migrations
Execute the following command in your terminal:
rails db:migrate

3. Start the Rails Server
Run this command to start the server:
rails server

🚀 API Usage:
Make sure the server is running at http://127.0.0.1:3000

4. Signup (Register New Account)
bash
Copy
Edit
curl --location 'http://127.0.0.1:3000/signup' \
--header 'Content-Type: application/json' \
--data '{
  "username": "rozakdev",
  "password": "secret123"
}'
5. Login
bash
Copy
Edit
curl --location 'http://127.0.0.1:3000/login' \
--header 'Content-Type: application/json' \
--data '{
  "username": "rozakdev",
  "password": "secret123"
}'
This will return an access token (JWT) and a refresh token.

6. List Categories
bash
Copy
Edit
curl --location 'http://127.0.0.1:3000/category' \
--header 'Authorization: Bearer <ACCESS_TOKEN>'
Replace <ACCESS_TOKEN> with the JWT received from login.

7. Create Product
bash
Copy
Edit
curl --location 'http://127.0.0.1:3000/products' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <ACCESS_TOKEN>' \
--data '{
  "category_code": "VL",
  "name": "RPF1 HSR A603X RING 18 SILVER",
  "size": "R18",
  "unit": "SET",
  "description": "Keren"
}'
8. Refresh Token
bash
Copy
Edit
curl --location 'http://127.0.0.1:3000/refresh' \
--header 'Content-Type: application/json' \
--data '{
  "refresh_token": "<REFRESH_TOKEN>"
}'
Replace <REFRESH_TOKEN> with the refresh token received during login.
