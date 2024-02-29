class Admin::BookCheckoutRecordsController < AdminController
  def book_info
    book_copy_id = params[:book_copy_id]
    book_copy = BookCopy.joins(:book).find(book_copy_id)
    shelf = Shelf.joins(racker: { section: :room }).find(book_copy.shelf_id)
    location = {
      "room":shelf.racker.section.room.name,
      "section": shelf.racker.section.name,
      "racker": shelf.racker.name,
      "shelf": shelf.name
    }
    data = {"location":location, "book":book_copy.book}
    render json: data
  end

  def members_adhaar_number
    adhaar_numbers = Member.select(:id,'adhaar_number as name').all
    render json: adhaar_numbers
  end

  def member_info
    member = Member.find(params[:id])
    render json:member
  end

  def checkout
    begin
      book_copy_id = params[:book_copy_id]
      book_id = params[:book_id]
      rented_on = Date.today
      member_id = params[:member_id]

      # Attempt to create a new BookCheckoutRecord
      BookCheckoutRecord.create!(
        book_copy_id: book_copy_id,
        member_id: member_id,
        book_id: book_id,
        rented_on: rented_on,
        return_by: rented_on + 30
      )

      # Attempt to update the availability of the BookCopy
      BookCopy.find(book_copy_id).update!(availability: false)

      # Return success: true if both operations succeed
      render json: { success: true }
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
      # Handle any exceptions that occur during the process
      # Revert changes if necessary and return success: false
      if e.record.is_a?(BookCheckoutRecord)
        # Delete the created BookCheckoutRecord if it was created
        e.record.destroy if e.record.persisted?
      elsif e.record.is_a?(BookCopy)
        # Reset the availability of the BookCopy if it was updated
        e.record.reload
        e.record.update(availability: true)
      end

      render json: { success: false, error: e.message }
    end
  end

end
