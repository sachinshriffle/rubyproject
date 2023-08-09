require 'config/routes.rb'
Rails.application.routes.draw do
  root "articles#index"

  get "/articles", to: "articles#index"
end

class ArticlesController < ApplicationController
  def index
  end
end
