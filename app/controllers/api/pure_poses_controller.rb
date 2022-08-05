class Api::PurePosesController < ApplicationController
  def create
    @pure_pose = PurePose.new(pure_pose_params)

    @pure_pose.parse_base64(params[:pure_pose][:image])
    
    if @pure_pose.save
      render json: @pure_pose
    else
      render json: @pure_pose.errors, status: :unprocessable_entity
    end
  end
   
  private

  def pure_pose_params
    params.require(:pure_pose).permit(:image, :pure_shoulder_width, :user_id)
  end
end
