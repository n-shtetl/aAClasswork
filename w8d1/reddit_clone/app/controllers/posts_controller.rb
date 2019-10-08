class PostsController < ApplicationController

  before_action :require_login

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id   
    if @post.save 
      redirect_to post_url(@post)
    else           
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit 
    @post = Post.find(params[:id])
    render :edit
  end 

  def update
    @post = current_user.posts.find_by(id: params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else                   
      flash[:errors] = @post.errors.full_messages   
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find_by(id: params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub_id)
  end 

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def post_params
    params.require(:post).permit(:title, :content, :url, :sub_id)
  end
end




class AlbumsController < ApplicationController
  def new

  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to band_url(@album.band_id)
    else
      flash[:errors] blahblahblah
    end
  end

  def album_params
    params.require(:album).permit(:title, :year, :band_id)
  end
end

<h2> Band Show Page </h2>

<form action="<%=album_url%>" method="post">
  <label>title
    <input type="text" name="album[title]" value="">
  </label>
  <input type="hidden" name="album[band_id]" value="<%=@band.id%>">
  <input type="submit" value="Add Album">
</form>