class ChangeClientToEmployer < ActiveRecord::Migration[5.1]
  def up
    User.find_each do |user|
      if user.account_type = "client"
        user.account_type = "employer"
        user.save!
      end
    end
  end
  def down
    User.find_each do |user|
      if user.account_type = "employer"
        user.account_Type = "client"
        user.save!
      end
    end
  end
end
