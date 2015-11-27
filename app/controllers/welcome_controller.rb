class WelcomeController < ApplicationController
  def welcomepage
  end
  
  def about
  end
  
  def contact
  end
  
  def help
  end

  def api
  end

 
  
  def home
   @posts = Post.all.by_hot_score.latest.five_days_ago.paginate(page: params[:page])
  end
  
end
