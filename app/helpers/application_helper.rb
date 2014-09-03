module ApplicationHelper
	def coderay(text)
		notes = text

		loops = notes.scan(/\<code(?: lang="(.+?)")\>(.+?)\<\/code\>/m).length

		loops.times {
			notes.sub!(/\<code(?: lang="(.+?)")\>(.+?)\<\/code\>/m) do
	      content_tag("notextile", CodeRay.scan($2, $1).div(:css => :class).html_safe)
			end
		}
		return notes
	end
end
