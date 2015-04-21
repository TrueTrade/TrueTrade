class TestUsernamesController < ApplicationController
  before_action :set_test_username, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @test_usernames = TestUsername.all
    respond_with(@test_usernames)
  end

  def show
    respond_with(@test_username)
  end

  def new
    @test_username = TestUsername.new
    respond_with(@test_username)
  end

  def edit
  end

  def create
    @test_username = TestUsername.new(test_username_params)
    @test_username.save
    respond_with(@test_username)
  end

  def update
    @test_username.update(test_username_params)
    respond_with(@test_username)
  end

  def destroy
    @test_username.destroy
    respond_with(@test_username)
  end

  private
    def set_test_username
      @test_username = TestUsername.find(params[:id])
    end

    def test_username_params
      params.require(:test_username).permit(:name, :description, :picture)
    end
end
