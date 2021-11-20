# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Admin.create!(
  email: "aa@gmail.com",
  password: "123456",
  )


Order.create!(
  customer_id: 1,
  name: "斉藤鈴木",
  address: "東京都渋谷区",
  postal_code: "0000000",
  total_price: "1800",
  payment_method: 0,
  status: 3,
  created_at: "2021-11-19"
  )

OrderDetail.create!(
  product_id: 1,
  order_id: 1,
  )


