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
   @posts = Post.all
  end
  
end
