class StudentsController < ApplicationController
  def index
    @students = Student.all.order(created_at: :desc)
    render({ template: "students/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @student = Student.find(the_id)
    render({ template: "students/show" })
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to("/students", { notice: "Student created successfully." })
    else
      redirect_to("/students", { alert: "Student failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @student = Student.find(the_id)

    if @student.update(student_params)
      redirect_to("/students/#{@student.id}", { notice: "Student updated successfully." })
    else
      redirect_to("/students/#{@student.id}", { alert: "Student failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @student = Student.find(the_id)

    @student.destroy
    redirect_to("/students", { notice: "Student deleted successfully." })
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name, :email)
  end
end

