module PostsHelper
    def build_post_path(post)
    view_club_post_path(path: post.club.path, post_id: post.id)
    end
end
