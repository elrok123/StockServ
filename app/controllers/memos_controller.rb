class MemosController < ApplicationController

def create
	@memo = Memo.new(memo_params)
	 if @memo.save
		redirect_to 'memos/show'
	else
		render 'new'
	end
end

def edit
@memo = Memo.find(params[:id])
end




def show
		@memos = Array.new
	unless Memo.all.count > 1
		@memo << Memo.all.limit(1)
	else
		Memo.all.each do |memo|
			@memos << memo
		end
	end
end


def new
@memo = Memo.new
end

  def update
    @memo = Memo.find(params[:id])
 
    if @memo.update(memo_params)
      redirect_to @memo
    else
      render 'edit'
    end
  end


def destroy
  @memo = Memo.find(params[:id])
  @memo.destroy
 
  redirect_to memos_path
end

private
  def memo_params
    params.require(:memo).permit(:memo_description)
  end
end
