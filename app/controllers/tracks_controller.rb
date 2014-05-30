class TracksController < ApplicationController
  def index
    @tracks = Track.all
  end
  
  def show
    @track = Track.find(params[:id])
  end
  
  def new
    @track = Track.new
  end
  
  def create
    @track = Track.new(track_params)
    
    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end
  
  def edit
    @track = Track.find(params[:id])
  end
  
  def update
    @track = Track.find(params[:id])
    @track.update_attributes(track_params)
    
    redirect_to track_url(@track)
  end
  
  def destroy
    @track = Track.find(params[:id])
    @track.destroy
  end
  
  private
  
  def track_params
    params.require(:track).permit(:name, :track_number, :album_id, :bonus, :lyrics)
  end
end
