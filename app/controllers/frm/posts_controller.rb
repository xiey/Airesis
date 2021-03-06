module Frm
  class PostsController < Frm::ApplicationController
    before_filter :authenticate_user!
    before_filter :find_topic
    before_filter :reject_locked_topic!, only: [:create]
    before_filter :block_spammers, only: [:new, :create]
    before_filter :authorize_reply_for_topic!, only: [:new, :create]
    before_filter :authorize_edit_post_for_forum!, only: [:edit, :update]
    before_filter :find_post_for_topic, only: [:edit, :update, :destroy]
    before_filter :ensure_post_ownership!, only: [:destroy]

    def new
      @post = @topic.posts.build
      find_reply_to_post

      @post.text = view_context.forem_quote(@reply_to_post.text) if params[:quote]
    end

    def create
      @post = @topic.posts.build(params[:frm_post])
      @post.user = current_user

      if @post.save
        create_successful
      else
        create_failed
      end
    end

    def edit
    end

    def update
      if @post.owner_or_moderator?(current_user) && @post.update_attributes(params[:frm_post])
        update_successful
      else
        update_failed
      end
    end

    def destroy
      @post.destroy
      destroy_successful
    end


    protected

    def post_params
      params.require(:frm_post).permit(:text, :reply_to_id)
    end

    private

    def authorize_reply_for_topic!
      authorize! :reply, @topic
    end

    def authorize_edit_post_for_forum!
      authorize! :edit_post, @topic.forum
    end

    def create_successful
      flash[:notice] = t("frm.post.created")
      redirect_to group_forum_topic_url(@group, @topic.forum, @topic, page: @topic.last_page)
    end

    def create_failed
      params[:reply_to_id] = params[:post][:reply_to_id]
      flash.now.alert = t("frm.post.not_created")
      render action: "new"
    end

    def destroy_successful
      if @post.topic.posts.count == 0
        @post.topic.destroy
        flash[:notice] = t("frm.post.deleted_with_topic")
        redirect_to group_forum_url(@group,@topic.forum)
      else
        flash[:notice] = t("frm.post.deleted")
        redirect_to group_forum_topic_url(@group,@topic.forum,@topic)
      end
    end

    def update_successful
      redirect_to group_forum_topic_url(@group,@topic.forum, @topic), notice: t('edited', scope: 'frm.post')
    end

    def update_failed
      flash.now.alert = t("frm.post.not_edited")
      render action: "edit"
    end

    def ensure_post_ownership!
      unless @post.owner_or_moderator? current_user
        flash[:alert] = t("frm.post.cannot_delete")
        redirect_to group_forum_topic_url(@group,@topic.forum, @topic) and return
      end
    end

    def find_topic
      @topic = Frm::Topic.find params[:topic_id]
    end

    def find_post_for_topic
      @post = @topic.posts.find params[:id]
    end

    def block_spammers
      if current_user.forem_spammer?
        flash[:alert] = t('frm.general.flagged_for_spam') + ' ' +
                        t('frm.general.cannot_create_post')
        redirect_to :back
      end
    end

    def reject_locked_topic!
      if @topic.locked?
        flash.alert = t("frm.post.not_created_topic_locked")
        redirect_to group_forum_topic_url(@group,@topic.forum, @topic) and return
      end
    end

    def find_reply_to_post
      @reply_to_post = @topic.posts.find_by_id(params[:reply_to_id])
    end
  end
end