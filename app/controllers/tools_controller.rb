class ToolsController < ApplicationController
  before_action :find_tool, only: [:show, :edit, :update]
  before_action :require_user

  def require_user
    redirect_to login_path unless current_user
  end

  def index
    @tools = current_user.tools
  end

  def show
  end

  def new
    @tool = Tool.new
  end

  def create
    # Generate tool
    # add attributes
    @tool = current_user.tools.new(tool_params)
    # try to save
    if @tool.save
      # if it saves, send user to view tool
      flash[:notice] = "#{@tool.name} was created!"
      session[:most_recent_tool_id] = @tool.id

      # @tool_summary.update(@tool)

      # moved this to application controller:
      if session[:current_tool_count]
        session[:current_tool_count] = session[:current_tool_count] + @tool.quantity
      else
        session[:current_tool_count] = @tool.quantity
      end
      if session[:current_potential_revenue]
        session[:current_potential_revenue] = session[:current_potential_revenue] + (@tool.price * @tool.quantity)
      else
        session[:current_potential_revenue] = @tool.price
      end

      redirect_to tool_path(@tool.id)
    else
      # else render new view to try again
      flash[:error] = @tool.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update
    if @tool.update(tool_params)
      redirect_to @tool
    else
      render :index
    end
  end

  def destroy
    # @tool = Tool.find(params[:id])
    # @tool.destroy
    Tool.destroy(params[:id])
    redirect_to tools_path
  end

  private

  def find_tool
    @tool = current_user.tools.find(params[:id])
  end

    def tool_params
    params.require(:tool).permit(:name, :quantity, :price, :category_id)
  end
end
