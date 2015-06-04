class AddTechnologyToMeetups < ActiveRecord::Migration
  def change
    add_reference :meetups, :technology, index: true, foreign_key: true
  end
end
