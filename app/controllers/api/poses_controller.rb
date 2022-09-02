class Api::PosesController < ApplicationController
  before_action :authenticate!
  skip_before_action :require_login

  def index
    @best_pose = login_user.poses.all.order(shoulder_width: :asc).first # @pose保存前の最小値を取得
    @pure_pose = PurePose.find_by(user_id: login_user.id)
    if @best_pose && @pure_pose.pure_shoulder_width > @best_pose.shoulder_width
      @best_pose.image = encode_base64(@best_pose.pose_image)
      render json: { "best_pose" => @best_pose,
                     "best_image" => @best_pose.image
                   }
    else
      render json: { "best_pose" => nil,
                     "best_image" => nil
                   }
    end
  end
  
  def create
    @pose = login_user.poses.build(pose_params)
    @pose.parse_base64(params[:pose][:image])

    @pure_pose = PurePose.find_by(user_id: login_user.id)
    @best_pose = login_user.poses.all.order(shoulder_width: :asc).first # @pose保存前の最小値を取得

    if @pose.save
      @pose.image = encode_base64(@pose.pose_image)

      if @pure_pose.pure_shoulder_width > @pose.shoulder_width && @best_pose == nil
        @score = @pure_pose.pure_shoulder_width - @pose.shoulder_width
        @result = login_user.results.create(score: @score, comment: "自己ベスト！", pose_id: @pose.id)
        render json: { "result" => @result,
                       "pose" => @pose,
                       "image" => @pose.image
                     }
      elsif @pure_pose.pure_shoulder_width > @pose.shoulder_width && @best_pose
        @score = @pure_pose.pure_shoulder_width - @pose.shoulder_width

        if @pose.shoulder_width < @best_pose.shoulder_width
          @result = login_user.results.create(score: @score, comment: "自己ベスト更新！", pose_id: @pose.id)
          render json: { "result" => @result,
                         "pose" => @pose,
                         "image" => @pose.image
                       }
        else
          @result = login_user.results.create(score: @score, comment: "まだノビシロあるよ", pose_id: @pose.id)
          render json: { "result" => @result,
                         "pose" => @pose,
                         "image" => @pose.image
                       }
        end
      elsif @pure_pose.pure_shoulder_width <= @pose.shoulder_width && @best_pose
        @result = login_user.results.create(score: 0, comment: "ポイントを見直しましょう", pose_id: @pose.id)
        render json: { "result" => @result,
                       "pose" => @pose,
                       "image" => @pose.image
                     }
      else
        @result = login_user.results.create(score: 0, comment: "1mmも華奢になれてません", pose_id: @pose.id)
        render json: { "result" => @result,
                       "pose" => @pose,
                       "image" => @pose.image
                     }
      end
    else
      render json: @pose.errors, status: :unprocessable_entity
    end
  end

  private

  def pose_params
    params.require(:pose).permit(:image, :shoulder_width)
  end

  def encode_base64(image_file)
    image = Base64.encode64(image_file.download)
    blob = ActiveStorage::Blob.find(image_file[:id])
    "data:#{blob[:content_type]};base64,#{image}"
  end
end
