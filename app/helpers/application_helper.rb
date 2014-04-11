module ApplicationHelper
	def coderay(text)
		notes = text
		loops = notes.scan(/\<code(?: lang="(.+?)")?\>(.+?)\<\/code\>/m).length

		loops.times {
			notes.sub!(/\<code(?: lang="(.+?)")?\>(.+?)\<\/code\>/m) do
	      content_tag("notextile", CodeRay.scan($2, $1).div(:css => :class).html_safe)
			end
		}
		return notes
	end

	def new_comment(obj)
		@new_comment = Comment.build_from(obj, current_user, "")
		return @new_comment
	end
end
