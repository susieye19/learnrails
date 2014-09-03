ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Comments" do
          table_for Comment.order("updated_at DESC").limit(10) do
            column "Type", :commentable_type
            column "Title" do |comment|
              @type = comment.commentable_type
              @id = comment.commentable_id
              if @type == "Question"
                link_to Question.find(@id).subject, question_path(@id)
              elsif @type == "Chapter"
                @course = Chapter.find(@id).course
                link_to Chapter.find(@id).title, course_chapter_path(@course.id, @id)
              elsif comment.commentable_type == "Video"
                link_to Video.find(@id).title, video_path(@id)
              end
            end
            column "Text", :body
            column "User", :user_name
          end
        end

        panel "New Users" do
          table_for User.order("created_at DESC").limit(10) do
            column :id
            column :name
            column :email 
            column :plan
          end
        end
      end
    end

  end
end
