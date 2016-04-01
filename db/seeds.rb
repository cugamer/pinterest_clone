user = User.new(name: "Sample", 
  email: "sample@sample.com", 
  password: "password",
  password_confirmation: "password")
  
user.save
