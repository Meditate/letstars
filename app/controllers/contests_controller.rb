class ContestsController < ApplicationController
  before_action :find_contest, only: [:show,:update,:edit,:destroy]
  before_action :admin_validation, only: [:new,:edit,:destroy]

  def index
    @contests = Contest.all.order('created_at DESC')
  end

  def new
    @contest=Contest.new
  end

  def create
    @contest=Contest.new(contest_params)
    if @contest.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @profiles=Profile.all
    @musics = @contest.musics
    @music = Music.new
    
  end

  def edit

  end

  def update
    if @contest.update(contest_params)
      redirect_to @contest
    else
      render 'edit'
    end

  end

  def destroy
    @contest.destroy
    redirect_to root_path
  end


  private
    def admin_validation
      if current_user.role !='administrator'
        redirect_to root_path
      end
    end

    def contest_params
      params.require(:contest).permit(:title,:image,:description, :contest_end,:voting_end, :code)
    end

    def find_contest
      @contest=Contest.find(params[:id])
    end

end

