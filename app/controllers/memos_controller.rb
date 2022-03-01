class MemosController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy, :search]
  before_action :memo_info, only: [:edit, :update]

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

  def destroy
    memo = Memo.find(params[:id])
    if user_signed_in? && (current_user.id == memo.user_id)
      memo.destroy
      redirect_to root_path
    end
  end

  def search
    @memos = Memo.search(params[:keyword])
    # redirect_to action: :index if current_user.id != @memos.user_id
    render :index if params[:keyword] == ''
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
