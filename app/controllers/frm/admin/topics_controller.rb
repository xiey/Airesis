module Frm
  module Admin
    class TopicsController < BaseController
      before_filter :find_topic

      def update
        if @topic.update_attributes(params[:frm_topic], as: :admin)
          flash[:notice] = t("frm.topic.updated")
          redirect_to group_forum_topic_url(@group,@topic.forum,@topic)
        else
          flash.alert = t("frm.topic.not_updated")
          render action: "edit"
        end
      end

      def destroy
        forum = @topic.forum
        @topic.destroy
        flash[:notice] = t("frm.topic.deleted")
        redirect_to group_forum_topics_url(@group,forum)
      end

      def toggle_hide
        @topic.toggle!(:hidden)
        flash[:notice] = t("frm.topic.hidden.#{@topic.hidden?}")
        redirect_to group_forum_topic_url(@group,@topic.forum, @topic)
      end

      def toggle_lock
        @topic.toggle!(:locked)
        flash[:notice] = t("frm.topic.locked.#{@topic.locked?}")
        redirect_to group_forum_topic_url(@group,@topic.forum, @topic)
      end

      def toggle_pin
        @topic.toggle!(:pinned)
        flash[:notice] = t("frm.topic.pinned.#{@topic.pinned?}")
        redirect_to group_forum_topic_url(@group,@topic.forum, @topic)
      end

      protected

      def topic_params
        params.require(:frm_topic).permit(:subject, :posts_attributes, :tags_list, :pinned, :locked, :hidden, :forum_id, as: :admin)
      end

      private
        def find_topic
          @topic = Frm::Topic.find(params[:id])
        end
    end
  end
end
