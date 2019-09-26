# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: 'Admin', email: 'admin@admin.com', password: 'admin123', password_confirmation: 'admin123', is_admin: true)
10.times do
    User.create(name: Faker::Name.name, email: Faker::Internet.email, password: 'password', password_confirmation: 'password', is_admin: false)     
end
# Question.all.each do |question|
#     unless question.answers.blank?
#         answer = question.answers.order(created_at: :desc).first.answer
#         question.update_attributes(lastest_answer: answer)    
#     end    
# end