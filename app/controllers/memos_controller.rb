class MemosController < ApplicationController
  def index
  end

  def new
    @memo = Memo.new
  end

  def create
    @memo = Memo.new(memo_params)
    if @memo.save
      redurect_to root_path
    else
      render:new
    end
  end

  private
  def memo_params
    params.require(:memo).permit(:title_history, :why_content, :who_content, :what_content, :where_content, :content).merge(user_id: current_user.id)
  end
end
