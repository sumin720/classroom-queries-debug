class CoursesController < ApplicationController
  def index
    @courses = Course.all.order({ :created_at => :desc })

    render({ :template => "courses/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @course = Course.find(the_id)

    render({ :template => "courses/show" })
  end

  def create
    @course = Course.new
    @course.title = params.fetch("query_title", nil)
    @course.term_offered = params.fetch("query_term_offered", nil)
    @course.department_id = params.fetch("query_department_id", nil)
  
    if @course.save
      redirect_to("/courses", { notice: "Course created successfully." })
    else
      redirect_to("/courses", { alert: "Failed to create course." })
    end
  end
  
  def update
    id = params.fetch("path_id")
    @course = Course.find(id)
  
    @course.title = params.fetch("query_title", nil)
    @course.term_offered = params.fetch("query_term_offered", nil)
    @course.department_id = params.fetch("query_department_id", nil)
  
    if @course.save
      redirect_to("/courses/#{@course.id}", { notice: "Course updated successfully." })
    else
      redirect_to("/courses/#{@course.id}", { alert: "Course failed to update successfully." })
    end
  end
  

  def destroy
    the_id = params.fetch("path_id")
    @course = Course.find(the_id)

    @course.destroy
    redirect_to("/courses", { notice: "Course deleted successfully." })
  end

  private
  def course_params
    params.require(:course).permit(:title, :term_offered, :department)
  end
end
