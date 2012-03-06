class PostSweeper < ActionController::Caching::Sweeper
  observe Post

  def after_create(post)
    expire_cache_for(post)
  end
 
  def after_update(post)
    expire_cache_for(post)
  end
 
  def after_destroy(post)
    expire_cache_for(post)
  end
  
  private
  
  def expire_cache_for(post)
    # Expire the short body of the post (used on index page)
    expire_fragment("post_#{post.id}_short_body")
    
    # Expire the full body of the post (used on the show page)
    expire_fragment("post_#{post.id}_full_body")
  end
end