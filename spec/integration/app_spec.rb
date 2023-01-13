require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Chitter do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods
  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Chitter.new }

  context "GET to /" do
    it "returns the home page with peeps on it" do
      response = get('/')
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Chitter</h1>')
      peeps = Peep.all
      expect(response.body).to include(peeps[0].content)
      expect(response.body).to include(peeps[1].content)
      expect(response.body).to include(peeps[2].content)
    end
  end

  context "GET to /login" do
    it "returns the login page, with a form to input data" do
      response = get('/login')
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Login</h1>')
      expect(response.body).to include('<form action="/login" method="POST">')
      expect(response.body).to include('<input type="text" name="username">')
      expect(response.body).to include('<input type="text" name="password">')
    end
  end

  context "GET to /register" do
    it "returns the register page, with a form to input data" do
      response = get('/register')
      expect(response.status).to eq 200
      expect(response.body).to include('<form action="/register" method="POST">')
      expect(response.body).to include('<input type="hidden" name="password">')
      expect(response.body).to include('<input type="text" name="name">')
      expect(response.body).to include('<input type="text" name="email">')
    end
  end

  context "POST to /register" do
    it "adds a new user to the database" do

      # test_user = Hash.new
      # test_user[username] = 'tester1'
      # test_user[name] = 'Testy Mctester', 
      # test_user[email] = 'tester@gmail.com',
      # test_user[password] = 'password'

      response = post(
        '/register', 
        username: 'tester1', 
        name: 'Testy Mctester', 
        email: 'tester@gmail.com',
        password: 'password'
      )
      
      expect(User.where("username = 'tester1'").blank?).to eq false

    end
  end

end