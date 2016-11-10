class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :login,:getArticlesImg,:getLastUpdate

	def login
		loginid = 1
	  	@admin_user_login = Admin::User.find(loginid)
	  	@admin_user_login.photo = Admin::Photo.find_by( imageable_id: loginid,imageable_type: "user")
	end
	def respond_modal_with(*args, &blk)
	    options = args.extract_options!
	    options[:responder] = ModalResponder
	    respond_with *args, options, &blk
  	end
  	def getArticlesImg(admin_articles)
      
    		admin_articles.each do |article|
       		article.coverphoto = Admin::Photo.find_by( imageable_id: article.id,imageable_type: "article_cover")
      	end

    	return admin_articles
  	end
  	def getLastUpdate(updated_at)
  		
  		diff = (Time.zone.now - updated_at).to_i / 1.day 
  		if diff > 0
  			lastupdated = diff.to_s+' days'
  		else
  			diff = ((Time.zone.now - updated_at).to_i / 1.hour).round
  			if diff > 0
  				lastupdated = diff.to_s+' hours'
  			else
  				diff = (Time.zone.now - updated_at).to_i
  				lastupdated = diff.to_s+' mins'
  			end
  		end
  		return 'Last updated ' + lastupdated +' ago'
  	end
end
