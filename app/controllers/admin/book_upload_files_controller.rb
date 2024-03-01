class Admin::BookUploadFilesController < ApplicationController

  def index
    @errors = BookUploadFile.last.file_errors
    respond_to do |format|
      format.xlsx {
        response.headers[
        'Content-Disposition'
      ] = "attachment; filename=books_upload_errors.xlsx"

      }
      format.html { render :index }
    end
  end

  def create
    upload_file = BookUploadFile.new
    upload_file.file = params[:file]
    upload_file.save
    BookUploadFile.add_books(upload_file.id)
    redirect_to "/admin/books" , notice: "Adding Books to inventory"
  end
end
