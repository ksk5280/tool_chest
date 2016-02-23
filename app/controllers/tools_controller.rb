class ToolsController < ApplicationController
  def index
    @tools = Tool.all
  end

  def show
    find_tool
  end

  def new
    @tool = Tool.new
  end

  def create
    # Generate tool
    # add attributes
    @tool = Tool.new(tool_params)
    # try to save
    if @tool.save
      # if it saves, send user to view tool
      flash[:notice] = "#{@tool.name} was created!"
      session[:most_recent_tool_id] = @tool.id
      session[:current_tool_count] = session[:current_tool_count] + @tool.quantity
      session[:current_potential_revenue] = session[:current_potential_revenue] + (@tool.price * @tool.quantity)
      redirect_to tool_path(@tool.id)
    else
      # else render new view to try again
      flash[:error] = @tool.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    find_tool
  end

  def update
    find_tool
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
    @tool = Tool.find(params[:id])
  end

  def tool_params
    params.require(:tool).permit(:name, :quantity, :price)
  end
end
