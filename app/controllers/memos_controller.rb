class MemosController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :memo_info, only: [:show, :edit, :update]

  def index
    @memos = Memo.includes(:user).order('created_at DESC')
  end

  def new
    @memo = Memo.new
  end

  def create
    @memo = Memo.new(memo_params)
    if @memo.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  def show
  end
  
  def edit
    redirect_to action: :index if current_user.id != @memo.user_id
  end
  
  def update
    if @memo.update(memo_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:title_history, :why_content, :who_content, :what_content, :where_content,
                                 :content).merge(user_id: current_user.id)
  end
  
  def memo_info
    @memo = Memo.find(params[:id])
  end

end
