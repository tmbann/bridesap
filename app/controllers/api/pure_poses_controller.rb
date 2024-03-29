class Api::PurePosesController < ApplicationController
  before_action :authenticate!
  skip_before_action :require_login
  skip_before_action :verify_authenticity_token

  def index
    @pure_pose = PurePose.find_by(user_id: login_user.id)
    if @pure_pose
      @pure_pose.image = encode_base64(@pure_pose.pure_pose_image)
      render json: { "pure_pose" => @pure_pose,
                     "pure_image" => @pure_pose.image
                   }
    else
      render json: { "pure_pose" => nil,
                     "pure_image" => nil
                   }
    end
  end
  
  def create
    @pure_pose = login_user.build_pure_pose(pure_pose_params)

    @pure_pose.parse_base64(params[:pure_pose][:image])
    
    if @pure_pose.save
      render json: @pure_pose
    else
      render json: @pure_pose.errors, status: :unprocessable_entity
    end
  end
   
  private

  def pure_pose_params
    params.require(:pure_pose).permit(:image, :pure_shoulder_width)
  end

  def encode_base64(image_file)
    image = Base64.encode64(image_file.download)
    blob = ActiveStorage::Blob.find(image_file[:id])
    "data:#{blob[:content_type]};base64,#{image}"
  end
end
