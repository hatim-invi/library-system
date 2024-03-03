class Admin::MembersController < AdminController
  load_and_authorize_resource

  def index
    @query = params[:query]
    @members = Member.get_data(params[:query]).paginate(page: params[:page], per_page: 30)
  end
  def show
    @member = Member.find(params[:id])
    @books_taken = BookCheckoutRecord.where(member_id: @member.id)
    @book_taken_info = []
    @books_taken.each do |taken|
      @book_taken_info << Book.find(taken.book_id)
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])

    if @member.update(member_params.merge(search_key_for_name: member_params[:name].downcase, search_key_for_surname: member_params[:surname].downcase))
      redirect_to admin_member_path(@member)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params.merge(search_key_for_name: member_params[:name].downcase, search_key_for_surname: member_params[:surname].downcase))

    if @member.save
      redirect_to admin_member_path(@member)
    else
      render :new, status: :unprocessable_entity
    end
  end


  private
    def member_params
      params.require(:member).permit(:name, :adhaar_number, :membership_start_date,:membership_end_date, :surname)
    end
end
