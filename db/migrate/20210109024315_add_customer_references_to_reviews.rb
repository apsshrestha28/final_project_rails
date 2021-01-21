class AddCustomerReferencesToReviews < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :customer, null: false, foreign_key: true
  end
end
