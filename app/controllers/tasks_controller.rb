class TasksController < ApplicationController
  def index
  	tasks = Task.where(user_id: current_user.id)
  	render json: tasks
	end

	def create
		task = Task.new(tasks_params.merge(user: current_user)) 

		if task.save
			render json: {
				status: 200,
				message: 'Created successfully.',
				data: task
			}, status: :ok
		else
			render json: {
				status: 400,
				message: "#{task.errors.full_messages.to_sentence}"
			}, status: :bad_request
		end
	end

	def update
		task = Task.find(params[:id])

		if task.update(tasks_params)
			render json: {
				status: 200,
				message: 'Updated successfully.',
				data: task
			}, status: :ok
		else
			render json: {
				status: 400,
				message: "#{task.errors.full_messages.to_sentence}"
			}, status: :bad_request
		end
	end

	def destroy
		task = Task.find(params[:id])

    if task.user == current_user
      task.destroy
      render json: { status: 204, message: 'Deleted successfully.' }, status: :no_content
    else
      render json: { status: 403, message: 'Unauthorized to delete task.' }, status: :forbidden
    end
	end

	private
	def tasks_params
			params.require(:task).permit(:title, :description, :price, :date, :place, :status)
	end
end
