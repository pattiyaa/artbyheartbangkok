class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :login

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
end
