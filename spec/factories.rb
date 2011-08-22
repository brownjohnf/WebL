Factory.define :user do |user|
  user.name              		 "Example User"
  user.email                 "person-x@example.com"
  user.password              "secret"
  user.password_confirmation "secret"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.sequence :name do |n|
  "person-#{n}"
end

Factory.define :post do |post|
	post.title 				"Dummy Title"
	post.content			"Dummy Content"
end
