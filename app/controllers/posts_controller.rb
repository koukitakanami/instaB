class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all
  end

  def new
    if params[:back]
      @post = Post.new(posts_params)
    else
      @post = Post.new
    end
  end
  
  
  def create
    @post = Post.new(posts_params)
    @post.user_id = current_user.id
    #Post.create(posts_params)
    if @post.save
      redirect_to posts_path, notice: "投稿しました！"
      #NoticeMailer.sendmail_blog(@post).deliver
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update(posts_params)
    redirect_to posts_path, notice: "編集しました！"
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "削除しました！"
  end
  
  private
  def posts_params
     params.require(:post).permit(:title, :content, :image, :image_cache)
  end
  
end
