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
curl --location 'http://127.0.0.1:3000/signup' \
--header 'Content-Type: application/json' \
--data '{
  "username": "rozakdev",
  "password": "secret123"
}'
5. Login
curl --location 'http://127.0.0.1:3000/login' \
--header 'Content-Type: application/json' \
--data '{
  "username": "rozakdev",
  "password": "secret123"
}'
This will return an access token (JWT) and a refresh token.
6. Refresh Token
curl --location 'http://127.0.0.1:3000/refresh' \
--header 'Content-Type: application/json' \
--data '{
  "refresh_token": "<REFRESH_TOKEN>"
}'
Replace <REFRESH_TOKEN> with the refresh token received during login.
7. List Categories
curl --location 'http://127.0.0.1:3000/category' \
--header 'Authorization: Bearer <ACCESS_TOKEN>'
Replace <ACCESS_TOKEN> with the JWT received from login.

8. Create Product
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
9. List Product
curl --location --globoff 'http://127.0.0.1:3000/products?start=0&length=10&search=&order=%7B%7D&draw=1&columns[]=' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3NDc3MjA4NjV9.GYQ9FAvUwYPH58QyIJ93wXbFWrg6t1HOTnEXke1I2ew'
10. Detail Product
curl --location 'http://127.0.0.1:3000/products/1' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3NDc3MjA4NjV9.GYQ9FAvUwYPH58QyIJ93wXbFWrg6t1HOTnEXke1I2ew'
11. Update Product
curl --location --request PUT 'http://127.0.0.1:3000/products/1' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3NDc3MjA4NjV9.GYQ9FAvUwYPH58QyIJ93wXbFWrg6t1HOTnEXke1I2ew' \
--data '{
    "category_code": "VL",
    "name": "RPF1 HSR A603X RING 18 SILVER",
    "size": "R17",
    "unit": "SET",
    "description": "Ganteng sekali",
    "image_path": null
}'
