class AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end
  
  def show
    @album = Album.find(params[:id])
  end
  
  def new
    @band = Band.find(params[:band_id])
    @album = Album.new
  end
  
  def create
    @album = Ablum.new(album_params)
    
    if @album.save
      redirect_to album_url(@album.id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end
  
  def edit
    @album = Album.find(params[:id])
  end
  
  def update
    @album = Album.find(params[:id])
    @album.update_attributes(album_params)
    
    redirect_to album_url(@album)
  end
  
  def destroy
    @album = Album.find(params[:id])
    @album.destroy
  end
  
  private
  
  def album_params
    params.require(:album).permit(:name, :band_id, :year, :live)
  end
end
