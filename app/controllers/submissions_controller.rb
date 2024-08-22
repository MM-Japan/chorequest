class SubmissionsController < ApplicationController
  #---------#
  # click on the "complete"
  # user goes to the update form
  # upload the picture
  # submit

  def index
  end

  def new
    @submission = Submission.new
  end

  def edit
    @user = current_user

    @submission = Submission.find(params[:id])
  end

  def update
    @submission = Submission.find(params[:id])
    if current_user != @submission.user
      redirect_to tasks_path, notice: 'You are not the task owner'
      return
    end
    if @submission.status == "completed"
      redirect_to tasks_path, notice: 'You have already completed the task!'
      return
    end

    @submission.status = "completed"
    if @submission.save
      sleep(3)
      redirect_to tasks_path
    else
      render 'edit', status: :unprocessable_entity, notice: 'Submission failed'
    end
  end

  def destroy
  end

  private

  def submission_params
    params.require(:submission).permit(:status, :photo)
  end




end
