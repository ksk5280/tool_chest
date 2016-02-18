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
      redirect_to tool_path(@tool.id)
    else
      # else render new view to try again
      render :new
    end
  end

  def edit
    find_tool
  end

  def update
    find_tool
    if @tool.update(tool_params)
      redirect_to tool_path(@tool.id)
    else
      render :edit
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
