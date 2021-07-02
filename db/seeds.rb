# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  email: "nhuthahuu@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  fullname: "Ha Huu Nhut",
  gender: 1,
  phone_number: "0386741177",
  date_of_birth: "12/06/1998",
  role: 1,
  address: "Ho Chi Minh"
)

(0..50).each do 
  User.create!(
    email: Faker::Internet.email,
    password: "123456",
    password_confirmation: "123456",
    fullname: Faker::Name.name,
    gender: Random.rand(2),
    phone_number: Faker::PhoneNumber.phone_number,
    date_of_birth: Faker::Date.forward(days: 500),
    address: Faker::Address.full_address
  )
end

Category.create!(
  id: 1,
  name: "Phone",
  childrens_attributes: [
    {
      name: "Xiaomi",
      parent_id: 1
    },
    {
      name: "Apple",
      parent_id: 1
    },
    {
      name: "Samsung",
      parent_id: 1
    },
    {
      name: "Oppo",
      parent_id: 1
    }
  ]
)

Category.create!(
  id: 6,
  name: "Laptop",
    childrens_attributes: [
    {
      name: "Asus",
      parent_id: 6
    },
    {
      name: "Lenovo",
      parent_id: 6
    },
    {
      name: "Macbook",
      parent_id: 6
    }
  ]
)

Category.create!(
  id: 10,
  name: "Accessories",
    childrens_attributes: [
    {
      name: "Head Phone",
      parent_id: 10
    },
    {
      name: "Adapter",
      parent_id: 10
    }
  ]
)

Category.create!(
  name: "New Arrivals"
)

Category.create!(
  name: "Fashion & Beauty"
)

Category.create!(
  name: "Kids & Babies Clothes"
)

Category.create!(
  name: "Men & Women Clothes"
)


Product.create!(
  name: "Samsung Galaxy S21",
  quatity: 50,
  category_id: 6,
  price: 17_990_000,
)

Product.create!(
  name: "Samsung Galaxy S20 FE",
  quatity: 10,
  category_id: 6,
  price: 15_490_000,
)

Product.create!(
  name: "Xiaomi Mi 11",
  quatity: 500,
  category_id: 4,
  price: 17_490_000,
)

Product.create!(
  name: "Xiaomi Redmi Note 10",
  quatity: 20,
  category_id: 4,
  price: 5_490_000,
)

Product.create!(
  name: "Iphone 12",
  quatity: 1000,
  category_id: 5,
  price: 21_990_000,
)

Product.create!(
  name: "Asus VivoBook X515MA",
  quatity: 1000,
  category_id: 8,
  price: 8_490_000,
)
