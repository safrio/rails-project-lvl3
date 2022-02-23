class AddMeAsAdmin < ActiveRecord::Migration[6.1]
  def change
    User.find_or_create_by(email: 'safrio@gmail.com', name: 'safrio').update(admin: true)
  end
end
