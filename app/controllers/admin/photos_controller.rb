require 'digest/sha1'
class Admin::PhotosController < ApplicationController 
 layout "modal"

  def index
     @photos = Admin::Photo.all
     @newphoto = Admin::Photo.new(:title => "My photo \##{1 + (Admin::Photo.maximum(:id) || 0)}")
  end

  def new
    @newphoto = Admin::Photo.new(:title => "My photo \##{1 + (Admin::Photo.maximum(:id) || 0)}")
   
    if unsigned_mode?
      @unsigned = true
      # make sure we have the appropriate preset
      @preset_name = "sample_" + Digest::SHA1.hexdigest(Cloudinary.config.api_key + Cloudinary.config.api_secret)
      begin
        preset = Cloudinary::Api.upload_preset(@preset_name)
        if !preset["settings"]["return_delete_token"]
          Cloudinary::Api.update_upload_preset(@preset_name, :return_delete_token=>true)
        end
      rescue
        # An upload preset may contain (almost) all parameters that are used in upload. The following is just for illustration purposes
        Cloudinary::Api.create_upload_preset(:name => @preset_name, :unsigned => true, :folder => "preset_folder", :return_delete_token=>true)
      end
    end
    render view_for_new
  end

  def create
    
    if is_exist?
      if params[:imageable_type] == 'user' || params[:imageable_type] == 'article_cover'
        existPhoto = Admin::Photo.find_by( imageable_id: params[:imageable_id],imageable_type: params[:imageable_type])
        unless existPhoto.blank?
          existPhoto.update_columns(imageable_id: nil,imageable_type:nil)
        end
      end
      @photo = Admin::Photo.find(params[:admin_photo_id]);
      @photo.update_columns(imageable_id: params[:imageable_id],imageable_type: params[:imageable_type])

    else
      
      @photo = Admin::Photo.new(photo_params)
      @photo.imageable_id = params[:imageable_id]
      @photo.imageable_type = params[:imageable_type]
      # In through-the-server mode, the image is first uploaded to the Rails server.
      # When @photo is saved, Carrierwave uploads the image to Cloudinary.
      # The upload metadata (e.g. image size) is then available in the
      # uploader object of the model (@photo.image).
      # In direct mode, the image is uploaded to Cloudinary by the browser,
      # and upload metadata is available in JavaScript (see new_direct.html.erb).
    
      if !@photo.save
       
        @error = @photo.errors.full_messages.join('. ')
        
        return
      end
      if !direct_upload_mode?
        # In this sample, we want to store a part of the upload metadata
        # ("bytes" - the image size) in the Photo model.
        # In direct mode, we pass the image size via a hidden form field
        # filled by JavaScript (see new_direct.html.erb).
        # In through-the-server mode, we need to copy this field from Cloudinary
        # upload metadata. The metadata is only available after Carrierwave
        # performs the upload (in @photo.save), so we need to update the
        # already saved photo here.
        @photo.update_attributes(:bytes => @photo.image.metadata['bytes'])
        
        # Show upload metadata in the view
        # @upload = @photo.image.metadata
      end
    end
    if params[:redirectturl].present?
      redirect_to params[:redirectturl] and return
    else
      return
    end 
  end

  
  protected
  def direct_upload_mode?
    params[:direct].present?
  end
  
  def unsigned_mode?
    params[:unsigned].present?
  end
  def is_exist?
    params[:admin_photo_id].present?
  end
  def view_for_new
    direct_upload_mode? ? "new_direct" : "new"
  end
  def photo_params
    params.require(:admin_photo).permit(:title, :bytes, :image, :image_cache)
  end

end